FROM python:3.6.9


COPY requirements.txt /
COPY cmd.sh /

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

RUN pip install -r /requirements.txt

WORKDIR /app

COPY app /app
COPY cmd.sh /

EXPOSE 5000 9090 9191

USER uwsgi

# uwsgi --http 0.0.0.0:9090 --wsgi-file /app/app.py --callable app --stats 0.0.0.0:9191
CMD ["sh", "/cmd.sh"]