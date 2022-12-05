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

import webbrowser
from PyQt5.QtWidgets import (
    QApplication, QTableWidget, QWidget, QPushButton,
    QVBoxLayout, QLabel, QHBoxLayout, QCheckBox,
    QCheckBox, QLineEdit, QTableWidgetItem, QMessageBox,
    QFileDialog,QHeaderView,QSpacerItem,QSizePolicy,
    QAbstractItemView
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
        self.last_edited = "2022-10-26"
        self.author = "ncnynl"
        self.email  = "1043931@qq.com"
        self.website  = "https://ncnynl.com"
        self.license  = "MIT"
        self.qq1  = "创客智造B群:926779095"
        self.qq2  = "创客智造C群:937347681"
        self.qq3  = "创客智造D群:562093920"
        self.qq   =  self.qq1  + "\n" + self.qq2 + "\n" + self.qq3
        self.lines2 = []
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
        self.btn_add.clicked.connect(self.add_line)
        self.btn_del.clicked.connect(self.del_line)
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

    def getVersion(self):
        self.version_file_path = os.path.expanduser('~') + '/tools/commands/version.txt'
        f = open(self.version_file_path)
        content = f.read()
        f.close
        return content

    def setupUI(self):
        self.setWindowTitle('ROS命令管理器(简称RCM) v'+self.version)
        self.resize(640,480)
        self.table = QTableWidget(self)
        
        self.btn_add = QPushButton('增加')
        self.btn_del = QPushButton('删除')
        self.btn_save_commands = QPushButton('保存命令列表')
        self.btn_save_shell = QPushButton('生成SHELL脚本')
        self.btn_load_commands = QPushButton('加载命令列表')
        self.btn_clear_commands = QPushButton('清空命令列表')
        self.btn_share_commands = QPushButton('管理共享命令集')     
        self.btn_resource = QPushButton('管理ROS2资源')          
        self.btn_update_folder = QPushButton('更新命令集目录')   
        self.btn_upgrade_commands = QPushButton('升级命令管理器')
        self.btn_kill_commands = QPushButton('关闭已启动命令')
        


        self.spacerItem = QSpacerItem(20, 20, QSizePolicy.Minimum, QSizePolicy.Expanding)
        
        self.vbox = QVBoxLayout()
        self.vbox.addWidget(self.btn_add)
        self.vbox.addWidget(self.btn_del)
        self.vbox.addWidget(self.btn_save_commands)
        self.vbox.addWidget(self.btn_save_shell)
        self.vbox.addWidget(self.btn_load_commands)
        self.vbox.addWidget(self.btn_clear_commands)
        self.vbox.addWidget(self.btn_share_commands)
        self.vbox.addWidget(self.btn_resource)
        self.vbox.addWidget(self.btn_update_folder)        
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


        self.table.setColumnCount(8)   ##设置列数
        self.headers = ['序号', '选择', '名称', '描述', '命令', '使用说明', '启动', '浏览说明']
        self.table.setHorizontalHeaderLabels(self.headers)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(6, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(7, QHeaderView.ResizeToContents)

        
        self.table2 = QTableWidget(self)
        self.table2.setColumnCount(4)
        self.table2.setSelectionBehavior(1)
        self.table2.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.headers2 = ['文件', '时间', '导入', '删除']
        self.table2.setHorizontalHeaderLabels(self.headers2)    
        self.table2.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)    
        self.table2.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)   
        self.table2.horizontalHeader().setSectionResizeMode(2, QHeaderView.ResizeToContents)   
        self.table2.horizontalHeader().setSectionResizeMode(3, QHeaderView.ResizeToContents)   

        self.table3 = QTableWidget(self)
        self.table3.setColumnCount(2)
        self.table3.setSelectionBehavior(1)
        self.table3.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.headers3 = ['目录', '文件数']
        self.table3.setHorizontalHeaderLabels(self.headers3)    
        self.table3.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)    
        self.table3.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)


        self.txt3 = QLabel()
        self.txt3.setMinimumHeight(50)      
        self.txt3.setText("名称")  

        self.ql3 = QLineEdit()
        self.qc3 = QCheckBox()
        self.qc3.setText("精确")
        self.qc3.setChecked(True)
        self.btn_search = QPushButton('搜索')


        self.hbox2 = QHBoxLayout()
        self.hbox2.addWidget(self.table3)
        self.hbox2.addWidget(self.table2)


        self.hbox3 = QHBoxLayout()
        self.hbox3.addWidget(self.txt3)       
        self.hbox3.addWidget(self.ql3)       
        self.hbox3.addWidget(self.qc3)       
        self.hbox3.addWidget(self.btn_search)   

        self.txt4 = QLabel()
        self.txt4.setMinimumHeight(50)
        self.txt4.setText("请输入关键词进行搜索, 默认精确搜索,也可以选择模糊搜索")

        self.vbox2 = QVBoxLayout()
        self.vbox2.addLayout(self.hbox3)
        self.vbox2.addWidget(self.txt4)
        self.vbox2.addWidget(self.table)
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
            sub_fold_path = self.file_path + "/" + folder_name  
            names = [name for name in os.listdir(sub_fold_path)
                if os.path.isfile(os.path.join(sub_fold_path, name))  if "json" in name ]  
                        
            self.to_load_single_folder(folder_name, len(names))            

        self.table3.selectRow(0)
        self.table3.setFocus()

    def to_load_single_folder(self, folder_name, file_total): 
        id = self.id3
        self.table3.cellChanged.disconnect()
        row = self.table3.rowCount()
        self.table3.setRowCount(row + 1)
        fn = self.file_path + "/" + folder_name
        btn1 = QPushButton()
        btn1.setStyleSheet("QPushButton{text-align : left;}")
        btn1.setText(str(fn))
        btn1.clicked.connect(lambda:self.load_file(str(folder_name)))

        self.table3.setCellWidget(row,0,btn1) 
        self.table3.setItem(row,1,QTableWidgetItem(str(file_total)))   

        self.id3 += 1
        self.table3.cellChanged.connect(self.cellchange)  


    def load_file(self, folder_name="common"):

        self.id2 = 1
        self.table2.setRowCount(0)
        self.table2.clearContents()        
        self.table2.cellChanged.connect(self.cellchange)

        #set default_folder
        self.default_folder = folder_name
        

        # if not os.path.exists(self.file_path):
        #     os.makedirs(self.file_path)
        folder = self.file_path + "/" + folder_name
        names = [name for name in os.listdir(folder)
                if os.path.isfile(os.path.join(folder, name))]       
        #sort
        names.sort()
        for file_name in names:
            if "json" in file_name:
                self.to_load_single(file_name)


    def to_load_single(self, file_name): 
        id = self.id2
        self.table2.cellChanged.disconnect()
        row = self.table2.rowCount()
        self.table2.setRowCount(row + 1)
        # fn = self.file_path + "/" + file_name
        fn = file_name
        btn1 = QPushButton("导入")
        btn1.clicked.connect(lambda:self.to_load(int(id)))
        btn2 = QPushButton("删除")
        btn2.clicked.connect(lambda:self.to_delete(int(id)))    

        datetime  = self.get_file_time(file_name)
        self.table2.setItem(row,0,QTableWidgetItem(str(fn)))    
        self.table2.setItem(row,1,QTableWidgetItem(datetime))
        self.table2.setCellWidget(row,2,btn1)
        self.table2.setCellWidget(row,3,btn2)

        self.id2 += 1
        self.lines2.append([id,fn,btn1,btn2])
        self.table2.cellChanged.connect(self.cellchange)  

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
        row = self.table2.currentRow()
        file_name = self.file_path + "/" + self.default_folder + "/" + str(self.table2.item(row, 0).text())
        if os.path.exists(file_name) : 
            os.remove(file_name)                
            self.table2.removeRow(row)

        for line in self.lines2:
            if id == line[0] : 
                self.lines2.remove(line)

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


    def search_commands_lists(self):
        # print("commands search")    
        #get list
        all = self.load_commands_list()
        #add 
        keywords = self.ql3.text()
        checked  = self.qc3.isChecked()
        have_one = False
        for word in all[0] :
            if checked:
                if keywords == word :
                    have_one = True
                    index  = all[0].index(word)
                    desc = all[1][index]
                    command=all[2][index]
                    link=all[3][index]
                    data = [word,desc,command,link]
                    self.load_line(data)
            else:
                if keywords in word :
                    have_one = True
                    index  = all[0].index(word)
                    desc = all[1][index]
                    command=all[2][index]
                    link=all[3][index]
                    data = [word,desc,command,link]
                    self.load_line(data)
        if have_one:
            self.settext4("找到相应命令,请启动合适的命令")

    def gen_commands_list(self):
        #get list
        folders = []

        file_path = ""
        for fold in os.listdir(self.file_path):
            sub_fold_name = fold 
            sub_fold_path = self.file_path + "/" + sub_fold_name

            if os.path.isdir(sub_fold_path):
                folders.append(sub_fold_name)        

        all_files = []
        for folder_name in folders:
            folder = self.file_path + "/" + folder_name
            files = [name for name in os.listdir(folder)
                    if os.path.isfile(os.path.join(folder, name))]     

            for file in files:
                all_files.append(folder + "/" + file)

        all_commands = []
        all_descs = []
        all_links = []
        all_names = []
        all = []
        for  file_name in  all_files:
            #only json file can be read
            if "json" in file_name:
                f = QFile(file_name)
                if not f.open(QIODevice.ReadOnly):
                    self.settext("\n file open fail")
                    return       
            else:
                continue 

            data = f.readAll()
            # print(data)
            error = QJsonParseError()
            jsonObject = QJsonDocument.fromJson(data, error).object()
            jsonArray = jsonObject["commands"].toArray()

            for item in jsonArray :

                name    = item["name"].toString()
                desc    = item["desc"].toString()
                command = item["command"].toString()
                link    = item["link"].toString()
                         
                all_names.append(name)
                all_descs.append(desc)
                all_commands.append(command)
                all_links.append(link)

        all.append(all_names)
        all.append(all_descs)
        all.append(all_commands)
        all.append(all_links)

        #save all
        self.write_commands_list(all)

        #gen shell list
        self.gen_shell_list()

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

    def load_commands_list(self):
        file_name = self.file_path + "/commands_lists.json"

        f = QFile(file_name)
        if not f.open(QIODevice.ReadOnly | QIODevice.Text):
            self.settext("\n open fail")
            return 

        all_commands = []
        all_descs = []
        all_links = []
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
            link    = item["link"].toString()

            all_names.append(name)
            all_descs.append(desc)
            all_commands.append(command)
            all_links.append(link)

        all.append(all_names)
        all.append(all_descs)
        all.append(all_commands)
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
                        
                        if "sh" not in file_name:
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

    def search_apt_cache(self):
        # print("apt search")
        pkgname = self.ql3.text()
        checked = self.qc3.isChecked()
        
        has_pkp = False
        cache = apt.Cache()
        for pkg in cache.keys():
            if checked: 
                if pkgname == pkg:
                    has_pkp = True
                    my_apt_pkg = cache[pkg]
                    command = "sudo apt install -y " + pkg
                    if my_apt_pkg.is_installed:
                        desc = "From APT Repo"
                        link = ""
                        data = [pkg,desc,command,link]
                        self.load_serach_line(data, True)   
                    else:
                        desc = "From APT Repo"
                        link = ""
                        data = [pkg,desc,command,link]
                        self.load_serach_line(data) 
            else:
                if pkgname in pkg:
                    has_pkp = True
                    my_apt_pkg = cache[pkg]
                    command = "sudo apt install -y " + pkg
                    if my_apt_pkg.is_installed:
                        desc = "From APT Repo"
                        link = ""
                        data = [pkg,desc,command,link]                       
                        self.load_serach_line(data, True)   
                    else:
                        desc = "From APT Repo"
                        link = "点击按钮,一键安装"
                        data = [pkg,desc,command,link]
                        self.load_serach_line(data)                
        if has_pkp:                
            self.settext4('搜索到相关包,请选择适合的包进行安装')
        else:
            self.settext4('没有找到合适的包,请检查名称是否正确')

    def load_serach_line(self, data, installed=False):
        self.table.cellChanged.disconnect()
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)

        id = str(self.id)
        name = data[0]
        desc = data[1]
        command = data[2]
        link = data[3]  

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

        le3 = QLineEdit()
        le3.setText(command)
        le3.setToolTip(command)

        le4 = QLineEdit()
        le4.setText(link)        
        le4.setToolTip(link)        
        
        if installed:
            btn1 = QPushButton("已经安装")
        else:
            btn1 = QPushButton("立刻安装")
            btn1.clicked.connect(lambda:self.to_start(int(id)))


        btn2 = QPushButton("浏览说明")
        btn2.clicked.connect(lambda:self.to_browse(int(id)))              

        self.table.setItem(row,0,QTableWidgetItem(id))
        self.table.setCellWidget(row,1,w)
        self.table.setCellWidget(row,2,le1)
        self.table.setCellWidget(row,3,le2)
        self.table.setCellWidget(row,4,le3)
        self.table.setCellWidget(row,5,le4)
        self.table.setCellWidget(row,6,btn1)
        self.table.setCellWidget(row,7,btn2)

        self.id += 1
        self.lines.append([id,ck,le1,le2,btn1,btn2])
        self.table.cellChanged.connect(self.cellchange)   

    def search_line(self):
        # print("search")
        #search commands
        self.search_commands_lists()
        #search apt_cache
        self.search_apt_cache()


 
    def add_line(self):
        data = ["","","",""]
        self.load_line(data)

    def load_line(self, data):

        self.table.cellChanged.disconnect()
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)

        name = data[0] 
        desc = data[1]        
        command = data[2]
        link = data[3]

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

        le3 = QLineEdit()
        le3.setText(command)
        le3.setToolTip(command)

        le4 = QLineEdit()
        le4.setText(link)
        le4.setToolTip(link)

        btn1 = QPushButton("启动")
        btn1.clicked.connect(lambda:self.to_start(int(id)))

        btn2 = QPushButton("浏览说明")
        btn2.clicked.connect(lambda:self.to_browse(int(id)))        

        self.table.setItem(row,0,QTableWidgetItem(id))
        self.table.setCellWidget(row,1,w)
        self.table.setCellWidget(row,2,le1)
        self.table.setCellWidget(row,3,le2)
        self.table.setCellWidget(row,4,le3)
        self.table.setCellWidget(row,5,le4)        
        self.table.setCellWidget(row,6,btn1)
        self.table.setCellWidget(row,7,btn2)

        self.id += 1
        self.lines.append([id,ck,le1,le2,le3,le4,btn1,btn2])
        self.settext('自动生成随机一行数据！,checkbox设置为居中显示')
        self.table.cellChanged.connect(self.cellchange)  

    def to_browse(self, id):
        for idx in range(self.table.rowCount()):
            if id == int(self.table.item(idx,0).text()):
                command = self.table.cellWidget(idx,5).text()
                if "http" in command:
                    webbrowser.open_new_tab(command)
                else:
                    QMessageBox.information(None, '提醒', '不是可浏览的页面')
    
    def to_start(self, id):
        QMessageBox.information(None, '启动选择的命令', str(id))
        for idx in range(self.table.rowCount()):
            if id == int(self.table.item(idx,0).text()):
                command = self.table.cellWidget(idx,4).text()
                # print('id:' + self.table.item(idx,0).text() + ' \n name:' + self.table.cellWidget(idx,2).text() + '\n command:' + self.table.cellWidget(idx,3).text())
                # new thread to do 
                wt = WorkThread()
                wt.setCommand(command)
                self.threads[id] = wt
                wt.start()

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
            self.settext("没有保存到正确目录下如/home/ubuntu/commands/common")
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
                reply = QMessageBox.question(self, '警告', '发现新版本, 是否需要执行升级？ 升级会自动先关闭commands', QMessageBox.Yes, QMessageBox.No)
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
        self.settext('命令集目录已经更新完成!')     


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
