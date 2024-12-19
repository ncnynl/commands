# pip3 install gunicorn
# gunicorn -w 1 -b 0.0.0.0:5050 app:app 
gunicorn -w 4 --threads 2 -b 0.0.0.0:5051 app:app