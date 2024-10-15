################# commands工具更新日志 #############
2.1.4 (2024-10-11)

- fix ros2 install , add dds to bashrc

2.1.3 (2024-10-11)

- 增加多种代理设置功能
- 系统代理，在~/.bashrc文件增加  export http_proxy和https_proxy,当自己有独立代理，比如v2RayN代理，开启局域网代理，可以设置系统代理。或者其他代理地址，也可以设置系统代理
- 前缀代理，在~/.gitconfig文件增加，增加git config --global url.$default_proxy.insteadof https://github.com
- git代理，在~/.gitconfig文件增加，增加git config --global http.proxy http://${2}:${3}
- 增加执行脚本前自动判断github.com是否可访问，不能访问自动添加前缀代理

2.1.2 (2024-07-06)

- 清除旧桌面版相关源码和json文件
- 移植旧版本launch相关脚本到shell目录
- 修复相关bugs 

2.1.1 (2024-07-05)

- python的豆瓣源默认更改为清华源

2.1.0 (2024-07-04)

- 正式启用新桌面版本
- 取消桌面版旧版安装脚本install_src.sh, 变更为新的安装脚本install_gui.sh  

2.0.4 (2024-07-03)

- 桌面版改版，直接管理脚本文件
- 新增脚本管理
- 新增分类管理
- 去掉旧版本相关内容


2.0.3 (2024-07-02)

- 新增install_ros2_easy_os_24.04.sh 
- 增加ubuntu24.04系统ros2 jazzy的安装支持

2.0.2 (2023-09-08)

- 增加docker支持， 进入commands_docker运行`docker build -t rcm:latest .` 生成docker镜像
- 镜像已经上传到docker-hub,可以直接使用运行 docker run -it ncnynl/rcm:latest 
- 通过命令`docker run  -it rcm:latest` 进入终端
- 增加备份私有目录和私有脚本的同步脚本，同步后目录和文件位于~/tools/commands_private/
- 增加脚本版本状态字段：DEV 开发版本，BETA 预览版本 ，RELEASE 正式版. 生成的脚本默认是DEV状态


2.0.1 (2023-09-07)

- 增加cartographer算法源码安装
- 增加生成脚本的模板，有script和ros两种，默认是script
- 增加算法安装脚本ros2_littleslam，ros1_crazys
- 增加用于ros判断的通用函数

2.0.0 (2023-09-03)

- 增加创建脚本目录
- 增加自动补全后，访问方式改变挺大，直接升级为v2.0.0系列以做区别
- 增加`rcm-gui`启动桌面模式
- 增加文档说明
- 规范2.x版本的脚本模板和相关命名
- 模板增加删除和编辑脚本功能
- 创建目录和文件后，自动同步的新生成目录和脚本到应用目录下，实现可以即时执行，但是自动补全功能要source ~/.bashrc
- 增加搜索功能
- 增加sudo列表，对于系统更改可能需要sudo权限
- 更新update_ros1_source和update_ros2_source为可选

1.3.7 (2023-09-03)

- 增加脚本自动补全功能,通过tab键即可，自动补全路径，文件名，参数列表 如使用cs <tab><tab> <tab><tab> 
- cs system check_ace --count 10 
- cs system check_ace --help
- 修改commands_completion/commands_completion.bash文件需要重新source ~/.bashrc
- 融合旧版本脚本格式，能通过如：cs common check_python_version 方式访问
- TODO: 增加缓存文件，用于加快自动补全的显示
- TODO: 增加目录创建，脚本创建的脚本
- TODO: 增加私有目录，私有脚本的创建

1.3.6 (2023-08-28)

- 使用update_system_simple.sh脚本替代update_system_mirrors2.sh脚本,采用提示方式更换系统源
- 为了避免cs冲突，使用rcm作为后备命令
- 增加cs -p 和cs -np 参数，或者设置和取消， 默认使用https://ghproxy.com/https://github.com作为代理，可以根据需要设置其他代理。
- 增加ailibot仿真安装脚本 cs -s ailibot
- 增加ailibot2仿真安装脚本 cs -s ailibot2 
- 增加micro_ros安装脚本 cs -s micro_ros 
- 增加micro_ros_dds安装脚本 cs -s micro_ros_dds 
- 增加stlink安装脚本 cs -s stlink

