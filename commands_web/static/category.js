$(document).ready(function() {
  // 点击编辑按钮时，加载内容并显示编辑表单
  $(document).on('click', '.edit-button', function() {
    const categoryId = $(this).data('id');
    const categoryName = $(this).data('name');
    const categoryMode = $(this).data('mode');  // 使用 mode 而非 description

    // 填充表单数据
    $('#category-id').val(categoryId);
    $('#category-name').val(categoryName);
    $('#category-mode').val(categoryMode);  // 填充 mode 字段

    // 显示编辑区域
    $('#cancel-edit').removeClass('d-none');
  });


  // 表单提交
  $('#add-category-form').submit(function(e) {
    e.preventDefault();

    const formData = {
      'category-id': $('#category-id').val(),
      'category-name': $('#category-name').val(),
      'category-mode': $('#category-mode').val(),  // 使用 mode 字段
    };

    const url = formData['category-id'] == 0 ?
        '/category' :
        `/category/${formData['category-id']}`;

    fetch(url, {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(formData),
    })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            alert('操作成功');
            location.reload();  // 刷新页面以显示更新后的列表
          } else {
            alert('操作失败，请稍后再试');
          }
        })
        .catch(error => {
          alert('发生错误，请稍后再试');
        });
  });

  // 删除按钮监听器
  $(document).on('click', '.delete-button', function() {
    const categoryId = $(this).data('id');
    const confirmDelete = confirm('确定要删除这个种类吗？');
    if (!confirmDelete) return;

    fetch(`/category/delete/${categoryId}`, {method: 'DELETE'})
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            alert('删除成功');
            location.reload();  // 刷新页面以更新种类列表
          } else {
            alert('删除失败，请稍后再试');
          }
        })
        .catch(error => {
          alert('发生错误，请稍后再试');
        });
  });


  // 分页点击事件
  $(document).on('click', '.pagination a', function(e) {
    e.preventDefault();
    const url = new URL($(this).attr('href'), window.location.origin);

    // 获取当前选择的模式值
    const selectedMode = $('#category-mode').val();
    if (selectedMode) {
      // 将模式参数添加到 URL 中
      url.searchParams.set('mode', selectedMode);
    }

    // 显示加载提示
    $('#loading-indicator').show();

    // 发送 AJAX 请求并更新内容
    $.get(url.toString(), function(data) {
       $('#content-table').html(data);
     }).always(function() {
      // 隐藏加载提示
      $('#loading-indicator').hide();
    });
  });


  $('#filter-mode').on('change', function() {
    const selectedMode = $(this).val();  // 获取选中的模式值
    const url = '/category';             // 分类管理的后端路由

    // 显示加载提示
    $('#loading-indicator').show();

    // 发起 AJAX GET 请求
    $.get(url, {mode: selectedMode}, function(data) {
       // 使用返回的内容更新表格和分页
       $('#content-table').html(data);
     }).always(function() {
      // 隐藏加载提示
      $('#loading-indicator').hide();
    });
  });
});

// 点击取消按钮时，返回列表并清空表单
function cancelEdit() {
  $('#cancel-edit').addClass('d-none');
  $('#add-category-form').trigger('reset');
}
