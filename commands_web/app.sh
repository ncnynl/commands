# pip3 install gunicorn
gunicorn -w 1 -b 0.0.0.0:5050 app:app 