#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
ROS1/ROS2 Commands Share Manager

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
    QFileDialog,QHeaderView,QSpacerItem,QSizePolicy
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

class ShareCommandLayout(QWidget):
    def __init__(self,parent=None):
        super(ShareCommandLayout,self).__init__(parent)
        self.setWindowTitle("管理共享命令集") 
        self.resize(640,480)


        self.id =1
        self.lines = []
        self.threads = {}
        self.editable = True
        self.des_sort = True
        self.file_path = os.path.expanduser('~') + '/commands'
        self.cwd = self.file_path


        self.table = QTableWidget(self)
        
        self.btn_add = QPushButton('增加')
        self.btn_del = QPushButton('删除')
        self.btn_save_commands = QPushButton('保存共享命令集')
        self.btn_load_commands = QPushButton('加载共享命令集')


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
        desc = "分享命令集联系作者"
        self.vtxt.setText(desc)
        self.vbox.addWidget(self.vtxt)

        self.txt = QLabel()
        self.txt.setMinimumHeight(50)

        self.table.setColumnCount(9)   ##设置列数
        self.headers = ['序号', '选择', '名称',  '仓库',  '描述', '作者', '邮箱', '时间','下载']
        self.table.setHorizontalHeaderLabels(self.headers)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(7, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(8, QHeaderView.ResizeToContents)

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
        data = ["","","","","", ""]
        self.load_line(data)

    def load_line(self, data):

        self.table.cellChanged.disconnect()
        row = self.table.rowCount()
        self.table.setRowCount(row + 1)

        name = data[0] 
        repo = data[1]
        desc = data[2]
        author = data[3]        
        email = data[4]
        if data[5] == "" :
            time_str = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))
        else:
            time_str = data[5]

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
        le4.setText(author)
        le4.setToolTip(author)

        le5 = QLineEdit()
        le5.setText(email)
        le5.setToolTip(email)

        btn1 = QPushButton("下载")
        btn1.clicked.connect(lambda:self.to_download(int(id)))

        self.table.setItem(row,0,QTableWidgetItem(id))
        self.table.setCellWidget(row,1,w)
        self.table.setCellWidget(row,2,le1)
        self.table.setCellWidget(row,3,le2)
        self.table.setCellWidget(row,4,le3)
        self.table.setCellWidget(row,5,le4)        
        self.table.setCellWidget(row,6,le5)        
        self.table.setItem(row,7,QTableWidgetItem(time_str))   
        self.table.setCellWidget(row,8,btn1)

        self.id += 1
        self.lines.append([id,ck,le1,le2,le3,le4,le5,time_str,btn1])
        self.settext('自动生成随机一行数据！,checkbox设置为居中显示')
        self.table.cellChanged.connect(self.cellchange) 

    def to_download(self, id):
        QMessageBox.information(None, '启动选择的命令', str(id))
        for idx in range(self.table.rowCount()):
            if id == int(self.table.item(idx,0).text()):
                repo = self.table.cellWidget(idx,3).text()
                command  = "cd ~/commands/; git clone " + repo
                wt = DownloadThread()
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
            jsonItem["author"]    = self.table.cellWidget(idx,5).text()
            jsonItem["email"]     = self.table.cellWidget(idx,6).text()     
            jsonItem["datetime"]  = str(datetime.datetime.strftime(datetime.datetime.now(),'%Y-%m-%d'))                     
            jsonArray1.append(jsonItem)   
            
        
        jsonArray2 = QJsonDocument.fromJson(content).object()
        jsonArray2["repo"] = jsonArray1
        
        outputjson = QJsonDocument(jsonArray2).toJson(QJsonDocument.Indented)
        f.write(outputjson)
        f.close()    

    def load_default(self):

        file_name = self.file_path + "/commands_repo.json"

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
            author = item["author"].toString()
            email = item["email"].toString()
            if "datetime" in item:
                datetime_str = item["datetime"].toString()
            else:
                datetime_str = ""

            data = [name,repo,desc,author,email, datetime_str]
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
            author = item["author"].toString()
            email = item["email"].toString()
            if "datetime" in item:
                datetime_str = item["datetime"].toString()
            else:
                datetime_str = ""

            data = [name,repo,desc,author,email, datetime_str]
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
    share = ShareCommandLayout()
    share.show()
    sys.exit(app.exec_())
