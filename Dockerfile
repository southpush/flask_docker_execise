FROM python:3.6.9

COPY app /app
COPY requirements.txt /
COPY cmd.sh /

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

RUN pip install -r /requirements.txt

WORKDIR /app

EXPOSE 5000 9090 9191

USER uwsgi

CMD ["sudo", "chmod", "+x", "./cmd.sh"]
# uwsgi --http 0.0.0.0:9090 --wsgi-file /app/app.py --callable app --stats 0.0.0.0:9191
CMD ["/cmd.sh"]