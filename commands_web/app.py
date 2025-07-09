from flask import Flask, render_template, jsonify, request, send_from_directory
from extensions import db  # 导入共享的 db 实例

from wifi import wifi_bp
from service import service_bp
import threading
from flask_cors import CORS
import os 
from flask_migrate import Migrate

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///webapi.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# app.config['SQLALCHEMY_ECHO'] = True

# 设置 Flask 应用的 secret_key
app.secret_key = os.urandom(24)  # 随机生成一个 24 字节的密钥

# 初始化数据库
db.init_app(app)
# 初始化Migrate
migrate = Migrate(app, db)

# 注册 Blueprint


#admin
app.register_blueprint(service_bp, url_prefix='/')  # service模块路由
app.register_blueprint(wifi_bp, url_prefix='/')  # WIFI模块路由

# 创建数据库表
with app.app_context():
    db.create_all()


CORS(app)

@app.route('/')
def home():
    return render_template('base_index.html')

@app.route('/admin')
def admin():
    return render_template('base.html')

def start_web_server():
    # Ensure Flask runs in a single-threaded mode for safety
    app.run(host='0.0.0.0', port=5051, threaded=False)

def main():
    # 启动 Flask 应用程序线程
    web_thread = threading.Thread(target=start_web_server)
    web_thread.daemon = True  # 守护线程
    web_thread.start()

     # 保持主线程活跃，以确保 Flask 和 ROS2 节点持续运行
    try:
        while True:
            pass
    except KeyboardInterrupt:
        print("Exiting...")

if __name__ == '__main__':
    main()


