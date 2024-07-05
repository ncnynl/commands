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
    QFileDialog,QHeaderView,QSpacerItem,QSizePolicy,QComboBox
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

class CategoryThread(QThread):
    trigger = pyqtSignal()

    def __init__(self):
        super(CategoryThread, self).__init__()
        self.command = ""
        self.command_start = "gnome-terminal -- bash -c 'source ~/.bashrc;"
        self.command_end   = ";bash'"

    def setCommand(self, command):
        self.command = self.command_start + command + self.command_end

    def run(self):
        os.system(self.command)
        # 循环完毕后发出信号
        self.trigger.emit()

class CategoryManagerWindow(QWidget):
    def __init__(self,parent=None):
        super(CategoryManagerWindow,self).__init__(parent)
        self.setWindowTitle("分类管理") 
        self.resize(640,480)

        self.id =1
        self.lines = []
        self.threads = {}
        self.file_path = os.path.expanduser('~') + '/commands'
        self.dev_path  = os.path.expanduser('~') + '/tools/commands/commands_extra'
        self.dev_root  = os.path.expanduser('~') + '/tools/commands/'
        self.folder_path = os.path.expanduser('~') + '/tools/rcm_resources'
        self.cwd = self.file_path
        self.configs = ["git", "iso", "http/s"]

        self.table = QTableWidget(self)
        
        self.btn_add = QPushButton('增加分类')
        self.btn_del = QPushButton('删除分类')
        self.btn_save_commands = QPushButton('保存更改')


        self.btn_add.clicked.connect(self.add_line)
        self.btn_del.clicked.connect(self.del_line)
        self.table.cellChanged.connect(self.cellchange)
        self.btn_save_commands.clicked.connect(self.save_commands)

        self.spacerItem = QSpacerItem(20, 20, QSizePolicy.Minimum, QSizePolicy.Expanding)
        
        self.vbox = QVBoxLayout()
        self.vbox.addWidget(self.btn_add)
        self.vbox.addWidget(self.btn_del)
        self.vbox.addWidget(self.btn_save_commands)

        self.vbox.addSpacerItem(self.spacerItem)  #可以用addItem也可以用addSpacerItem方法添加
        self.vtxt = QLabel()
        self.vtxt.setMinimumHeight(50) 
        desc = "@author: ncnynl\n@email: <1043931@qq.com>\n@URL: https://ncnynl.com"
        self.vtxt.setText(desc)
        self.vbox.addWidget(self.vtxt)

        self.txt = QLabel()
        self.txt.setMinimumHeight(50)

        self.table.setColumnCount(3)   ##设置列数
        self.headers = ['选择', '名称',  '描述']
        self.table.setHorizontalHeaderLabels(self.headers)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)

        self.vbox2 = QVBoxLayout()
        self.vbox2.addWidget(self.table)
        self.vbox2.addWidget(self.txt)

        self.hbox = QHBoxLayout()
        self.hbox.addLayout(self.vbox2)
        self.hbox.addLayout(self.vbox)
        self.setLayout(self.hbox)
        #default loads
        self.load_default()
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

    def add_line(self):
        data = ["","","","","",0,""]
        self.load_line(data)

    def load_line(self, data):

        self.table.cellChanged.disconnect()
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)

        name = data[0] 
        desc = data[1]

        id = str(self.id)

        ck = QCheckBox()
        h = QHBoxLayout()
        h.setAlignment(Qt.AlignCenter)
        h.addWidget(ck)
        w = QWidget()
        w.setLayout(h)

        le1 = QLineEdit()
        le1.setText(name)
        le1.setToolTip(name)

        le2 = QLineEdit()
        le2.setText(desc)        
        le2.setToolTip(desc)                    
      
        self.table.setCellWidget(row,0,w)
        self.table.setCellWidget(row,1,le1)
        self.table.setCellWidget(row,2,le2)

        self.id += 1
        self.lines.append([id,ck,le1,le2])
        self.settext('自动生成随机一行数据！,checkbox设置为居中显示')
        self.table.cellChanged.connect(self.cellchange) 

    def del_line(self):
        result = self.show_message_box("是否删除勾选的分类信息")
        has_checked = False
        if result == QMessageBox.Ok:
            for idx in range(self.table.rowCount()) :
                widget_select = self.table.cellWidget(idx, 0)
                if widget_select:
                    ck = widget_select.findChild(QCheckBox)
                    #只针对勾选的条目做处理，避免误操作
                    if ck and ck.isChecked():
                        has_checked = True
                        #删除目录
                        widget = self.table.cellWidget(idx, 1)
                        if isinstance(widget, QLineEdit):
                            print(widget.text())
                            #删除开发目录下的分类
                            category_path = self.dev_path + "/" + widget.text()                        
                            if os.path.exists(category_path):
                                shutil.rmtree(category_path)
                                #删除目录成功后，删除表格行
                                self.table.removeRow(idx)

                            #同步删除正式目录下的分类
                            category_path = self.file_path + "/" + widget.text()   
                            if os.path.exists(category_path):
                                shutil.rmtree(category_path)

                            self.settext("已经删除在左边checkbox中选中的行！")

            if  not has_checked: 
                self.settext("没有发现勾选的内容")   

    def cellchange(self,row,col):
        item = self.table.item(row,col)
        txt = item.text()
        self.settext('第%s行，第%s列 , 数据改变为:%s'%(row,col,txt))

    def save_commands(self):
        result = self.show_message_box("是否保存勾选的分类信息")
        has_checked = False
        if result == QMessageBox.Ok:
            for idx in range(self.table.rowCount()) :
                widget_select = self.table.cellWidget(idx, 0)
                if widget_select:
                    ck = widget_select.findChild(QCheckBox)
                    #只针对勾选的条目做处理，避免误操作
                    if ck and ck.isChecked():
                        has_checked = True
                        widget = self.table.cellWidget(idx, 1)
                        if isinstance(widget, QLineEdit):
                            print(widget.text())
                            #如果分类不存在，则添加新
                            category_path = self.dev_path + "/" + widget.text()
                            if not os.path.exists(category_path):
                                os.makedirs(category_path)
                                os.makedirs(category_path + "/shell")
                            
                            #将分类描述保存到文件，对于新建或更新的描述都有效
                            description_path = category_path + "/shell/.description" 
                            widget_desc = self.table.cellWidget(idx, 2)
                            if isinstance(widget, QLineEdit):
                                print(widget_desc.text())
                                with open(description_path, 'w') as file:
                                    file.write(widget_desc.text() + '\n')

                            #保持后同步到正式目录下
                            command = self.dev_root + "/install_extra.sh"
                            wt = CategoryThread()
                            wt.setCommand(command)
                            self.threads[idx] = wt
                            wt.start() 

            if  not has_checked: 
                self.settext("没有发现勾选的内容")             
        


    def show_message_box(self, text):
        # 创建QMessageBox
        msg_box = QMessageBox()
        msg_box.setIcon(QMessageBox.Information)
        msg_box.setWindowTitle('启动选择的命令')
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
    
    def load_default(self):
        #get list
        folds = []

        for fold in os.listdir(self.dev_path):
            sub_fold_name = fold 
            sub_fold_path = self.dev_path + "/" + sub_fold_name
            
            if os.path.isdir(sub_fold_path):
                folds.append(sub_fold_name)   

        folds.sort()
        for folder_name in folds:
            print(folder_name) 
            description_path = self.dev_path + "/" + folder_name + "/shell/.description" 
            print(description_path) 
            if os.path.isfile(description_path):
                file = open(description_path, "r")
                try:
                    text_lines = file.readlines()
                    print(text_lines)
                    data = [folder_name, text_lines[0]]
                    self.load_line(data)
                finally:
                    file.close()    
        self.settext('加载现有数据!')

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
    category = CategoryManagerWindow()
    category.show()
    sys.exit(app.exec_())
