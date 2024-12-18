import odrive
from odrive.enums import *
import time
import signal

# 定义超时处理函数
def handler(signum, frame):
    raise TimeoutError("Timeout: ODrive not found within the specified time.")

def find_odrive_with_timeout(timeout=5):
    """尝试在指定的超时时间内找到 ODrive 设备."""
    signal.signal(signal.SIGALRM, handler)  # 设置信号处理器
    signal.alarm(timeout)  # 设置超时报警

    try:
        odrv = odrive.find_any()
        signal.alarm(0)  # 取消超时报警
        return odrv
    except Exception as e:
        print(f"Error while finding ODrive: {e}")
        return None
    except TimeoutError as e:
        print(e)
        return None

try:
    odrv = find_odrive_with_timeout(5)  # 5秒超时
    if odrv is not None:
        print("Connected to ODrive!")
    else:
        print("Failed to connect to ODrive.")
except Exception as e:
    print(f"Error: {e}")
