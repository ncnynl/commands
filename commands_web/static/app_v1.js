// static/js/app.js

// 通用函数，处理服务的启动和关闭请求
function controlService(action, serviceName) {
    fetch(`/${action}_service`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 'service_name': serviceName })
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert(data.message);
        } else if (data.error) {
            alert('Error: ' + data.error);
        }
        updateStatus();  // 操作完成后更新状态
    })
    .catch(error => {
        alert('Request failed: ' + error);
    });
}

// 获取当前服务状态并更新页面
function updateStatus() {
    fetch('/get_status')
        .then(response => response.json())
        .then(data => {
            document.getElementById('chassis_status').innerText = data.chassis;
            document.getElementById('web_bridge_status').innerText = data.web_bridge;
            document.getElementById('service1_status').innerText = data.service_name_1;
            document.getElementById('service2_status').innerText = data.service_name_2;
        });
}

// 页面加载时自动更新一次状态
window.onload = updateStatus;
