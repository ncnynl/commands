## 需要配置nmcli不使用sudo
#sudo visudo -f /etc/sudoers.d/nmcli_permissions
# your_username ALL=(ALL) NOPASSWD: /usr/bin/nmcli

# 这里：
# your_username：替换为你的实际用户名。
# ALL=(ALL)：表示允许该用户在所有主机上使用 nmcli（通常用于本地配置时，写成 ALL）。
# NOPASSWD:：表示运行后面指定的命令不需要输入密码。
# /usr/bin/nmcli：这是 nmcli 的绝对路径。你可以通过 which nmcli 来确认 nmcli 所在路径。


import subprocess
from flask import Blueprint, Flask, render_template, request, jsonify

#########################var##############################
# Blueprint
wifi_bp = Blueprint('wifi', __name__)

# 缓存的 Wi-Fi 列表
cached_wifi_list = ""



######################function#######################

def scan_wifi_list():
    global cached_wifi_list
    if not cached_wifi_list:  # 如果缓存为空，则调用 nmcli
        try:
            cached_wifi_list = subprocess.check_output(
                ['nmcli', '-t', '-f', 'active,ssid,bssid,signal,device', 'device', 'wifi'],
                universal_newlines=True
            )
        except Exception as e:
            print(f"Error scanning wifi: {e}")
            cached_wifi_list = ""
    return cached_wifi_list

def get_current_wifi_info():
    try:
        output = scan_wifi_list()
        wifi_info = {}
        for line in output.splitlines():
            parts = line.split(":")
            if parts[0] == 'yes':  # 'yes' 表示当前连接的 Wi-Fi
                wifi_info['ssid'] = parts[1]
                wifi_info['bssid'] = ":".join(parts[2:8]).replace("\\", "")
                wifi_info['signal_strength'] = parts[8]
                wifi_info['device'] = parts[9]
                break

        if 'device' in wifi_info:
            ip_output = subprocess.check_output(['ip', 'addr', 'show', wifi_info['device']], universal_newlines=True)
            for line in ip_output.splitlines():
                if 'inet ' in line:
                    ip_address = line.strip().split()[1].split('/')[0]
                    wifi_info['ip_address'] = ip_address
                    break

        print("Current Wi-Fi Information:")
        print(f"SSID: {wifi_info.get('ssid')}")
        print(f"BSSID: {wifi_info.get('bssid')}")
        print(f"Signal Strength: {wifi_info.get('signal_strength')}")
        print(f"Device: {wifi_info.get('device')}")
        print(f"IP Address: {wifi_info.get('ip_address')}")

        return wifi_info

    except subprocess.CalledProcessError as e:
        print(f"Error getting current Wi-Fi info: {e}")
        return None

def scan_wifi():
    wifi_list = []
    try:
        result = scan_wifi_list()
        wifi_list = [line.split(":")[1] for line in result.strip().split('\n') if line]  # 只获取 SSID
    except Exception as e:
        print(f"Error scanning wifi: {e}")
    return wifi_list


# 连接到指定的 Wi-Fi，并设置静态IP、网关和DNS
def connect_wifi(ssid, password, ip, gateway, dns):
    try:


        if not gateway:
            gateway = "192.168.0.1"
            
        if not ip:
            ip = "192.168.0.212"

        if not dns:
            dns = "202.96.128.86"

        print(ssid)
        print(password)
        print(ip)
        print(gateway)
        print(dns)


        # 连接 Wi-Fi
        subprocess.check_call(['nmcli', 'device', 'wifi', 'connect', ssid, 'password', password])
        
        # 获取连接名称（SSID 就是连接名称）
        connection_name = ssid
        
        # 设置静态 IP、网关和 DNS
        subprocess.check_call([
            'nmcli', 'connection', 'modify', connection_name,
            'ipv4.addresses', f'{ip}/24',  # 你可以调整子网掩码
            'ipv4.gateway', gateway,
            'ipv4.dns', dns,
            'ipv4.method', 'manual'
        ])

        # 设置为自动连接
        subprocess.check_call(['nmcli', 'connection', 'modify', connection_name, 'connection.autoconnect', 'yes'])
        
        # 启用新配置
        subprocess.check_call(['nmcli', 'connection', 'up', connection_name])
        return True

    except subprocess.CalledProcessError as e:
        print(f"Failed to connect and configure Wi-Fi: {e}")
        return False
    


####################route####################
@wifi_bp.route('/wifi')
def index():
    wifi_list = scan_wifi()
    wifi_info = get_current_wifi_info()
    return render_template('wifi.html', wifi_list=wifi_list,  wifi_info=wifi_info)

@wifi_bp.route('/wifi_status')
def wifi_status_route():
    try:
        wifi_info = get_current_wifi_info()
        return jsonify(wifi_info)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@wifi_bp.route('/wifi_list')
def wifi_list_route():
    try:
        wifi_list = scan_wifi()
        return jsonify(wifi_list)
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@wifi_bp.route('/set_wifi', methods=['POST'])
def set_wifi():
    ssid = request.form['ssid']
    password = request.form['password']
    static_ip = request.form['ip']
    gateway = request.form['gateway']
    dns = request.form['dns']
    
    success = connect_wifi(ssid, password, static_ip, gateway, dns)

    if success:
        message = f"Successfully connected to {ssid} with IP {static_ip}."
        message_type = "success"  # Bootstrap success alert
    else:
        message = f"Failed to connect to {ssid}."
        message_type = "danger"  # Bootstrap danger alert
    
    return render_template('admin/wifi_result.html', message=message, message_type=message_type)

@wifi_bp.route('/set_wifi_api', methods=['POST'])
def set_wifi_api_route():
    ssid = request.form['ssid']
    password = request.form['password']
    static_ip = request.form['ip']
    gateway = request.form['gateway']
    dns = request.form['dns']
    
    success = connect_wifi(ssid, password, static_ip, gateway, dns)


    if success:
        # 返回成功信息
        return jsonify({
            'success': True,
            'message': f'Successfully connected to {ssid} with IP {static_ip}.'
        }), 200
    else:
        # 返回失败信息
        return jsonify({
            'success': False,
            'message': f'Failed to connect to {ssid}.'
        }), 400
