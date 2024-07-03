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

class DownloadThread(QThread):
    trigger = pyqtSignal()

    def __init__(self):
        super(DownloadThread, self).__init__()
        self.command = ""
        self.command_start = "gnome-terminal -- bash -c 'source ~/.bashrc;"
        self.command_end   = ";bash'"

    def setCommand(self, command):
        self.command = self.command_start + command + self.command_end

    def run(self):
        os.system(self.command)
        # 循环完毕后发出信号
        self.trigger.emit()

class ResourcesLayout(QWidget):
    def __init__(self,parent=None):
        super(ResourcesLayout,self).__init__(parent)
        self.setWindowTitle("资源管理器") 
        self.resize(640,480)


        self.id =1
        self.lines = []
        self.threads = {}
        self.editable = True
        self.des_sort = True
        self.file_path = os.path.expanduser('~') + '/commands'
        self.folder_path = os.path.expanduser('~') + '/tools/rcm_resources'
        self.cwd = self.file_path
        self.configs = ["git", "iso", "http/s"]


        self.table = QTableWidget(self)
        
        self.btn_add = QPushButton('增加')
        self.btn_del = QPushButton('删除')
        self.btn_save_commands = QPushButton('保存资源列表')
        self.btn_load_commands = QPushButton('加载资源列表')


        self.btn_add.clicked.connect(self.add_line)
        self.btn_del.clicked.connect(self.del_line)
        self.table.cellChanged.connect(self.cellchange)
        self.btn_save_commands.clicked.connect(self.save_commands)
        self.btn_load_commands.clicked.connect(self.load_commands)

        self.spacerItem = QSpacerItem(20, 20, QSizePolicy.Minimum, QSizePolicy.Expanding)
        
        self.vbox = QVBoxLayout()
        self.vbox.addWidget(self.btn_add)
        self.vbox.addWidget(self.btn_del)
        self.vbox.addWidget(self.btn_save_commands)
        self.vbox.addWidget(self.btn_load_commands)

        self.vbox.addSpacerItem(self.spacerItem)  #可以用addItem也可以用addSpacerItem方法添加
        self.vtxt = QLabel()
        self.vtxt.setMinimumHeight(50) 
        desc = "分享ROS资源联系作者"
        self.vtxt.setText(desc)
        self.vbox.addWidget(self.vtxt)

        self.txt = QLabel()
        self.txt.setMinimumHeight(50)

        self.table.setColumnCount(11)   ##设置列数
        self.headers = ['序号', '选择', '名称',  '地址',  '描述', '使用说明', '作者/邮箱', '时间', '类型',  '下载', '浏览说明']
        self.table.setHorizontalHeaderLabels(self.headers)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(7, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(8, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(9, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(10, QHeaderView.ResizeToContents)

        self.vbox2 = QVBoxLayout()
        self.vbox2.addWidget(self.table)
        self.vbox2.addWidget(self.txt)

        self.hbox = QHBoxLayout()
        self.hbox.addLayout(self.vbox2)
        self.hbox.addLayout(self.vbox)
        self.setLayout(self.hbox)
        #default loads
        self.load_default()

    def add_line(self):
        data = ["","","","","",0,""]
        self.load_line(data)

    def load_line(self, data):

        self.table.cellChanged.disconnect()
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)

        name = data[0] 
        repo = data[1]
        desc = data[2]
        usage  = data[3]        
        email = data[4]
        type = data[5]
        if data[6] == "" :
            time_str = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))
        else:
            time_str = data[6]

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
        le2.setText(repo)        
        le2.setToolTip(repo)        

        le3 = QLineEdit()
        le3.setText(desc)
        le3.setToolTip(desc)

        le4 = QLineEdit()
        le4.setText(usage)
        le4.setToolTip(usage)

        le5 = QLineEdit()
        le5.setText(email)
        le5.setToolTip(email)

        cb1 = QComboBox()
        cb1.addItems(self.configs)
        cb1.setCurrentIndex(type)

        


        btn1 = QPushButton("下载")
        btn1.clicked.connect(lambda:self.to_download(int(id)))

        btn2 = QPushButton("浏览说明")
        btn2.clicked.connect(lambda:self.to_browse(int(id)))           

        self.table.setItem(row,0,QTableWidgetItem(id))
        self.table.setCellWidget(row,1,w)
        self.table.setCellWidget(row,2,le1)
        self.table.setCellWidget(row,3,le2)
        self.table.setCellWidget(row,4,le3)
        self.table.setCellWidget(row,5,le4)        
        self.table.setCellWidget(row,6,le5)     
        self.table.setItem(row,7,QTableWidgetItem(time_str))               
        self.table.setCellWidget(row,8,cb1)        
        self.table.setCellWidget(row,9,btn1)
        self.table.setCellWidget(row,10,btn2)

        self.id += 1
        self.lines.append([id,ck,le1,le2,le3,le4,le5,cb1,btn1])
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

    def to_download(self, id):
        QMessageBox.information(None, '启动选择的命令', str(id))
        
        for idx in range(self.table.rowCount()):
            if id == int(self.table.item(idx,0).text()):
                type = int(self.table.cellWidget(idx,8).currentIndex()) 

                if type == 0 : #git
                    repo = self.table.cellWidget(idx,3).text()
                    command  = "cd " + self.folder_path + "; git clone " + repo
                    wt = DownloadThread()
                    wt.setCommand(command)
                    self.threads[id] = wt
                    wt.start()
                    
                elif type == 1 : #iso
                    repo = self.table.cellWidget(idx,3).text()
                    command  = "cd " + self.folder_path + "; wget " + repo
                    wt = DownloadThread()
                    wt.setCommand(command)
                    self.threads[id] = wt
                    wt.start()                   

                elif type == 2 : #http/s
                    repo = self.table.cellWidget(idx,3).text()
                    webbrowser.open_new_tab(repo)                 



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
        item = self.table.item(row,col)
        txt = item.text()
        self.settext('第%s行，第%s列 , 数据改变为:%s'%(row,col,txt))

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

            jsonItem["id"]        = self.table.item(idx,0).text()
            jsonItem["name"]      = self.table.cellWidget(idx,2).text()
            jsonItem["repo"]      = self.table.cellWidget(idx,3).text()
            jsonItem["desc"]      = self.table.cellWidget(idx,4).text()
            jsonItem["usage"]     = self.table.cellWidget(idx,5).text()
            jsonItem["email"]     = self.table.cellWidget(idx,6).text()     
            jsonItem["datetime"]  = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))      
            jsonItem["type"]      = int(self.table.cellWidget(idx,8).currentIndex())           
            jsonArray1.append(jsonItem)   
            
        
        jsonArray2 = QJsonDocument.fromJson(content).object()
        jsonArray2["repo"] = jsonArray1
        
        outputjson = QJsonDocument(jsonArray2).toJson(QJsonDocument.Indented)
        f.write(outputjson)
        f.close()    

    def load_default(self):

        if not os.path.exists(self.folder_path):
            os.makedirs(self.folder_path)

        file_name = self.file_path + "/commands_resource.json"

        f = QFile(file_name)
        if not f.open(QIODevice.ReadOnly | QIODevice.Text):
            self.settext("\n open fail")
            return 

        data = f.readAll()

        error = QJsonParseError()
        jsonObject = QJsonDocument.fromJson(data, error).object()
        jsonArray = jsonObject["repo"].toArray()

        for json in jsonArray :
            item = json.toObject()
            name = item["name"].toString()
            repo = item["repo"].toString()
            desc = item["desc"].toString()
            usage = item["usage"].toString()
            email = item["email"].toString()
            type  = item["type"].toInt()
            if "datetime" in item:
                datetime_str = item["datetime"].toString()
            else:
                datetime_str = ""
            data = [name,repo,desc,usage,email,type, datetime_str]
            self.load_line(data)

        self.settext('加载现有数据!')

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
        jsonArray = jsonObject["repo"].toArray()

        for json in jsonArray :
            item = json.toObject()
            name = item["name"].toString()
            repo = item["repo"].toString()
            desc = item["desc"].toString()
            usage = item["usage"].toString()
            email = item["email"].toString()
            type = item["type"].toInt()
            if "datetime" in item:
                datetime_str = item["datetime"].toString()
            else:
                datetime_str = ""
            data = [name,repo,desc,usage,email,type, datetime_str]
            self.load_line(data)

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
    resources = ResourcesLayout()
    resources.show()
    sys.exit(app.exec_())