1.3.5 (2023-08-17)

- 增加ailibot仿真包部署脚本
- 增加本地开发脚本，安装后自动赋予可执行权限

1.3.4 (2023-05-30)

- 修复bug， 提交了多余文件 ，删除 commands/common/package.json 和 commands/common/package-lock.json


1.3.3 (2023-04-27)

- 增加解决apt安装出现lock问题脚本
- 增加openmanipulator-p和x型号机械臂安装脚本
- 增加arduino 2.x 和opencm安装脚本
- 增加arduino 1.x 和opencm安装脚本
- 增加turtlebot4安装脚本
- 增加turtlebot3多机安装脚本
- 增加turtlebot3固件升级脚本
- 增加加载工作空间配置的脚本，可以方便增加或移除bashrc的工作空间
- 增加arduino 1.x和opencr安装脚本


1.3.2 (2023-03-07)

- 增加命令行版本多语言支持，目前支持英文，中文简体，中文繁体
- 增加完整脚本名的直接执行功能
- 增加脚本嵌套执行能力
- 脚本描述多语言支持
- 增加支持wsl2的ubuntu22.04版本
- 增加脚本同步所有脚本的描述
- 增加脚本生成各种语言的locale版本

1.3.1 (2023-01-07)

- 命令行版增加sudo权限脚本执行
- 命令行版增加脚本描述显示
- 所有脚本增加脚本描述
- 增加arm版本相关脚本
- 增加支持wsl2的ubuntu20.04版本

1.3.0 (2022-12-31)

- 增加简化版安装模式
- 增加安装wireguard，n2n，boot-repair等多个脚本

1.2.9 (2022-12-05)

- 增加-c参数查看脚本内容
- 增加-e参数编辑脚本内容
- 增加rmf_burger_maps安装脚本
- 增加-b参数快速生成安装脚本, 生成的脚本在commands_extra目录下，需要运行install_extra.sh才能使用cs -s xxxx找到并执行 

1.2.8 (2022-12-05)

- 增加桌面版脚本集自动生成对应的脚本列表 ~/commonads/folder/all_shell_list.json

1.2.7 (2022-12-01)

- 增强搜索安装功能，默认搜索是进入选择模式，如果搜索是唯一值，直接进入安装模式
- 增加ORB_SLAM v2安装脚本


1.2.6 (2022-11-23)

- add cs.sh param $2
- fixed update_ros2_source.sh 
- add ros1_sensor ros1_algorithm folder
- add ros2_sensor ros2_algorithm folder 
- add Open-RMF for humble source install scripts


1.2.5 (2022-11-23)

- 增加下载烧录工具balenaEther下载脚本
- fix typos
- 修复命令行版本的重复安装问题
- 重命名ros1 noetic turtlebot3相关的脚本
- 修改load_tb3.sh,自动判断加载turtlebot3的版本
- 增加安装noetic cartographer脚本
- 修改安装脚本，避免交叉引用会自动退出

1.2.4 (2022-11-22)

- 增加安装docker
- 增加构建robots.ros.org环境
- 测试命令行自动升级
- 增加查询版本

1.2.3 (2022-11-22)

- 增加安装apt包 cs -i 
- 增加卸载apt包 cs -r
- 增加针对ROS-EASY目录包和移植相关脚本，更便利初始化ROS1和ROS2环境
- 增加命令行下的版本升级 cs -u

1.2.2 (2022-11-21)

- 命令行版增加搜索功能  cs -s / cs search  
- 命令行版增加帮助功能  cs -h / cs help
- 完成ROS-EASY系列脚本测试， ROS2安装，工具安装，多余文件清理等脚本测试
- 增加下载igntion SubT model repo 下载脚本
- 增加制作ROS-EASY镜像自动化脚本 install_ros2_easy_OS_22.04.sh

