#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
ROS1/ROS2 Commands Manager

This program is more convenient to manage all programs, add programs, 
start programs, export programs list, load program list

Author: ncnynl
Website: ncnynl.com 
Last edited: 2022-05-19

"""

import re
import webbrowser
from PyQt5.QtWidgets import (
    QApplication, QTableWidget, QWidget, QPushButton,
    QVBoxLayout, QLabel, QHBoxLayout, QCheckBox,
    QCheckBox, QLineEdit, QTableWidgetItem, QMessageBox,
    QFileDialog,QHeaderView,QSpacerItem,QSizePolicy,
    QAbstractItemView,QTextEdit,QDialog
)
from PyQt5.QtCore import ( 
    pyqtSignal, QThread, QByteArray, Qt, 
    QFile, QIODevice, QJsonDocument, 
    QJsonValue, QJsonParseError 
)
from PyQt5.QtGui import QFont
import sys
import os
import apt
import apt_pkg
import time,datetime
import subprocess
import requests
from bs4 import BeautifulSoup

class WorkThread(QThread):
    trigger = pyqtSignal()

    def __init__(self):
        super(WorkThread, self).__init__()
        self.command = ""
        self.command_start = "gnome-terminal -- bash -c 'source ~/.bashrc;"
        self.command_end   = ";bash'"

    def setCommand(self, command):
        self.command = self.command_start + command + self.command_end

    def run(self):
        os.system(self.command)
        # 循环完毕后发出信号
        self.trigger.emit()

class ui(QWidget):
    def __init__(self):
        super().__init__()
        self.version = self.getVersion()
        self.last_edited = self.getModifyTime()
        self.author = "ncnynl"
        self.email  = "1043931@qq.com"
        self.website  = "https://ncnynl.com"
        self.license  = "MIT"
        self.qq1  = "创客智造B群:926779095"
        self.qq2  = "创客智造C群:937347681"
        self.qq3  = "创客智造D群:562093920"
        self.qq   =  self.qq1  + "\n" + self.qq2 + "\n" + self.qq3
        # self.lines2 = []
        self.id2 =1
        self.file_path = os.path.expanduser('~') + '/commands'
        self.default_folder="common"

        self.setupUI()
        self.id =1
        self.lines = []
        self.threads = {}
        self.editable = True
        self.des_sort = True
        self.btn_search.clicked.connect(self.search_line)
        self.btn_category.clicked.connect(self.category_manager)
        self.btn_script.clicked.connect(self.script_manager)
        self.table.cellChanged.connect(self.cellchange)
        
        self.btn_save_commands.clicked.connect(self.save_commands)
        self.btn_save_shell.clicked.connect(self.save_shell)
        self.btn_load_commands.clicked.connect(self.load_commands)
        self.btn_clear_commands.clicked.connect(self.clear_commands)
        self.btn_share_commands.clicked.connect(self.share_commands)
        self.btn_resource.clicked.connect(self.resource_commands)

        self.btn_upgrade_commands.clicked.connect(self.upgrade_commands)
        self.btn_update_folder.clicked.connect(self.update_folder)
        self.btn_kill_commands.clicked.connect(self.kill_commands)

        self.cwd = self.file_path

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

    def getModifyTime(self):
        file_path = os.path.expanduser('~') + '/tools/commands/commands_gui/commands.py'
        t = os.path.getctime(file_path)
        time_struct = time.localtime(t)
        return time.strftime('%Y-%m-%d', time_struct)

    def getVersion(self):
        self.version_file_path = os.path.expanduser('~') + '/tools/commands/version.txt'
        f = open(self.version_file_path)
        content = f.read()
        f.close
        return content

    def setupUI(self):
        self.setWindowTitle('ROS命令管理器(简称RCM) v'+self.version)
        self.resize(800,400)
        self.table = QTableWidget(self)
        
        self.btn_category = QPushButton('分类管理')
        self.btn_script = QPushButton('脚本管理')
        self.btn_save_commands = QPushButton('保存命令列表')
        self.btn_save_shell = QPushButton('生成SHELL脚本')
        self.btn_load_commands = QPushButton('加载命令列表')
        self.btn_clear_commands = QPushButton('清空命令列表')
        self.btn_share_commands = QPushButton('管理共享命令集')     
        self.btn_resource = QPushButton('管理ROS2资源')          
        self.btn_update_folder = QPushButton('更新命令集分类')   
        self.btn_upgrade_commands = QPushButton('升级命令管理器')
        self.btn_kill_commands = QPushButton('关闭已启动命令')
        


        self.spacerItem = QSpacerItem(20, 20, QSizePolicy.Minimum, QSizePolicy.Expanding)
        
        self.vbox = QVBoxLayout()
        self.vbox.addWidget(self.btn_category)
        self.vbox.addWidget(self.btn_script)      
        # self.vbox.addWidget(self.btn_save_commands)
        # self.vbox.addWidget(self.btn_save_shell)
        # self.vbox.addWidget(self.btn_load_commands)
        self.vbox.addWidget(self.btn_clear_commands)
        # self.vbox.addWidget(self.btn_share_commands)
        # self.vbox.addWidget(self.btn_resource)
        # self.vbox.addWidget(self.btn_update_folder)        
        self.vbox.addWidget(self.btn_upgrade_commands)
        self.vbox.addWidget(self.btn_kill_commands)


        self.vbox.addSpacerItem(self.spacerItem)  #可以用addItem也可以用addSpacerItem方法添加
        self.vtxt = QLabel()
        self.vtxt.setMinimumHeight(50) 
        header = '''
        #########################################################################
        #                     ROS1/ROS2 Commands Manager v{7}                 #
        # This program is more convenient to manage all programs, add programs, # 
        # start programs, export programs list, load program list               #
        #                                                                       #
        # 作者: {0}                                                          #
        # 网站: {1}                                              #
        # 邮箱: {2}                                                  #
        # 更新: {3}                                                      #
        # QQ群1: {4}                                          #
        # QQ群2: {5}                                          #
        # QQ群3: {6}                                          #
        #########################################################################
        '''.format(self.author,self.website,self.email,self.last_edited,self.qq1, self.qq2, self.qq3, self.version)
        # header
        print(header)   
        desc = "作者:" + self.author + "\n 邮箱:"  + self.email + "\n 网站:"  + self.website + "\n 更新:" + self.last_edited + "\n 交流QQ群: \n" + self.qq 
        self.vtxt.setText(desc)
        self.vbox.addWidget(self.vtxt)

        self.txt = QLabel()
        self.txt.setMinimumHeight(50)


        self.table.setColumnCount(6)   ##设置列数
        self.headers = ['选择', '名称', '描述',  '版本', '操作', '详情']
        self.table.setHorizontalHeaderLabels(self.headers)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeToContents)
        # self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(3, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(4, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(5, QHeaderView.ResizeToContents)

        
        # self.table2 = QTableWidget(self)
        # self.table2.setColumnCount(4)
        # self.table2.setSelectionBehavior(1)
        # self.table2.setEditTriggers(QAbstractItemView.NoEditTriggers)
        # self.headers2 = ['文件', '时间', '导入', '删除']
        # self.table2.setHorizontalHeaderLabels(self.headers2)    
        # self.table2.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)    
        # self.table2.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)   
        # self.table2.horizontalHeader().setSectionResizeMode(2, QHeaderView.ResizeToContents)   
        # self.table2.horizontalHeader().setSectionResizeMode(3, QHeaderView.ResizeToContents)   

        self.table3 = QTableWidget(self)
        self.table3.setColumnCount(1)
        self.table3.setSelectionBehavior(1)
        self.table3.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.headers3 = ['分类(脚本数)']
        self.table3.setHorizontalHeaderLabels(self.headers3)    
        self.table3.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)    
        # self.table3.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeToContents)       


        self.txt3 = QLabel()
        self.txt3.setMinimumHeight(50)      
        self.txt3.setText("名称")  

        self.ql3 = QLineEdit()
        self.qc3 = QCheckBox()
        self.qc3.setText("精确")
        self.qc3.setChecked(True)

        self.qc4 = QCheckBox()
        self.qc4.setText("本地脚本库")
        self.qc4.setChecked(True)

        self.qc5 = QCheckBox()
        self.qc5.setText("APT软件库")
        self.qc5.setChecked(False)

        # self.qc6 = QCheckBox()
        # self.qc6.setText("Python软件库")
        # self.qc6.setChecked(False)

        # self.qc7 = QCheckBox()
        # self.qc7.setText("Ruby软件库")
        # self.qc7.setChecked(False)             

        self.btn_search = QPushButton('搜索')


        self.hbox2 = QHBoxLayout()
        self.hbox2.addWidget(self.table3)
        self.hbox2.addWidget(self.table)
        # Set the stretch factors (20% and 80%)
        self.hbox2.setStretch(0, 1)  # table3 gets 20% of the space
        self.hbox2.setStretch(1, 4)  # table gets 80% of the space


        self.hbox3 = QHBoxLayout()
        self.hbox3.addWidget(self.txt3)       
        self.hbox3.addWidget(self.ql3)       
        self.hbox3.addWidget(self.qc3)     
        self.hbox3.addWidget(self.qc4)
        self.hbox3.addWidget(self.qc5)
        # self.hbox3.addWidget(self.qc6)  
        # self.hbox3.addWidget(self.qc7) 
        self.hbox3.addWidget(self.btn_search)   

        self.txt4 = QLabel()
        self.txt4.setMinimumHeight(50)
        self.txt4.setText("请输入关键词进行搜索, 默认精确搜索,也可以选择模糊搜索")

        self.vbox2 = QVBoxLayout()
        self.vbox2.addLayout(self.hbox3)
        self.vbox2.addWidget(self.txt4)
        # self.vbox2.addWidget(self.table)
        self.vbox2.addLayout(self.hbox2)
        self.vbox2.addWidget(self.txt)

        self.hbox = QHBoxLayout()
        self.hbox.addLayout(self.vbox2)
        self.hbox.addLayout(self.vbox)
        self.setLayout(self.hbox)

        self.show()
        self.load_folder()
        self.load_file("common")
        self.gen_commands_list()

    def load_folder(self):
        self.id3 = 1
        self.table3.setRowCount(0)
        self.table3.clearContents()        
        self.table3.cellChanged.connect(self.cellchange)

        if not os.path.exists(self.file_path):
            os.makedirs(self.file_path)

        #get list
        folds = []

        file_path = ""
        for fold in os.listdir(self.file_path):
            sub_fold_name = fold 
            sub_fold_path = self.file_path + "/" + sub_fold_name
            
            if os.path.isdir(sub_fold_path):
                folds.append(sub_fold_name)        
        folds.sort()
        for folder_name in folds:
            sub_fold_path = self.file_path + "/" + folder_name + "/shell/" 
            if os.path.isdir(sub_fold_path):
                names = [name for name in os.listdir(sub_fold_path)
                    if os.path.isfile(os.path.join(sub_fold_path, name))  if ".sh" in name and ".tl" not in name]  
                # print(names)
                        
            self.to_load_single_folder(folder_name, len(names))            

        self.table3.selectRow(0)
        self.table3.setFocus()

    def to_load_single_folder(self, folder_name, file_total): 
        id = self.id3
        self.table3.cellChanged.disconnect()
        row = self.table3.rowCount()
        self.table3.setRowCount(row + 1)
        fn = folder_name + "(" + str(file_total) + ")"
        btn1 = QPushButton()
        btn1.setStyleSheet("QPushButton{text-align : left;}")
        btn1.setText(str(fn))
        btn1.clicked.connect(lambda:self.load_file(str(folder_name)))

        self.table3.setCellWidget(row,0,btn1) 
        # self.table3.setItem(row,1,QTableWidgetItem(str(file_total)))   

        self.id3 += 1
        self.table3.cellChanged.connect(self.cellchange)  


    def load_file(self, folder_name="common"):
        self.lines = []
        self.id = 1
        #set default_folder
        self.default_folder = folder_name
        #clear table
        self.table.setRowCount(0)
        self.table.clearContents()        
        self.table.cellChanged.connect(self.cellchange)

        # if not os.path.exists(self.file_path):
        #     os.makedirs(self.file_path)
        folder = self.file_path + "/" + folder_name + "/shell/"
        if os.path.isdir(folder):
            names = [name for name in os.listdir(folder)
                    if os.path.isfile(os.path.join(folder, name))]       
            #sort
            names.sort()
            for file_name in names:
                pattern = re.compile(r"^(.*)\.sh$")
                match = pattern.search(file_name)
                if match :
                    data = self.get_info_from_file(folder, file_name)
                    self.to_load_single(data)

    def get_info_from_file(self, folder, file_name):
        data = ["","","",""]
        file_path = folder + "/" + file_name
        file = open(file_path, "r")
        try:
            text_lines = file.readlines()
            text_lines_20 = text_lines[:20]
            for line in text_lines_20:
                # 使用正则表达式提取文件名主体（不包括扩展名）
                pattern = re.compile(r"^(.*)\.sh$")
                match = pattern.search(file_name)
                if match:
                    file_main_name = match.group(1)
                    data[0] = file_main_name
                    # print("File name:", file_main_name)
                # else:
                    # print("Pattern not matched")

                # 使用正则表达式提取Desc :后的内容
                pattern = re.compile(r"# Desc\s*:\s*(.*)")
                match = pattern.search(line)
                if match:
                    function_content = match.group(1)
                    data[1] = function_content.strip()
                    # print("Desc:", function_content)

                # 使用正则表达式提取Version :后的内容
                pattern = re.compile(r"# Version\s*:\s*(.*)")
                match = pattern.search(line)
                if match:
                    function_content = match.group(1)
                    data[2] = function_content.strip()
                    # print("Version:", function_content)  

                # 使用正则表达式提取URL:后的内容
                pattern = re.compile(r"# URL\s*:\s*(.*)")
                match = pattern.search(line)
                if match:
                    function_content = match.group(1)
                    data[3] = function_content.strip()

            return data

        finally:
            file.close()

        


    def to_load_single(self, data): 
        self.table.cellChanged.connect(self.cellchange)
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)
        name = data[0] 
        desc = data[1]        
        # command = data[2]
        version = data[2]

        id = str(self.id)
       
        ck = QCheckBox()
        h = QHBoxLayout()
        h.setAlignment(Qt.AlignCenter)
        h.addWidget(ck)
        w = QWidget()
        w.setLayout(h)

        name_edit = QLineEdit()
        # name_edit.setReadOnly(True) 
        name_edit.setStyleSheet("text-align: left;")
        name_edit.setText(name)
        name_edit.setToolTip(name)

        desc_edit = QLineEdit()
        desc_edit.setReadOnly(True) 
        desc_edit.setStyleSheet("text-align: left;")
        desc_edit.setText(desc)
        desc_edit.setToolTip(desc)

        version_edit = QLineEdit()
        version_edit.setReadOnly(True) 
        version_edit.setText(version)
        version_edit.setToolTip(version)

        install_click = QPushButton("启动")
        install_click.clicked.connect(lambda:self.to_start(int(row)))

        view_click = QPushButton("查看脚本")
        view_click.clicked.connect(lambda:self.to_browse(int(row)))        

        self.table.setCellWidget(row,0,w)
        self.table.setCellWidget(row,1,name_edit)
        self.table.setCellWidget(row,2,desc_edit)
        self.table.setCellWidget(row,3,version_edit)        
        self.table.setCellWidget(row,4,install_click)
        self.table.setCellWidget(row,5,view_click)

        self.id += 1
        self.lines.append([id,ck,name_edit,desc_edit,version_edit,install_click,view_click])
        self.table.cellChanged.connect(self.cellchange)  

    def get_file_time(self, file_name):
        datetime_str = ""
        file_name = self.file_path + "/" + self.default_folder + "/" + file_name
        f = QFile(file_name)
        if not f.open(QIODevice.ReadOnly | QIODevice.Text):
            self.settext("\n file open fail")
            return 

        data = f.readAll()

        error = QJsonParseError()
        jsonObject = QJsonDocument.fromJson(data, error).object()
        jsonObj = jsonObject.get('time')
        if jsonObj :
            jsonArray = jsonObject["time"].toArray()
            for json in jsonArray :
                item = json.toObject()
                datetime_str = item["datetime"].toString()
                # time_str = datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d %H:%M:%S')
                # print(time_str)
                # datetime_str = str(datetime.datetime.strptime(str(time_str),'%Y-%m-%d'))
        
        if datetime_str == "" :
            datetime_str = "2022-07-02"
              
        return datetime_str 

    def to_delete(self, id):
        QMessageBox.information(None, '删除选择的文件', str(id))
        # row = self.table2.currentRow()
        # file_name = self.file_path + "/" + self.default_folder + "/" + str(self.table2.item(row, 0).text())
        # if os.path.exists(file_name) : 
        #     os.remove(file_name)                
        #     self.table2.removeRow(row)

        # for line in self.lines2:
        #     if id == line[0] : 
        #         self.lines2.remove(line)

        self.settext('文件已经删除')         

    def to_load(self, id):
        QMessageBox.information(None, '导入选择的文件', str(id))
        for line in self.lines2:
            if id == line[0] : 
                file_name = line[1]
        file_name = self.file_path + "/" + self.default_folder + "/" + file_name
        f = QFile(file_name)
        if not f.open(QIODevice.ReadOnly | QIODevice.Text):
            self.settext("\n file open fail")
            return 

        data = f.readAll()
        # print(data)
        # return 
        error = QJsonParseError()
        jsonObject = QJsonDocument.fromJson(data, error).object()
        jsonArray = jsonObject["commands"].toArray()
        

        for json in jsonArray :
            item = json.toObject()
            name    = item["name"].toString()
            
            if "desc" in item:
                desc = item["desc"].toString()
            else:
                desc = ""
            
            if "link" in item:
                link    = item["link"].toString()
            else:
                link = "点击'启动'按钮就可"

            command = item["command"].toString()
            data = [name,desc,command,link]
            self.load_line(data)

        self.settext('加载现有数据!')


    def search_commands_lists(self, package_name):
        # print("commands search")    
        #get list
        all = self.load_commands_list()
        #add 
        checked  = self.qc3.isChecked()
        have_one = False
        # print(all)
        for word in all[0] :
            
            if checked:
                if package_name == word :
                    have_one = True
                    index  = all[0].index(word)
                    desc = all[1][index]
                    # command=all[2][index]
                    version=all[3][index]
                    link=all[4][index]
                    data = [word,desc,version,link]
                    # print(data)
                    self.load_line(data)
            else:
                if package_name in word :
                    have_one = True
                    index  = all[0].index(word)
                    desc = all[1][index]
                    # command=all[2][index]
                    version=all[3][index]
                    link=all[4][index]
                    data = [word,desc,version,link]
                    self.load_line(data)
        if have_one:
            self.settext4("找到相应命令,请启动合适的命令")

    def gen_commands_list(self):
        #get list
        folders = []

        for fold in os.listdir(self.file_path):
            sub_fold_name = fold 
            sub_fold_path = self.file_path + "/" + sub_fold_name

            if os.path.isdir(sub_fold_path):
                folders.append(sub_fold_name)        

        all_files = []
        all_commands = []
        all_descs = []
        all_versions = []
        all_links = []
        all_names = []
        all = []

        for folder_name in folders:
            folder = self.file_path + "/" + folder_name + "/shell"
            if os.path.exists(folder):
                files = [name for name in os.listdir(folder)
                        if os.path.isfile(os.path.join(folder, name))]     

                for file in files:
                    # print(file)
                    if ".sh" in file and ".tl" not in file:
                        file_path = folder + "/" + file
                        # print(file_path)
                        all_commands.append(file_path)
                        info = self.get_info_from_file(folder, file)
                        all_names.append(info[0])
                        all_descs.append(info[1])
                        all_versions.append(info[2])
                        all_links.append(info[3])

        all.append(all_names)
        all.append(all_descs)
        all.append(all_commands)
        all.append(all_versions)
        all.append(all_links)

        #save all
        self.write_commands_list(all)

        #gen shell list
        # self.gen_shell_list()

        #return 
        return all

    def write_commands_list(self, all):
        file_name = self.file_path + "/commands_lists.json"
        
        f = QFile(file_name)
        if not f.open(QIODevice.WriteOnly):
            self.settext("\n open fail")
            return 

        content = QByteArray()
        jsonArray1 = QJsonDocument.fromJson(content).array()
        id=1
        #get new waypoits info
        for name in all[0]:
            # print('ID：' + self.table.item(idx,0).text() + 'operate:' + self.table.cellWidget(idx,8).currentText())
        
            jsonItem = QJsonDocument.fromJson(content).object()
            
            index = all[0].index(name)   
            jsonItem["id"]       = id
            jsonItem["name"]     = name
            jsonItem["desc"]     = all[1][index]
            jsonItem["command"]  = all[2][index]
            jsonItem["version"]  = all[3][index]
            jsonItem["link"]     = all[4][index]
            
            jsonArray1.append(jsonItem)  
            id=id+1 
            
        jsonArray2 = QJsonDocument.fromJson(content).object()
        jsonArray2["commands"] = jsonArray1


        jsonArray3 = QJsonDocument.fromJson(content).array()
        jsonItem3 = QJsonDocument.fromJson(content).object()
        jsonItem3["datetime"] = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))
        jsonArray3.append(jsonItem3)
        jsonArray2["time"] = jsonArray3
        
        outputjson = QJsonDocument(jsonArray2).toJson(QJsonDocument.Indented)
        f.write(outputjson)
        f.close()     

    def load_commands_list(self):
        file_name = self.file_path + "/commands_lists.json"

        f = QFile(file_name)
        if not f.open(QIODevice.ReadOnly | QIODevice.Text):
            self.settext("\n open fail")
            return 

        all_commands = []
        all_descs = []
        all_links = []
        all_versions = []
        all_names = []
        all = []
        data = f.readAll()
        # print(data)
        # return 
        error = QJsonParseError()
        jsonObject = QJsonDocument.fromJson(data, error).object()
        jsonArray = jsonObject["commands"].toArray()

        for json in jsonArray :

            item = json.toObject()
            name    = item["name"].toString()
            desc    = item["desc"].toString()
            command = item["command"].toString()
            version = item["version"].toString()
            link    = item["link"].toString()

            all_names.append(name)
            all_descs.append(desc)
            all_commands.append(command)
            all_versions.append(version)
            all_links.append(link)

        all.append(all_names)
        all.append(all_descs)
        all.append(all_commands)
        all.append(all_versions)
        all.append(all_links)
        
        return all
        
        #gen all_shell_list for folder
    def gen_shell_list(self):
        #get list
        folders = []

        file_path = ""
        for fold in os.listdir(self.file_path):
            sub_fold_name = fold 
            sub_fold_path = self.file_path + "/" + sub_fold_name

            if os.path.isdir(sub_fold_path):
                folders.append(sub_fold_name)        

        for folder_name in folders:
            folder = self.file_path + "/" + folder_name + "/shell"
            if os.path.isdir(folder) : 
                files = [name for name in os.listdir(folder)
                        if os.path.isfile(os.path.join(folder, name))]     

                if files : 
                    all_commands = []
                    all_descs = []
                    all_links = []
                    all_names = []
                    all = []
                    files.sort()
                    for file_name in files:
                        
                        if ".sh" not in file_name:
                            continue 

                        name    = file_name
                        desc    = ""
                        command = "cd ~/commands/" + folder_name + ";" + "./shell/" + file_name 
                        link    = ""
                                
                        all_names.append(name)
                        all_descs.append(desc)
                        all_commands.append(command)
                        all_links.append(link)

                    all.append(all_names)
                    all.append(all_descs)
                    all.append(all_commands)
                    all.append(all_links)

                    #save all
                    self.write_shell_list(folder_name, all)

        #return 
        return all

    def write_shell_list(self, folder_name, all):
        file_name = self.file_path + "/" + folder_name + "/all_shell_list.json"
        # print(file_name)
        f = QFile(file_name)
        if not f.open(QIODevice.WriteOnly):
            self.settext("\n open fail")
            return 

        content = QByteArray()
        jsonArray1 = QJsonDocument.fromJson(content).array()
        id=1
        #get new waypoits info
        for name in all[0]:
            # print('ID：' + self.table.item(idx,0).text() + 'operate:' + self.table.cellWidget(idx,8).currentText())
        
            jsonItem = QJsonDocument.fromJson(content).object()
            
            index = all[0].index(name)   
            jsonItem["id"]       = id
            jsonItem["name"]     = name
            jsonItem["desc"]     = all[1][index]
            jsonItem["command"]  = all[2][index]
            jsonItem["link"]     = all[3][index]
            
            jsonArray1.append(jsonItem)  
            id=id+1 
            
        jsonArray2 = QJsonDocument.fromJson(content).object()
        jsonArray2["commands"] = jsonArray1


        jsonArray3 = QJsonDocument.fromJson(content).array()
        jsonItem3 = QJsonDocument.fromJson(content).object()
        jsonItem3["datetime"] = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))
        jsonArray3.append(jsonItem3)
        jsonArray2["time"] = jsonArray3
        
        outputjson = QJsonDocument(jsonArray2).toJson(QJsonDocument.Indented)
        f.write(outputjson)
        f.close()  

    def search_ruby(self, package_name):
        print("ruby")

    def search_python_package_online(self, package_name):
        url = f"https://pypi.org/search/?q={package_name}"
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        
        packages_info = []
        results = soup.find_all('a', class_='package-snippet')
        
        for result in results:
            name = result.find('span', class_='package-snippet__name').text
            version = result.find('span', class_='package-snippet__version').text
            description = result.find('p', class_='package-snippet__description').text.strip()
            
            packages_info.append({
                'name': name,
                'version': version,
                'description': description
            })
        
        return packages_info
    
    def search_python_package(self, package_name):
        # 搜索包信息
        search_result = subprocess.run(['pip', 'search', package_name], stdout=subprocess.PIPE, text=True)
        lines = search_result.stdout.split('\n')
        
        packages_info = []
        pattern = re.compile(r'^(?P<name>\S+) \((?P<version>.+)\) - (?P<description>.+)$')
        for line in lines:
            match = pattern.match(line)
            if match:
                packages_info.append(match.groupdict())
        
        return packages_info

    def get_python_package_info(self, package_name):
        # 获取包详细信息
        show_result = subprocess.run(['pip', 'show', package_name], stdout=subprocess.PIPE, text=True)
        show_lines = show_result.stdout.split('\n')
        
        package_info = {
            'name': package_name,
            'version': '',
            'description': ''
        }
        
        for line in show_lines:
            if line.startswith('Version:'):
                package_info['version'] = line.split('Version:')[1].strip()
            elif line.startswith('Summary:'):
                package_info['description'] = line.split('Summary:')[1].strip()
        
        return package_info
    
    def is_python_package_installed(self, package_name):
        # 检查包是否已安装
        result = subprocess.run(['pip', 'show', package_name], stdout=subprocess.PIPE, text=True)
        return result.returncode == 0

    def search_python(self, package_name):
        packages_info = self.search_python_package_online(package_name)

        if not packages_info:
            self.settext4('没有找到合适的包,请检查名称是否正确')
        
        # 打印搜索到的包信息
        checked = self.qc3.isChecked()
        for pkg_info in packages_info:
            if checked: 
                if package_name == pkg_info['name']:
                    installed = self.is_python_package_installed(package_name)
                    if installed:
                        desc = pkg_info['description'] + "(Installed)"
                        version = pkg_info['version']
                        link = ""
                        data = [pkg_info['name'],desc,version,link]
                        self.load_serach_line(data, True) 
                    else:
                        desc = pkg_info['description'] + "Not Installed"
                        version = pkg_info['version']
                        link = ""
                        data = [pkg_info['name'],desc,version,link]
                        self.load_serach_line(data) 
            else:
                if package_name in pkg_info['name']:
                    installed = self.is_python_package_installed(package_name)
                    if installed:
                        desc = pkg_info['description'] + "(Installed)"
                        version = pkg_info['version']
                        link = ""
                        data = [pkg_info['name'],desc,version,link]
                        self.load_serach_line(data, True) 
                    else:
                        desc = pkg_info['description'] + "Not Installed"
                        version = pkg_info['version']
                        link = ""
                        data = [pkg_info['name'],desc,version,link]
                        self.load_serach_line(data)  


            # print(f"Name: {pkg_info['name']}")
            # print(f"Version: {pkg_info['version']}")
            # print(f"Description: {pkg_info['description']}")
            # print('---')
        # 获取详细信息
        # detailed_info = self.get_package_info(packages_info[0]['name'])
        # print(detailed_info)
        # return detailed_info


    def get_package_info(self, package_name):
        # 获取包详细信息
        result = subprocess.run(['apt-cache', 'show', package_name], stdout=subprocess.PIPE, text=True)
        lines = result.stdout.split('\n')
        
        package_info = {
            'name': package_name,
            'version': '',
            'description': ''
        }
        
        for line in lines:
            if line.startswith('Version:'):
                package_info['version'] = line.split('Version:')[1].strip()
            elif line.startswith('Description:'):
                package_info['description'] = line.split('Description:')[1].strip()
        
        return package_info

    def search_apt(self, package_name):
        # print("apt search")
        checked = self.qc3.isChecked()
        has_pkp = False
        cache = apt.Cache()
        
        for pkg in cache.keys():
            if checked: 
                if package_name == pkg:
                    has_pkp = True
                    my_apt_pkg = cache[pkg]
                    info = self.get_package_info(pkg)
                    if my_apt_pkg.is_installed:
                        desc = info['description'] + "(Installed)"
                        version = info['version']
                        link = ""
                        data = [pkg,desc,version,link]
                        self.load_serach_line(data, True) 
                    else:
                        desc = info['description'] + "Not Installed"
                        version = info['version']
                        link = ""
                        data = [pkg,desc,version,link]
                        self.load_serach_line(data) 
            else:
                if package_name in pkg:
                    has_pkp = True
                    my_apt_pkg = cache[pkg]
                    info = self.get_package_info(pkg)
                    if my_apt_pkg.is_installed:
                        desc = info['description'] + "(Installed)"
                        version = info['version']
                        data = [pkg,desc,version,""]                       
                        self.load_serach_line(data, True)   
                    else:
                        desc = info['description'] + "(Not Installed)"
                        version = info['version']
                        data = [pkg,desc,version,""]
                        self.load_serach_line(data)                
        if has_pkp:                
            self.settext4('搜索到相关包,请选择适合的包进行安装')
        else:
            self.settext4('没有找到合适的包,请检查名称是否正确')

    def load_serach_line(self, data, installed=False):
        self.table.cellChanged.connect(self.cellchange)
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)
        name = data[0] 
        desc = data[1]        
        version = data[2]

        id = str(self.id)
       
        ck = QCheckBox()
        h = QHBoxLayout()
        h.setAlignment(Qt.AlignCenter)
        h.addWidget(ck)
        w = QWidget()
        w.setLayout(h)

        name_edit = QLineEdit()
        # name_edit.setReadOnly(True) 
        name_edit.setStyleSheet("text-align: left;")
        name_edit.setText(name)
        name_edit.setToolTip(name)

        desc_edit = QLineEdit()
        desc_edit.setReadOnly(True) 
        desc_edit.setStyleSheet("text-align: left;")
        desc_edit.setText(desc)
        desc_edit.setToolTip(desc)

        version_edit = QLineEdit()
        version_edit.setReadOnly(True) 
        version_edit.setText(version)
        version_edit.setToolTip(version)

        if installed : 
            install_click = QPushButton("已经安装")
        else:
            install_click = QPushButton("立刻安装")
            install_click.clicked.connect(lambda:self.to_install_apt(int(row)))

        if installed:
            view_click = QPushButton("卸载")
            view_click.clicked.connect(lambda:self.to_uninstall_apt(int(row)))    
        else:
            view_click = QPushButton("")    

        self.table.setCellWidget(row,0,w)
        self.table.setCellWidget(row,1,name_edit)
        self.table.setCellWidget(row,2,desc_edit)
        self.table.setCellWidget(row,3,version_edit)        
        self.table.setCellWidget(row,4,install_click)
        self.table.setCellWidget(row,5,view_click)

        self.id += 1
        self.lines.append([id,ck,name_edit,desc_edit,version_edit,install_click,view_click])
        self.table.cellChanged.connect(self.cellchange)  

    def search_line(self):
        # print("search")
        #search commands
        self.clear_commands()
        package_name = self.ql3.text()
        if package_name : 
            checked4  = self.qc4.isChecked()
            if checked4:
                self.search_commands_lists(package_name)

            #search apt_cache
            checked5  = self.qc5.isChecked()
            if checked5:
                self.search_apt(package_name)

            # #search python
            # checked6  = self.qc6.isChecked()
            # if checked6:
            #     self.search_python(package_name)

            # #search ruby
            # checked7  = self.qc7.isChecked()
            # if checked7:
            #     self.search_ruby(package_name)
        else:
            print("keywords can not be empty!")
            self.settext4('关键词不能为空')

    def script_manager(self):
        """
        想要有新的窗口， 引用其它已经写好的类
        """
        import script
        self.script = script.ScriptManagerWindow()
        self.script.show()   

    def category_manager(self):
        """
        想要有新的窗口， 引用其它已经写好的类
        """
        import category 
        self.category = category.CategoryManagerWindow()
        self.category.show()        
        

    def add_line(self):
        data = ["","","",""]
        self.load_line(data)

    def load_line(self, data):
        
        self.table.cellChanged.connect(self.cellchange)
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)
        name = data[0] 
        desc = data[1]        
        version = data[2]

        id = str(self.id)
       
        ck = QCheckBox()
        h = QHBoxLayout()
        h.setAlignment(Qt.AlignCenter)
        h.addWidget(ck)
        w = QWidget()
        w.setLayout(h)

        name_edit = QLineEdit()
        # name_edit.setReadOnly(True) 
        name_edit.setStyleSheet("text-align: left;")
        name_edit.setText(name)
        name_edit.setToolTip(name)

        desc_edit = QLineEdit()
        desc_edit.setReadOnly(True) 
        desc_edit.setStyleSheet("text-align: left;")
        desc_edit.setText(desc)
        desc_edit.setToolTip(desc)

        version_edit = QLineEdit()
        version_edit.setReadOnly(True) 
        version_edit.setText(version)
        version_edit.setToolTip(version)

        install_click = QPushButton("启动")
        install_click.clicked.connect(lambda:self.to_start(int(row)))

        view_click = QPushButton("查看脚本")
        view_click.clicked.connect(lambda:self.to_browse(int(row)))        

        self.table.setCellWidget(row,0,w)
        self.table.setCellWidget(row,1,name_edit)
        self.table.setCellWidget(row,2,desc_edit)
        self.table.setCellWidget(row,3,version_edit)        
        self.table.setCellWidget(row,4,install_click)
        self.table.setCellWidget(row,5,view_click)

        self.id += 1
        self.lines.append([id,ck,name_edit,desc_edit,version_edit,install_click,view_click])
        self.table.cellChanged.connect(self.cellchange) 

    def to_uninstall_apt(self, id):
        result = self.show_message_box("你是否启动第" + str(id+1) + "条命令")
        if result == QMessageBox.Ok:
            widget = self.table.cellWidget(id, 1)
            if isinstance(widget, QLineEdit):
                command = "sudo apt remove  " + widget.text()
                wt = WorkThread()
                wt.setCommand(command)
                self.threads[id] = wt
                wt.start()  

    def to_install_apt(self, id):
        result = self.show_message_box("你是否启动第" + str(id+1) + "条命令")
        if result == QMessageBox.Ok:
            widget = self.table.cellWidget(id, 1)
            if isinstance(widget, QLineEdit):
                command = "sudo apt install -y " + widget.text()
                wt = WorkThread()
                wt.setCommand(command)
                self.threads[id] = wt
                wt.start()                

    def to_browse(self, id):
        result = self.show_message_box("你是否查看第" + str(id+1) + "条命令内容")
        if result == QMessageBox.Ok:
            widget = self.table.cellWidget(id, 1)
            if isinstance(widget, QLineEdit):
                all = self.load_commands_list()
                # print(1)
                for word in all[0] :
                    # print(word)
                    # print(widget.text())
                    if widget.text() == word:
                        index  = all[0].index(word)
                        file_full_path = all[2][index]
                        # print(file_full_path)
                        if os.path.isfile(file_full_path):
                            with open(file_full_path, 'r', encoding='utf-8') as file:
                                fileContent = file.read()
                                self.showTextWindow(fileContent, widget.text())

    def showTextWindow(self, text, name):
        textWindow = QDialog(self)
        textWindow.setWindowTitle(name)

        layout = QVBoxLayout()

        textEdit = QTextEdit(textWindow)
        textEdit.setPlainText(text)
        layout.addWidget(textEdit)

        closeButton = QPushButton('Close', textWindow)
        closeButton.clicked.connect(textWindow.accept)
        layout.addWidget(closeButton)

        textWindow.setLayout(layout)
        textWindow.resize(600, 400)
        textWindow.exec_()

    def to_start(self, id):
        result = self.show_message_box("你是否启动第" + str(id+1) + "条命令")
        if result == QMessageBox.Ok:
            widget = self.table.cellWidget(id, 1)
            if isinstance(widget, QLineEdit):
                all = self.load_commands_list()
                for word in all[0] :
                    if widget.text() == word:
                        index  = all[0].index(word)
                        file_full_path = all[2][index]
                        # print(file_full_path)
                        if os.path.isfile(file_full_path):
                            wt = WorkThread()
                            wt.setCommand(file_full_path)
                            self.threads[id] = wt
                            wt.start()

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

    def del_line(self):
        removeline = []
        for line in self.lines:
            if line[1].isChecked():
                row = self.table.rowCount()
                for x in range(row,0,-1):
                    if line[0] == self.table.item(x - 1,0).text():
                        self.table.removeRow(x - 1)
                        removeline.append(line)
        for line in removeline:
            self.lines.remove(line)
        self.settext('删除在左边checkbox中选中的行！')
    
  
    def cellchange(self,row,col):
        return 1
        # item = self.table.item(row,col)
        # txt = item.text()
        # self.settext('第%s行，第%s列 , 数据改变为:%s'%(row,col,txt))

    def save_commands(self):

        file_name, file_type = QFileDialog.getSaveFileName(self,
            "Choose File", 
            self.cwd,
            "json (*.json);;All Files (*)")
        
        if file_name == "":
            self.settext("\n cancel choose")
            return 

        self.settext('You choose file:' + file_name + ',\n filetype is: ' + file_type)

        f = QFile(file_name)
        if not f.open(QIODevice.WriteOnly):
            self.settext("\n open fail")
            return 

        content = QByteArray()
        jsonArray1 = QJsonDocument.fromJson(content).array()

        #get new waypoits info
        for idx in range(self.table.rowCount()):
            # print('ID：' + self.table.item(idx,0).text() + 'operate:' + self.table.cellWidget(idx,8).currentText())
        
            jsonItem = QJsonDocument.fromJson(content).object()

            jsonItem["id"]       = self.table.item(idx,0).text()
            jsonItem["name"]     = self.table.cellWidget(idx,2).text()
            jsonItem["desc"]     = self.table.cellWidget(idx,3).text()
            jsonItem["command"]    = self.table.cellWidget(idx,4).text()
            jsonItem["link"]     = self.table.cellWidget(idx,5).text()            
            jsonArray1.append(jsonItem)   
            
        
        jsonArray2 = QJsonDocument.fromJson(content).object()
        jsonArray2["commands"] = jsonArray1

        jsonArray3 = QJsonDocument.fromJson(content).array()
        jsonItem3 = QJsonDocument.fromJson(content).object()
        jsonItem3["datetime"] = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))
        jsonArray3.append(jsonItem3)
        jsonArray2["time"] = jsonArray3        
        
        outputjson = QJsonDocument(jsonArray2).toJson(QJsonDocument.Indented)
        f.write(outputjson)
        f.close()     
        #auto update files 
        self.load_folder()
        self.load_file(self.default_folder)
        self.gen_commands_list()

    def save_shell(self):

        #save json file
        file_name, file_type = QFileDialog.getSaveFileName(self,
            "Choose File", 
            self.cwd,
            "json (*.json);;All Files (*)")
        
        if file_name == "":
            self.settext("\n cancel choose")
            return 

        self.settext('You choose file:' + file_name + ',\n filetype is: ' + file_type)
        # print(file_name)

        path_array = (file_name.split("/"))
        # print(path_array)
        # print(len(path_array))
        #only save on /home/ubuntu/commands/xxxx 
        if len(path_array) != 6 :
            self.settext("没有保存到正确分类下如/home/ubuntu/commands/common")
            return 

        f_name = path_array[-1]
        f_fold = path_array[-2]

        f_name_array = f_name.split(".")
        f_fold2 = "/" + path_array[1] + "/" + path_array[2] + "/" + path_array[3]  + "/" + path_array[4]
        # print(f_fold2)
        shell_name = f_name_array[-2] + ".sh"
        shell_path = f_fold2 + "/shell"
        # print(shell_path)
        if not os.path.exists(shell_path):
            os.makedirs(shell_path)

        shell_file = shell_path + "/" + shell_name

        fs = QFile(shell_file)
        if not fs.open(QIODevice.WriteOnly):
            self.settext("\n open fail")
            return 

        content = QByteArray()
        content.append("#!/bin/bash")
        date = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        header = """
