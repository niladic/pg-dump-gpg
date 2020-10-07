FROM postgres:11

ENV RECIPIENT_PUBLIC_KEY ""
ENV RECIPIENT_PUBLIC_KEY_EMAIL ""
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV S3_BUCKET_NAME ""
ENV DATABASE_BACKUP_PATH ""
ENV DATABASE_NAME ""
ENV PG_DUMP_OPTS ""

RUN apt-get update && apt-get install -y gnupg python-pip
RUN pip install --upgrade s3cmd==2.0.2

ADD backup/backup.sh /
RUN chmod +x /backup.sh

CMD ["sh", "/backup.sh"]
