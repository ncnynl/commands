import platform
import psutil
import subprocess
from flask import Blueprint, render_template, jsonify,request
from user_agents import parse
import socket

# Blueprint
system_bp = Blueprint('system', __name__)

###################### function #######################

def get_ip_address():
    """获取主机 IP 地址"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return "未知 IP"

def get_disk_info(path="/"):
    """获取磁盘总量和剩余空间（GB）"""
    try:
        usage = psutil.disk_usage(path)
        return {
            "total_gb": round(usage.total / (1024**3), 2),
            "used_gb": round(usage.used / (1024**3), 2),
            "free_gb": round(usage.free / (1024**3), 2),
            "percent": usage.percent
        }
    except:
        return {"total_gb": 0, "used_gb": 0, "free_gb": 0, "percent": 0}

# --------------------- 客户端信息 ---------------------
def get_client_info():
    ua_string = request.headers.get('User-Agent')
    ua = parse(ua_string)
    client_info = {
        'os': f"{ua.os.family} {ua.os.version_string}",
        'browser': f"{ua.browser.family} {ua.browser.version_string}",
        'device': f"{ua.device.family}"
    }
    return client_info

def get_os_info():
    """
    返回系统操作系统信息，兼容 Linux、树莓派、Windows
    """
    try:
        os_name = platform.system()       # Linux / Windows / Darwin
        os_version = platform.release()   # 版本号
        if os_name == "Linux":
            # 尝试读取 /etc/os-release
            if os.path.exists("/etc/os-release"):
                with open("/etc/os-release") as f:
                    lines = f.readlines()
                os_info = {}
                for line in lines:
                    if "=" in line:
                        key, val = line.strip().split("=", 1)
                        os_info[key] = val.strip('"')
                pretty_name = os_info.get("PRETTY_NAME")
                if pretty_name:
                    return pretty_name
        return f"{os_name} {os_version}"
    except Exception as e:
        return f"未知系统 ({e})"

def get_cpu_model():
    """
    获取 CPU 型号，兼容树莓派 5 / 普通 Linux / Windows
    """
    try:
        # 树莓派专用
        if platform.system() == "Linux" and ("arm" in platform.machine().lower() or "aarch" in platform.machine().lower()):
            # 方法1: /proc/device-tree/model
            try:
                if os.path.exists("/proc/device-tree/model"):
                    with open("/proc/device-tree/model", "r") as f:
                        return f.read().strip()
            except:
                pass

            # 方法2: /proc/cpuinfo 中的 Model / Hardware
            try:
                with open("/proc/cpuinfo") as f:
                    for line in f:
                        if line.startswith("Model") or line.startswith("Hardware"):
                            return line.split(":", 1)[1].strip()
            except:
                pass

            # 方法3: fallback 使用 CPU implementer + part
            try:
                cpu_info = {}
                with open("/proc/cpuinfo") as f:
                    for line in f:
                        if ":" in line:
                            key, val = line.strip().split(":", 1)
                            cpu_info[key.strip()] = val.strip()
                if "CPU implementer" in cpu_info and "CPU part" in cpu_info:
                    return f"ARM CPU (Implementer {cpu_info['CPU implementer']}, Part {cpu_info['CPU part']})"
            except:
                pass

            return "未知 CPU (ARM)"

        # 普通 Linux / MacOS / Windows
        cpu = platform.processor()
        if cpu:
            return cpu

        # fallback: lscpu
        try:
            output = subprocess.check_output(["lscpu"], universal_newlines=True)
            for line in output.splitlines():
                if "Model name" in line:
                    return line.split(":", 1)[1].strip()
        except:
            pass

        return "未知 CPU"

    except:
        return "未知 CPU"


def get_system_info():
    """
    获取服务器系统信息，包括 OS、CPU、内存、树莓派型号
    """
    hw_info = {}
    
    # 主机名
    hw_info['hostname'] = socket.gethostname()

    # CPU 架构
    hw_info['arch'] = platform.machine()

    # CPU 型号
    hw_info['cpu_model'] = platform.processor() or "未知 CPU"

    # 内存
    mem = psutil.virtual_memory()
    hw_info['total_mem_gb'] = round(mem.total / (1024**3), 2)
    hw_info['available_mem_gb'] = round(mem.available / (1024**3), 2)
    
    # 树莓派型号检测（ARM 架构）
    pi_model = ""
    if "arm" in hw_info['arch'].lower() or "aarch" in hw_info['arch'].lower():
        try:
            with open("/proc/cpuinfo") as f:
                for line in f:
                    if line.startswith("Model"):
                        pi_model = line.split(":")[1].strip()
                        break
        except Exception:
            pi_model = ""
    hw_info['pi_model'] = pi_model

    # 操作系统
    hw_info['os'] = platform.system() + " " + platform.release()
    # 磁盘信息
    hw_info['disk'] = get_disk_info("/")
    # IP 地址
    hw_info['ip'] = get_ip_address()

    # 电源状态 / 温度
    try:
        battery = psutil.sensors_battery()
        temps = psutil.sensors_temperatures()
        hw_info['battery'] = {
            "percent": battery.percent if battery else None,
            "plugged": battery.power_plugged if battery else None
        }
        hw_info['temps'] = {k: [t.current for t in v] for k, v in temps.items()} if temps else None
    except:
        hw_info['battery'] = None
        hw_info['temps'] = None

    return hw_info

###################### routes ########################

@system_bp.route('/system')
def system_info_page():
    """
    返回系统信息页面
    """
    hw_info = get_system_info()
    #client_info = get_client_info()
    return render_template('system_info.html', hw_info=hw_info)

@system_bp.route('/system/json')
def system_info_json():
    """
    返回系统信息 JSON，用于前端动态获取
    """
    hw_info = get_system_info()
    return jsonify(hw_info)