################################################
# Function : {0}                              
# Platform : {1}                                
# Version  : {2}                               
# Date     : {3}                            
# Author   : {4}                             
# Contact  : {5}                              
# URL: {6}                                   
# Licnese: {7}                                 
# QQ Qun: {8}                                  
# QQ Qun: {9}                               
# QQ Qun: {10}                               
################################################
        """.format(shell_name, "ubuntu", "1.0", date, "ncnynl", self.email, self.website, self.license, self.qq1, self.qq2, self.qq3)
        content.append(header)
        content.append("\n\n")
        #get new waypoits info
        for idx in range(self.table.rowCount()):
            
            content.append("#run " + self.table.cellWidget(idx,2).text())
            content.append("\n\n")
            content.append("# " + self.table.cellWidget(idx,3).text())
            content.append("\n\n")
            content.append(self.table.cellWidget(idx,4).text())
            content.append("\n\n")

        fs.write(content)
        fs.close()             
        #perm 
        os.system("chmod +x " + shell_file)
        
        f = QFile(file_name)
        if not f.open(QIODevice.WriteOnly):
            self.settext("\n open fail")
            return 

         
        content = QByteArray()
        jsonArray1 = QJsonDocument.fromJson(content).array()

        #get new waypoits info
            # print('ID：' + self.table.item(idx,0).text() + 'operate:' + self.table.cellWidget(idx,8).currentText())
        jsonItem = QJsonDocument.fromJson(content).object()

        jsonItem["id"]       = 0
        jsonItem["name"]     =  f_name_array[-2]
        jsonItem["desc"]     =  ""
        jsonItem["command"]  =  "cd " + f_fold2 + "; ./shell/" + shell_name
        jsonItem["link"]     =  ""

        
        jsonArray1.append(jsonItem)   
            
        
        jsonArray2 = QJsonDocument.fromJson(content).object()
        jsonArray2["commands"] = jsonArray1

        jsonArray3 = QJsonDocument.fromJson(content).array()
        jsonItem3 = QJsonDocument.fromJson(content).object()
        jsonItem3["datetime"] = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))
        jsonArray3.append(jsonItem3)
        jsonArray2["time"] = jsonArray3     

        outputjson = QJsonDocument(jsonArray2).toJson(QJsonDocument.Indented)
        f.write(outputjson)
        f.close()     
        #update
        self.load_folder()
        self.load_file(self.default_folder)
        self.gen_commands_list()        

    def clear_commands(self):
        self.id = 1
        self.table.setRowCount(0)
        self.table.clearContents()
        self.lines = []
        self.settext('已清除命令列表!')

    def share_commands(self):
        """
        想要有新的窗口， 引用其它已经写好的类
        """
        import share
        self.share_commands = share.ShareCommandLayout()
        self.share_commands.show()

    def resource_commands(self):
        """
        想要有新的窗口， 引用其它已经写好的类
        """
        import resources
        self.resources_layout = resources.ResourcesLayout()
        self.resources_layout.show()

    def upgrade_commands(self):
        
        command = "wget -O /tmp/version.txt https://gitee.com/ncnynl/commands/raw/master/version.txt"
        os.system(command)
        file_name = "/tmp/version.txt"

        try:
            f = open(file_name, 'r')
            new_version = f.read()

            print(self.version)
            print(new_version)

            if new_version not in self.version : 
                reply = QMessageBox.question(self, '升级提示', '发现新版本, 是否需要执行升级？ 升级会自动先关闭commands', QMessageBox.Yes, QMessageBox.No)
                if reply == QMessageBox.Yes:

                    #install 
                    command_sub   = "pkill commands ; cd /tmp/; rm online.sh ; wget https://gitee.com/ncnynl/commands/raw/master/online.sh ; chmod +x ./online.sh ;  ./online.sh "
                    command_start = "gnome-terminal -- bash -c 'source ~/.bashrc;"
                    command_end   = ";bash'"
                    command = command_start + command_sub + command_end
                    os.system(command)   

                    self.settext('升级命令管理器完成,请关闭后,重新启动命令管理器!')                
                else:
                    self.settext('升级已经取消!')              
            else:
                self.settext('目前' + self.version + '已经最新版本不需要更新!')
                QMessageBox.information(self, '升级提示', '已经最新版本不需要更新!', QMessageBox.Yes)

        except IOError as e:
            print("IOError:",e) 
        finally:
            if f:
                f.close()

    def kill_commands(self):
        
        reply = QMessageBox.question(self, '警告', '确认是否关闭所有已启动命令？', QMessageBox.Yes, QMessageBox.No)
        if reply == QMessageBox.Yes:

            #kill 
            command_sub   = "cd ~/commands/common; ./shell/close_commands.sh"
            command_start = "gnome-terminal -- bash -c 'source ~/.bashrc;"
            command_end   = ";bash'"
            command = command_start + command_sub + command_end
            os.system(command)   

            self.settext('完成关闭所有已启动命令!')                
        else:
            self.settext('已经取消关闭操作!')              

    def update_folder(self):
        self.load_folder()
        self.load_file("common")
        self.gen_commands_list() 
        self.settext('命令集分类已经更新完成!')   
        QMessageBox.information(self, '更新分类集提示', '命令集分类已经更新完成!', QMessageBox.Yes)  



    def load_commands(self):

        file_name, file_type = QFileDialog.getOpenFileName(self,
            "Choose File", 
            self.cwd,
            "json (*.json);;All Files (*)")  

        f = QFile(file_name)
        if not f.open(QIODevice.ReadOnly | QIODevice.Text):
            self.settext("\n open fail")
            return 

        data = f.readAll()
        # print(data)
        # return 
        error = QJsonParseError()
        jsonObject = QJsonDocument.fromJson(data, error).object()
        jsonArray = jsonObject["commands"].toArray()

        for json in jsonArray :
            item = json.toObject()
            name    = item["name"].toString()
            if "desc" in item:
                desc = item["desc"].toString()
            else:
                desc = ""

            if "link" in item:
                link = item["link"].toString()
            else:
                link = ""

            command = item["command"].toString()
            data = [name,desc,command,link]
            self.load_line(data)

        self.settext('加载现有数据!')

    def settext(self,txt):
        font = QFont('微软雅黑',10)
        self.txt.setFont(font)
        self.txt.setText(txt)

    def settext4(self,txt):
        font = QFont('微软雅黑',10)
        self.txt4.setFont(font)
        self.txt4.setText(txt)   

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ui = ui()
    sys.exit(app.exec_())
