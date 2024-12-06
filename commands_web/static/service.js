// static/js/app.js

function controlService(action, serviceName) {
    const url = action === 'start' ? '/start_service' : '/stop_service';
    
    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            service_name: serviceName,
        }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert(data.message);
            updateServiceStatus(serviceName);
        } else if (data.error) {
            alert(`Error: ${data.error}`);
        }
    })
    .catch(error => console.error('Error:', error));
}

function updateServiceStatus(serviceName = null) {
    fetch('/get_status')  // 获取所有服务的状态
        .then(response => response.json())
        .then(statuses => {
            // 如果未指定服务名称，则轮询所有服务
            // console.log(statuses)
            // console.log(serviceName)
            if (!serviceName) {
                Object.keys(statuses).forEach(service => {
                    const statusElement = document.getElementById(`${service}-status`);
                    const serviceStatus = statuses[service]; // 获取特定服务的状态
                    console.log(service);
                    console.log(serviceStatus);
                    if (statusElement) {
                        // 更新状态元素的文本和类
                        if (serviceStatus === '启动') {
                            statusElement.textContent = '运行中';
                            statusElement.classList.remove('stopped');
                            statusElement.classList.add('running');
                        } else {
                            statusElement.textContent = '已停止';
                            statusElement.classList.remove('running');
                            statusElement.classList.add('stopped');
                        }
                    }
                });
            } else {
                // 更新指定服务的状态
                const statusElement = document.getElementById(`${serviceName}-status`);
                const serviceStatus = statuses[serviceName]; // 获取特定服务的状态

                if (statusElement) {
                    // 更新状态元素的文本和类
                    if (serviceStatus === '启动') {
                        statusElement.textContent = '运行中';
                        statusElement.classList.remove('stopped');
                        statusElement.classList.add('running');
                    } else {
                        statusElement.textContent = '已停止';
                        statusElement.classList.remove('running');
                        statusElement.classList.add('stopped');
                    }
                }
            }
        })
        .catch(error => console.error('Error fetching service status:', error));
}

// 获取服务列表并动态生成HTML
fetch('/services')
    .then(response => response.json())
    .then(data => {
        const serviceContainer = document.getElementById('service-container');
        serviceContainer.innerHTML = ''; // 清空当前内容
        
        data.forEach(service => {
            const serviceDiv = document.createElement('div');
            serviceDiv.className = 'col-md-3';
            serviceDiv.innerHTML = `
                <h4>${service.name}</h4>
                <p>状态: <span id="${service.name}-status" class="service-status ${service.status_class}">${service.status}</span></p>
                <button class="btn btn-success" onclick="controlService('start', '${service.name}')">启动</button>
                <button class="btn btn-danger" onclick="controlService('stop', '${service.name}')">停止</button>
                <button class="btn btn-warning" onclick="editService('${service.id}', '${service.name}', '${service.start_command}', '${service.stop_condition}', '${service.clear_command}')">编辑</button>
                <button class="btn btn-danger" onclick="deleteService('${service.id}')">删除</button>
            `;
            serviceContainer.appendChild(serviceDiv);
        });
    })
    .catch(error => console.error('Error fetching services:', error));


// 编辑服务功能
function editService(id, name, startCommand, stopCondition, clearCommand) {
    // 填充表单以进行编辑
    document.getElementById('form-title').innerText = '编辑服务';
    document.getElementById('service-id').value = id;
    document.getElementById('service-name').value = name;
    document.getElementById('start-command').value = startCommand;
    document.getElementById('stop-condition').value = stopCondition;
    document.getElementById('clear-command').value = clearCommand;

    // 更改按钮文本为“更新服务”
    document.getElementById('submit-button').innerText = '更新服务';
    // 显示取消按钮
    document.getElementById('cancel-edit').classList.remove('d-none');
    
    // 设定一个全局变量来标记当前正在编辑的服务
    window.currentEditingService = name;
}

function cancelEdit() {
    // 清空表单内容
    document.getElementById('service-id').value = 0;
    document.getElementById('service-name').value = '';
    document.getElementById('start-command').value = '';
    document.getElementById('stop-condition').value = '';
    document.getElementById('clear-command').value = '';
    
    // 恢复表单标题和按钮文本
    document.getElementById('form-title').textContent = '添加新服务';
    document.getElementById('submit-button').innerText = '添加服务';
    // 显示取消按钮
    document.getElementById('cancel-edit').classList.add('d-none');
    // 清除正在编辑的服务名称（如果有全局变量存储正在编辑的服务名称的话）
    currentEditingService = null;
}


// 在表单提交时处理添加或编辑服务
document.getElementById('add-service-form').addEventListener('submit', function(event) {
    event.preventDefault();

    const serviceId = document.getElementById('service-id').value;
    const serviceName = document.getElementById('service-name').value;
    const startCommand = document.getElementById('start-command').value;
    const stopCondition = document.getElementById('stop-condition').value;
    const clearCommand = document.getElementById('clear-command').value;
    const isEditing = document.getElementById('submit-button').innerText === '更新服务'; // 检查当前是添加还是编辑

    const endpoint = isEditing ? '/update_service' : '/add_service';
    // const method = isEditing ? 'POST' : 'POST';
    const method =  'POST';
    fetch(endpoint, {
        method: method,
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            id: serviceId,
            name: serviceName,
            start_command: startCommand,
            stop_condition: stopCondition,
            clear_command: clearCommand,
        }),
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('response-message').innerText = data.message || data.error;

        if (!isEditing) {
            // 添加成功后重置表单
            document.getElementById('add-service-form').reset();
        } else {
            // 编辑成功后重置状态
            document.getElementById('submit-button').innerText = '添加服务';
            window.currentEditingService = null; // 清空当前编辑服务
        }
        // 重新获取服务列表以更新状态
        updateServiceStatus(serviceName)
        location.reload();
        // fetch('/services')
        //     .then(response => response.json())
        //     .then(data => {
        //         // 更新状态显示
        //         data.forEach(service => {
        //             const statusElement = document.getElementById(`${service.name}-status`);
        //             if (statusElement) {
        //                 statusElement.innerText = service.status; // 假设返回的服务数据中有状态字段
        //             }
        //         });
        //     });
    })
    .catch(error => console.error('Error:', error));
});

function deleteService(serviceId) {
    fetch('/delete_service', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ service_id: serviceId }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert(data.message);
            location.reload(); // 刷新页面以获取更新后的服务列表
        } else if (data.error) {
            alert(`Error: ${data.error}`);
        }
    })
    .catch(error => console.error('Error:', error));
}

// 页面加载时自动更新一次状态
// window.onload = updateServiceStatus(null);
