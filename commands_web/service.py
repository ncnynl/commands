# service.py
from flask import Blueprint, Flask, render_template, jsonify, request
from extensions import db  # 使用共享的 db 实例
from flask_sqlalchemy import SQLAlchemy
import subprocess
import os
import signal
import threading
from models import Service
import shutil

##############################VAR###################################  

# 定义 Blueprint 和其他全局变量
service_bp = Blueprint('service', __name__)

processes = {}
status_dict = {}
stop_condition_dict = {}
start_command_dict = {}
##############################DB###################################  
# 数据库模型


##############################function############################# 

# 获取所有服务的配置，并补充状态信息
def get_services():
    """获取所有服务的配置，并补充状态信息"""
    try:
        services = Service.query.all()
        services_with_status = []

        for service in services:
            # 检查服务的运行状态
            pids = get_pid_by_filename(service.start_command)
            status_class = 'running' if pids else 'stopped'
            status = '已运行' if pids else '已停止'
            status_dict[service.name] = '启动' if pids else '停止'
            stop_condition_dict[service.name] = service.stop_condition
            start_command_dict[service.name] = service.start_command

            # 将服务配置和状态添加到返回列表
            service_info = {
                'id': service.id,
                'name': service.name,
                'start_command': service.start_command,
                'stop_condition': service.stop_condition,
                'clear_command': service.clear_command,
                'status_class': status_class,
                'status': status
            }
            services_with_status.append(service_info)
        return services_with_status
    except Exception as e:
        raise Exception(str(e))

# 添加新的服务配置
def add_service(name, start_command, stop_condition, clear_command):
    """添加新的服务配置"""
    try:
        new_service = Service(
            name=name,
            start_command=start_command,
            stop_condition=stop_condition,
            clear_command=clear_command
        )
        db.session.add(new_service)
        db.session.commit()
        return f'服务 "{name}" 添加成功!'
    except Exception as e:
        db.session.rollback()
        raise Exception(str(e))

# 更新指定服务的启动命令和停止条件
def update_service(id, name, start_command, stop_condition, clear_command):
    """更新指定服务的启动命令和停止条件"""
    try:
        service = Service.query.get(id)
        if not service:
            raise Exception(f'No service found with ID {id}.')
        
        service.name = name
        service.start_command = start_command
        service.stop_condition = stop_condition
        service.clear_command = clear_command
        db.session.commit()
        
        return f'服务 {name} 更新成功!'
    except Exception as e:
        db.session.rollback()
        raise Exception(f'Failed to update service {name}: {str(e)}')

# 删除指定的服务
def delete_service(service_id):
    """删除指定的服务"""
    try:
        service = Service.query.get(service_id)
        if not service:
            raise Exception(f'No service found with ID {service_id}.')
        
        db.session.delete(service)
        db.session.commit()
        return f'Service deleted successfully!'
    except Exception as e:
        db.session.rollback()
        raise Exception(str(e))

# 获取所有服务的状态
def get_status():
    """获取所有服务的状态"""
    if not status_dict:
        services = Service.query.all()
        # print(services)
        for service in services:
            pids = get_pid_by_filename(service.start_command)
            status_dict[service.name] = '启动' if pids else '停止'
            stop_condition_dict[service.name] = service.stop_condition
            start_command_dict[service.name] = service.start_command
    else:
        for service_name, start_command in start_command_dict.items():
            pids = get_pid_by_filename(start_command)
            status_dict[service_name] = '启动' if pids else '停止'
    return status_dict

# 获取指定服务的 PID
def get_pid_by_filename(command):
    """根据命令获取服务的 PID 列表"""
    try:
        result = subprocess.run(['pgrep', '-f', command], stdout=subprocess.PIPE, text=True)
        pids = result.stdout.strip().split()
        return [int(pid) for pid in pids if pid]
    except Exception as e:
        return []
    
def get_service_status(service_name):
    """获取指定服务的状态"""
    if not start_command_dict:
        get_status()

    start_command = start_command_dict[service_name]
    pids = get_pid_by_filename(start_command)
    return pids

def terminate_process_by_filename(filename):
    """根据文件名终止进程"""
    pids = get_pid_by_filename(filename)
    for pid in pids:
        try:
            os.kill(pid, signal.SIGKILL)
        except (ProcessLookupError, PermissionError) as e:
            print(f"Failed to terminate process {pid}: {e}")