1.2.1 (2022-11-19)

- 完善脚本目录和脚本命令命名，使得RCM桌面版和命令行版的命令通用

1.2.0 (2022-11-18)

- 增加RCM命令行版本安装脚本
- 列出命令脚本列表，选择脚本ID安装
- 增加直接指定命令脚本ID安装

1.1.9 (2022-10-31)

- 增加源码安装turtlebot4仿真
- 增加桌面图标，用户权限启动，可在ubuntu常用搜索找到，可加到左边常用菜单栏
- 更改新logo， 来自https://www.designevo.com
- 更新python源脚本

1.1.8 (2022-10-29)

- 清除旧文件
- 编辑turtlebot3源码安装脚本
- 增加更新extra的脚本
- 更新说明
- 统一版本，有version.txt文件控制，更改后，所有地方版本统一
- 编辑gazebo模型下载脚本
- 增加安装systemback脚本，支持20.04备份系统

1.1.7 (2022-10-27)

- 增加ros_tutorials资源下载
- 增加geometry_tutorials资源下载
- 增加hdl_400.bag.tar.gz数据集下载 
- 增加commands.py/resources.py/share.py输入框位置的鼠标悬停显示内容

1.1.6 (2022-10-26)

- 增加Turtlesim启动命令
- 增加启动键盘控制命令
- 增加启动画方形命令
- 增加启动跟随命令
- 增加启动多个小乌龟
- 增加小乌龟的源码下载下载资源 
- 修复ROS2资源管理下载问题
- 增加ROS-EASY-OS镜像下载资源 
- 增加启动画圆形命令
- 增加关闭已启动命令按钮


1.1.5 (2022-10-20)

- 增加commands_src
- 修改安装脚本


1.1.4 (2022-07-08)

- 增和和修复命令集
- 增加时间显示


1.1.3 (2022-07-07)

- 增加命令集脚本
- 增加浏览说明按钮

1.1.2 (2022-07-05)

- fixed bug
- 增加资源管理器


1.1.1 (2022-07-04)

- fixed bug
- 增加更多脚本
- 增加默认目录
- 高亮选中目录
- 简化命令集文件名显示

1.1.0 (2022-06-30)

- fixed bug
- 增加更多脚本
- 增加默认目录

1.0.9 (2022-06-27)

- 修复搜索问题
- 简化路径
- 新增命令集
- 分离执行文件到独立仓库
- 分离命令集目录到独立仓库
- 分享的命令集仓库
- 增加更新目录按钮
- 增加增加升级按钮

1.0.8 (2022-06-24)

- 命令增加 描述,使用说明属性
- 命令文件列表作了排序
- 更新现有的命令集
- 细分common, ros1, ros2, walking几个命令集目录
- 增加树莓派的安装,使用支持
- 测试ROS1和ROS2脚本,安装ros1,安装ros2,rosdep更新,系统源更新,ROS源更新
- 测试系统命令脚本,安装apt类软件, 安装常用软件脚本


1.0.7 (2022-06-22)

- 增加可选, 精确搜索或模糊搜索, 默认是精确搜索


1.0.6 (2022-06-21)

- 增加自动生成SHELL脚本, 相关命令自动生成shell脚本,并生成执行配置. shell名称和配置名称一样

1.0.5 (2022-06-20)

- 增加命令搜索功能

1.0.4 (2022-06-13)

- 增加目录分类，在commands目录下的子目录的json文件都能列出。便于按机型或功能分类
- 比如turtlebot3，turtlebot4，walking等机型， ros1，ros2功能包等分类


1.0.3 (2022-06-02)

- 增加文件列表
- 增加清空命令列表
- 增加文件导入
- 增加文件删除


1.0.2 (2022-05-19)

- 增加自动适应列宽
- 更改某些系统命令自动关闭窗口
- 清除多余模块,减少打包软件大小

1.0.1 (2022-05-17)

- 变更保存的json格式

1.0.0 (2022-05-14)

- 增加命令添加功能
- 增加命令删除功能
- 增加导出和导入命令列表功能
