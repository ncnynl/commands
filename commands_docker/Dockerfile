FROM python:3.7
 
COPY src/ /opt/src
WORKDIR /opt/src
 
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
