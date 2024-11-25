FROM python:3.8-slim
WORKDIR /app
ENV METAFLOW_USER ="docker_user"
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY simple_flow.py /app/simple_flow.py
#CMD ["python","/app/simple_flow.py","run"]