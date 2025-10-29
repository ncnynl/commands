#!/bin/bash
################################################
# Function : Install yolov8
# Desc     : intall yolov8 in ubuntu                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-10-29                         
# Author   : endlessloops                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################

export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install yolov8")"

set -e

# ---------- CONFIG ----------
MIN_PYTHON="3.8"
MIN_TORCH="1.9.1"
MIN_TORCHVISION="0.10.1"
YOLO_VERSION="8.1.0"
PYTORCH_WHEEL_URL="https://download.pytorch.org/whl/torch_stable.html"
# ----------------------------

# --- Check Python version ---
echo "[INFO] Checking Python version..."
PY_VER=$(python3 -c "import sys; print('.'.join(map(str, sys.version_info[:3])))")
echo "[INFO] Python version: $PY_VER"
PY_MAJOR=$(echo $PY_VER | cut -d. -f1)
PY_MINOR=$(echo $PY_VER | cut -d. -f2)
if [ "$PY_MAJOR" -lt 3 ] || { [ "$PY_MAJOR" -eq 3 ] && [ "$PY_MINOR" -lt 8 ]; }; then
    echo "[ERROR] Python >= $MIN_PYTHON required. Exiting."
    exit 1
fi

# --- Detect CUDA (only check, no installation) ---
echo "[INFO] Detecting CUDA..."
if command -v nvcc >/dev/null 2>&1; then
    CUDA_VER=$(nvcc --version | grep "release" | awk '{print $6}' | cut -d',' -f1)
    echo "[INFO] CUDA detected! Version: $CUDA_VER"
    DEVICE="cuda"
elif [ -d "/usr/local/cuda" ]; then
    echo "[INFO] CUDA toolkit found at /usr/local/cuda"
    DEVICE="cuda"
else
    echo "[INFO] CUDA not detected. Using CPU-only mode."
    DEVICE="cpu"
fi

# --- Check Torch ---
TORCH_INSTALLED=0
TORCH_VERSION_OK=0
if python3 -c "import torch" &>/dev/null; then
    TORCH_INSTALLED=1
    TORCH_VER=$(python3 -c "import torch; print(torch.__version__)")
    TORCH_MAJOR=$(echo $TORCH_VER | cut -d. -f1)
    TORCH_MINOR=$(echo $TORCH_VER | cut -d. -f2)
    if [ "$TORCH_MAJOR" -gt 1 ] || { [ "$TORCH_MAJOR" -eq 1 ] && [ "$TORCH_MINOR" -ge 9 ]; }; then
        TORCH_VERSION_OK=1
    fi
fi

# --- Check TorchVision ---
TV_INSTALLED=0
TV_VERSION_OK=0
if python3 -c "import torchvision" &>/dev/null; then
    TV_INSTALLED=1
    TV_VER=$(python3 -c "import torchvision; print(torchvision.__version__)")
    TV_MAJOR=$(echo $TV_VER | cut -d. -f1)
    TV_MINOR=$(echo $TV_VER | cut -d. -f2)
    if [ "$TV_MAJOR" -gt 0 ] || { [ "$TV_MAJOR" -eq 0 ] && [ "$TV_MINOR" -ge 10 ]; }; then
        TV_VERSION_OK=1
    fi
fi

# --- Decide Torch/TorchVision action ---
if [ $TORCH_INSTALLED -eq 0 ] || [ $TV_INSTALLED -eq 0 ]; then
    if [ "$DEVICE" == "cpu" ]; then
        echo "[INFO] Torch or TorchVision not installed. Installing CPU versions..."
        pip3 install torch==1.9.1 torchvision==0.10.1
    else
        echo "[ERROR] Torch or TorchVision not installed. CUDA detected, please install CUDA-enabled versions manually."
        echo "Example:"
        echo "pip3 install torch==1.9.1+cu111 torchvision==0.10.1+cu111 -f $PYTORCH_WHEEL_URL"
        exit 1
    fi
else
    if [ $TORCH_VERSION_OK -eq 0 ]; then
        echo "[ERROR] Installed Torch version ($TORCH_VER) is below minimum required ($MIN_TORCH). Please upgrade."
        exit 1
    fi
    if [ $TV_VERSION_OK -eq 0 ]; then
        echo "[ERROR] Installed TorchVision version ($TV_VER) is below minimum required ($MIN_TORCHVISION). Please upgrade."
        exit 1
    fi
    echo "[INFO] Torch and TorchVision versions are sufficient."
fi

# --- Install other Python packages ---
echo "[INFO] Installing other dependencies..."
pip3 install "numpy>=1.24.0" "matplotlib>=3.7.0" "opencv-python>=4.8.0" "seaborn>=0.13.0" "tqdm" "pandas>=2.0.0" "scipy>=1.10.0" "thop>=0.1.1"
# --- Install YOLOv8 ---
echo "[INFO] Installing Ultralytics YOLOv8..."
pip3 install ultralytics==$YOLO_VERSION

# --- Verify YOLOv8 installation ---
YOLO_DIR="yolov8"
cd ~/tools
# Check if yolov8 folder exists
if [ ! -d "$YOLO_DIR" ]; then
    echo "[INFO] $YOLO_DIR folder not found. Creating..."
    mkdir -p "$YOLO_DIR"
    echo "[INFO] $YOLO_DIR folder created."
else
    echo "[INFO] $YOLO_DIR folder already exists."
fi

cd ~/tools/yolov8
echo "[INFO] Verifying YOLOv8 installation..."
python3 - <<EOF
import sys  
ok = True
try:
    import torch, ultralytics
    print("[INFO] Torch version:", torch.__version__)
    print("[INFO] CUDA available:", torch.cuda.is_available())
    print("[INFO] YOLOv8 version:", ultralytics.__version__)
    from ultralytics import YOLO
    try:
        model = YOLO("yolov8n.pt")
        results = model.predict("https://ultralytics.com/images/bus.jpg", device="$DEVICE", verbose=False)
        print("[INFO] YOLOv8 model loaded and dummy prediction succeeded.")
    except Exception as e:
        print("[ERROR] Model loading or dummy prediction failed:", e)
        ok = False
except Exception as e:
    print("[ERROR] YOLOv8 import failed:", e)
    ok = False

if ok:
    print("[INFO] YOLOv8 successfully installed and verified!")
    sys.exit(0)
else:
    print("[ERROR] YOLOv8 installation verification failed!")
    sys.exit(1)
EOF