def run_command_in_background(command, service_name):
    """在后台运行指定的命令"""
    # 判断是否有 gnome-terminal
    if shutil.which("gnome-terminal"):
        command_start = "gnome-terminal -- bash -c 'source $HOME/.bashrc && "
        command_end   = "; exec bash'"
    else:
        # 如果没有 gnome-terminal，就直接用 bash
        command_start = "bash -c 'source $HOME/.bashrc && "
        command_end   = "'"
    # command_start = "gnome-terminal -- bash -c 'source $HOME/.bashrc && "
    # command_end   = "; exec bash'"
    full_command = command_start + command + command_end
    proc = subprocess.Popen(full_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    # 将 proc 存储到共享的字典中
    processes[service_name] = proc
    # 这里可以选择是否将输出打印到控制台
    out, err = proc.communicate()
    if out:
        print(out.decode())
    if err:
        print(err.decode())    

# 启动指定的服务
def start_service(service_name):

    # 检查服务的当前状态
    status = get_service_status(service_name)
    if status:
        raise Exception(f'{service_name} is already running.')
    
    """启动指定的服务"""
    service = Service.query.filter_by(name=service_name).first()
    if not service:
        raise Exception(f'Start command for service {service_name} not found in the database.')
    
    if get_pid_by_filename(service.start_command):
        raise Exception(f'{service_name} is already running.')
    
    command = service.start_command
    thread = threading.Thread(target=run_command_in_background, args=(command, service_name))
    thread.start()
    status_dict[service_name] = '启动'
    return f'{service_name} started successfully!'

# 停止指定的服务
def stop_service(service_name):
    """停止指定的服务"""
    status = get_service_status(service_name)

    if not status:
        raise Exception(f'{service_name} is not running.')
    
    service = Service.query.filter_by(name=service_name).first()
    if not service:
        raise Exception(f'No stop_condition found for {service_name}')

    if not get_pid_by_filename(service.start_command):
        raise Exception(f'{service_name} is not running.')

    stop_condition = service.stop_condition
    clear_command = service.clear_command
    current_script_dir = os.path.dirname(os.path.abspath(__file__))

    print(stop_condition)
    print(clear_command)
    print(current_script_dir)

    # 分割 stop_condition 并逐个终止
    commands = stop_condition.split(';')
    for command in commands:
        #执行终止脚本, 脚本名称和进程脚本不能同名
        file_path = current_script_dir + "/script_stop/" + command
        if os.path.exists(file_path) :
            command_shell = "python3" + " " + file_path
            print(command_shell)
            result = subprocess.run(command_shell, shell=True, text=True, capture_output=True)
            # 输出命令的标准输出和错误信息
            print("STDOUT:", result.stdout)
            print("STDERR:", result.stderr)
        else:
            #终止进程
            terminate_process_by_filename(command.strip())

    #清除命令执行
    if clear_command :
        commands = clear_command.split(';')
        for command in commands:
            #判断命令是否存在
            file_path = current_script_dir + "/script_clear/" + command
            if os.path.exists(file_path) :
                command_shell = "python3" + " " + file_path
                print(command_shell)
                result = subprocess.run(command_shell, shell=True, text=True, capture_output=True)
                # 输出命令的标准输出和错误信息
                print("STDOUT:", result.stdout)
                print("STDERR:", result.stderr)
            else:
                print(command_shell + "is not exits!")

    # 更新服务状态
    status_dict[service_name] = '停止'
    return f'{service_name} stopped successfully!'

def get_hardware_info():
    # CPU 架构
    arch = platform.machine()  # x86_64, armv7l, aarch64 等

    # CPU 型号
    if hasattr(platform, "processor"):
        cpu_model = platform.processor()
    else:
        cpu_model = "未知 CPU"

    # 内存
    mem = psutil.virtual_memory()
    total_mem_gb = round(mem.total / (1024 ** 3), 2)

    # 树莓派专用: 尝试读取 /proc/cpuinfo
    pi_model = ""
    if "arm" in arch.lower() or "aarch" in arch.lower():
        try:
            with open("/proc/cpuinfo") as f:
                for line in f:
                    if line.startswith("Model"):
                        pi_model = line.split(":")[1].strip()
                        break
        except:
            pi_model = ""

    return {
        "arch": arch,
        "cpu_model": cpu_model,
        "total_mem_gb": total_mem_gb,
        "pi_model": pi_model
    }

#############################route###############################
# 服务列表页面
@service_bp.route('/service')
def service_config():
    return render_template('service.html')

@service_bp.route('/services', methods=['GET'])
def services_route():
    """获取所有服务的配置"""
    try:
        services = get_services()
        # print(services)
        return jsonify([dict(service) for service in services]), 200  # 转换为字典列表
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@service_bp.route('/add_service', methods=['POST'])
def add_service_route():
    """路由处理添加新服务的请求"""
    data = request.json
    name = data.get('name')
    start_command = data.get('start_command')
    stop_condition = data.get('stop_condition')
    clear_command = data.get('clear_command')

    try:
        message = add_service(name, start_command, stop_condition, clear_command)
        return jsonify({'message': message}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@service_bp.route('/update_service', methods=['POST'])
def update_service_route():
    data = request.json
    id = data.get('id')
    name = data.get('name')
    start_command = data.get('start_command')
    stop_condition = data.get('stop_condition')
    clear_command = data.get('clear_command')
    print(id)
    print(name)
    print(start_command)
    print(stop_condition)
    print(clear_command)
    try:
        message = update_service(id, name, start_command, stop_condition, clear_command)
        return jsonify({'message': message}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 400
    
# 获取所有服务的状态
@service_bp.route('/get_status', methods=['GET'])
def get_status_route():
    try:
        status = get_status()
        return jsonify(status)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# 启动服务
@service_bp.route('/start_service', methods=['POST'])
def start_service_route():
    service_name = request.json.get('service_name')
    try:
        message = start_service(service_name)
        return jsonify({'message': message}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 400

# 停止服务
@service_bp.route('/stop_service', methods=['POST'])
def stop_service_route():
    service_name = request.json.get('service_name')
    try:
        message = stop_service(service_name)
        print(message)
        return jsonify({'message': message}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 400

@service_bp.route('/delete_service', methods=['POST'])
def delete_service_route():
    service_id = request.json.get('service_id')
    try:
        message = delete_service(service_id)
        # message = "成功删除服务"
        return jsonify({'message': message}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 400
