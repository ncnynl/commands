#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
ROS1/ROS2 Commands Resource Manager

This program is more convenient to manage all programs, add programs, 
start programs, export programs list, load program list

Author: ncnynl
Website: ncnynl.com 
Last edited: 2022-05-19

"""

from PyQt5.QtWidgets import (
    QApplication, QTableWidget, QWidget, QPushButton,
    QVBoxLayout, QLabel, QHBoxLayout, QCheckBox,
    QCheckBox, QLineEdit, QTableWidgetItem, QMessageBox,
    QFileDialog,QHeaderView,QSpacerItem,QSizePolicy,QComboBox,QTextEdit,QRadioButton,QButtonGroup
)
from PyQt5.QtCore import ( 
    pyqtSignal, QThread, QByteArray, Qt, 
    QFile, QIODevice, QJsonDocument, 
    QJsonValue, QJsonParseError 
)
from PyQt5.QtGui import QFont
import sys
import os
import time,datetime
import webbrowser
import shutil

import subprocess

class ScriptThread(QThread):
    trigger = pyqtSignal()

    def __init__(self):
        super(ScriptThread, self).__init__()
        self.command = ""
        self.command_start = "gnome-terminal -- bash -c 'source ~/.bashrc;"
        self.command_end   = ";bash'"

    def setCommand(self, command):
        self.command = self.command_start + command + self.command_end

    def run(self):
        os.system(self.command)
        # 循环完毕后发出信号
        self.trigger.emit()

class ScriptManagerWindow(QWidget):
    def __init__(self,parent=None):
        super(ScriptManagerWindow,self).__init__(parent)
        self.setWindowTitle("脚本管理") 
        self.resize(800,600)

        self.threads = {}
        self.file_path = os.path.expanduser('~') + '/commands'
        self.dev_path  = os.path.expanduser('~') + '/tools/commands/commands_extra'
        self.dev_root  = os.path.expanduser('~') + '/tools/commands/'
        self.folder_path = os.path.expanduser('~') + '/tools/rcm_resources'

        self.spacerItem = QSpacerItem(5, 5, QSizePolicy.Minimum, QSizePolicy.Expanding)
               
        self.vbox = QVBoxLayout()

        self.etxt = QLabel()
        self.etxt.setMinimumHeight(50) 
        desc = "修改需选择目录和脚本"
        self.etxt.setText(desc)
        self.vbox.addWidget(self.etxt)

        # 创建并添加分类下拉列表
        self.categoryComboBox = QComboBox(self)
        self.categoryComboBox.addItems(self.load_folder())
        self.categoryComboBox.currentIndexChanged.connect(self.load_files)
        self.vbox.addWidget(self.categoryComboBox)

        # 创建并添加文件下拉列表
        self.fileComboBox = QComboBox(self)
        self.fileComboBox.currentIndexChanged.connect(self.load_file_content)
        self.vbox.addWidget(self.fileComboBox)

        self.btn_save_commands = QPushButton('保存修改')
        self.btn_save_commands.clicked.connect(self.save_commands)
        self.vbox.addWidget(self.btn_save_commands)

        self.btn_del = QPushButton('删除脚本')  
        self.btn_del.clicked.connect(self.del_script)      
        self.vbox.addWidget(self.btn_del)  

        #可以用addItem也可以用addSpacerItem方法添加
        self.vbox.addSpacerItem(self.spacerItem) 

        self.atxt = QLabel()
        self.atxt.setMinimumHeight(50) 
        desc = "新增可选择模板"
        self.atxt.setText(desc)
        self.vbox.addWidget(self.atxt)       
        # 创建并添加单选按钮
        self.ros1RadioButton = QRadioButton('ROS1模板', self)
        self.ros2RadioButton = QRadioButton('ROS2模板', self)
        self.nonRosRadioButton = QRadioButton('非ROS模板', self)

        # 将单选按钮添加到按钮组中
        self.radioButtonGroup = QButtonGroup(self)
        self.radioButtonGroup.addButton(self.ros1RadioButton)
        self.radioButtonGroup.addButton(self.ros2RadioButton)
        self.radioButtonGroup.addButton(self.nonRosRadioButton)

        # 创建水平布局以放置单选按钮
        radio_layout = QHBoxLayout()
        radio_layout.addWidget(self.ros1RadioButton)
        radio_layout.addWidget(self.ros2RadioButton)
        radio_layout.addWidget(self.nonRosRadioButton)

        # 设置默认选择
        self.nonRosRadioButton.setChecked(True)
        self.vbox.addLayout(radio_layout)

        self.btn_add_tpl = QPushButton('使用脚本模板')
        self.btn_add_tpl.clicked.connect(self.add_script_tpl)
        self.vbox.addWidget(self.btn_add_tpl)

        #可以用addItem也可以用addSpacerItem方法添加
        self.vbox.addSpacerItem(self.spacerItem) 

        self.atxt = QLabel()
        self.atxt.setMinimumHeight(50) 
        desc = "新增需选择目录和输入文件名"
        self.atxt.setText(desc)
        self.vbox.addWidget(self.atxt)

        # 创建并添加分类下拉列表
        self.category2ComboBox = QComboBox(self)
        self.category2ComboBox.addItems(self.load_folder())
        self.vbox.addWidget(self.category2ComboBox)

        # 创建并添加文本输入框
        self.textInput = QLineEdit(self)
        self.textInput.setPlaceholderText('填写脚本名称，如check_python_version')
        self.vbox.addWidget(self.textInput)

        self.btn_add_new = QPushButton('保存新增')
        self.btn_add_new.clicked.connect(self.add_script)  
        self.vbox.addWidget(self.btn_add_new)
        
        #可以用addItem也可以用addSpacerItem方法添加
        self.vbox.addSpacerItem(self.spacerItem)  
        self.vtxt = QLabel()
        self.vtxt.setMinimumHeight(50) 
        desc = "@author: ncnynl\n@email: <1043931@qq.com>\n@URL: https://ncnynl.com"
        self.vtxt.setText(desc)
        self.vbox.addWidget(self.vtxt)

        self.txt = QLabel()
        self.txt.setMinimumHeight(50)


        # 创建左边的文本编辑器
        self.vbox2 = QVBoxLayout()
        self.textEdit = QTextEdit(self)
        self.vbox2.addWidget(self.textEdit)
        self.vbox2.addWidget(self.txt)

        self.hbox = QHBoxLayout()
        self.hbox.addLayout(self.vbox2)
        self.hbox.addLayout(self.vbox)

        self.update_category_list()
        self.load_files()
        self.setLayout(self.hbox)

                   # 设置样式表
        self.setStyleSheet("""
            QWidget {
                background-color: #f9f9f9;
                font-size: 14px;
                font-family: Arial, Helvetica, sans-serif;
                color: #333;
            }
            QLabel {
                color: #333;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #fff;
            }
            QPushButton {
                color: #333;
                background-color: rgba(200, 200, 200, 0.5);  # 半透明淡灰色
                border: 1px solid #ccc;
                padding: 8px 16px;
                border-radius: 4px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: rgba(200, 200, 200, 0.7);  # 悬停时更深的半透明淡灰色
            }
            QLineEdit {
                padding: 6px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #fff;
            }
            QTextEdit {
                padding: 6px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #fff;
            }
            QTableWidget {
                border: 1px solid #ddd;
                border-radius: 4px;
                gridline-color: #eee;
                background-color: #fff;
            }
            QHeaderView::section {
                background-color: #007bff;
                color: #fff;
                padding: 4px;
                border: none;
            }
            QTableWidgetItem {
                padding: 4px;
            }
        """)


    def update_category_list(self):
        # 设置默认值
        default_value = "common"
        index = self.fileComboBox.findText(default_value)
        if index != -1:  # 如果找到了对应的选项
            self.fileComboBox.setCurrentIndex(index)

    def load_folder(self):
        folders = []

        for fold in os.listdir(self.file_path):
            sub_fold_name = fold 
            sub_fold_path = self.file_path + "/" + sub_fold_name
            
            if os.path.isdir(sub_fold_path):
                folders.append(sub_fold_name)  

        folders.sort()
    
        return folders

    def load_files(self):
        # 更新文件下拉列表中的文件
        self.fileComboBox.clear()
        category = self.categoryComboBox.currentText()
        print(category)
        if category:
            self.folder_path = self.file_path + "/" + category + "/shell/"
            if os.path.exists(self.folder_path) and os.path.isdir(self.folder_path):
                files = [f for f in os.listdir(self.folder_path) if os.path.isfile(os.path.join(self.folder_path, f))]
                files.sort()
                self.fileComboBox.addItems(files)

         # 设置默认值
        default_value = "check_python_version.sh"
        index = self.fileComboBox.findText(default_value)
        if index != -1:  # 如果找到了对应的选项
            self.fileComboBox.setCurrentIndex(index)
                        

    def load_file_content(self):
        # 加载选中文件的内容
        directory = self.categoryComboBox.currentText()
        file_name = self.fileComboBox.currentText()
        file_path = self.file_path + "/" + directory + "/shell/" + file_name
        if os.path.exists(file_path) and os.path.isfile(file_path):
            with open(file_path, 'r') as file:
                content = file.read()
                self.textEdit.setPlainText(content)

    def save_file_content(self):
        # 保存编辑器中的内容到文件
        directory = self.categoryComboBox.currentText()
        file_name = self.fileComboBox.currentText()
        file_path = file_path = self.dev_path + "/" + directory + "/shell/" + file_name
        content = self.textEdit.toPlainText()
        with open(file_path, 'w') as file:
            file.write(content)

        #保存后同步到正式目录下
        command = self.dev_root + "/install_extra.sh"
        wt = ScriptThread()
        wt.setCommand(command)
        self.threads[0] = wt
        wt.start()  

        # self.run_command_with_sudo([command])
        QMessageBox.information(self, '成功', f'文件 "{file_name}" 成功保存，请在弹出的窗口输入密码，完成同步脚本到正式目录下!')

    def run_command_with_sudo(self, command):
        result = subprocess.run(['sudo'] + command, capture_output=True, text=True)
        if result.returncode == 0:
            print(f'Success:\n{result.stdout}')
        else:
            print(f'Error:\n{result.stderr}')

    def save_commands(self):
        result = self.show_message_box("是否保存的脚本内容")
        if result == QMessageBox.Ok:
            self.save_file_content()

    def del_script(self):
        directory = self.categoryComboBox.currentText()
        file_name = self.fileComboBox.currentText()
        file_path = self.dev_path + "/" + directory + "/shell/" + file_name
        file2_path = self.file_path + "/" + directory + "/shell/" + file_name
        result = self.show_message_box("是否删除选中的脚本：" + file_name)
        if result == QMessageBox.Ok:
            os.remove(file_path)
            os.remove(file2_path)
            QMessageBox.information(self, '成功', f'文件 "{file_name}" 已经删除！')


    def show_message_box(self, text):
        # 创建QMessageBox
        msg_box = QMessageBox()
        msg_box.setIcon(QMessageBox.Information)
        msg_box.setWindowTitle('脚本处理')
        msg_box.setText(f"{text}")

        # 设置QMessageBox的按钮
        msg_box.setStandardButtons(QMessageBox.Ok | QMessageBox.Cancel)

        # 设置QMessageBox的样式
        msg_box.setStyleSheet("QMessageBox { border: 2px solid red; }")

        # 居中弹出QMessageBox
        msg_box.move(self.geometry().center() - msg_box.rect().center())

        # 显示QMessageBox并处理按钮点击事件
        result = msg_box.exec_()
        return result 
    
    def add_script_tpl(self):
        result = self.show_message_box("是否加载脚本模板")
        if result == QMessageBox.Ok:
            file_path = self.dev_path + "/common/shell/install_template.sh.tl"
            if self.ros1RadioButton.isChecked(): 
                file_path = self.dev_path + "/ros1/shell/install_template.sh.tl"
            elif self.ros2RadioButton.isChecked() : 
                file_path = self.dev_path + "/ros2/shell/install_template.sh.tl"
            elif self.nonRosRadioButton.isChecked() : 
                file_path = self.dev_path + "/common/shell/install_template.sh.tl"

            # 加载选中文件的内容
            print(file_path)
            if os.path.exists(file_path) and os.path.isfile(file_path):
                with open(file_path, 'r') as file:
                    content = file.read()
                    self.textEdit.setPlainText(content)

    def add_script(self):
        result = self.show_message_box("是否新增脚本")
        if result == QMessageBox.Ok:
            # 保存编辑器中的内容到文件
            directory = self.category2ComboBox.currentText()
            file_name = self.textInput.text()
            file_path = file_path = self.dev_path + "/" + directory + "/shell/" + file_name + ".sh"
            content = self.textEdit.toPlainText()
            with open(file_path, 'w') as file:
                file.write(content)

            #保存后同步到正式目录下
            command = self.dev_root + "/install_extra.sh"
            wt = ScriptThread()
            wt.setCommand(command)
            self.threads[0] = wt
            wt.start()  

            QMessageBox.information(self, '成功', f'文件 "{file_name}" 成功保存，请在弹出的窗口输入密码，完成同步脚本到正式目录下!')
    
    def settext(self,txt):
        font = QFont('微软雅黑',10)
        self.txt.setFont(font)
        self.txt.setText(txt)    

    def closeEvent(self, event):
        reply = QMessageBox.question(self, '警告', '退出后将停止,你确认要退出吗？', QMessageBox.Yes, QMessageBox.No)
        if reply == QMessageBox.Yes:
            event.accept()
        else:
            event.ignore()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    script = ScriptManagerWindow()
    script.show()
    sys.exit(app.exec_())
