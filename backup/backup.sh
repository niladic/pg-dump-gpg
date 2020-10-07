set -e

NOW="$(date +"%Y-%m-%d-%s")"
FILENAME="$DATABASE_BACKUP_PATH/$DATABASE_NAME.$NOW.backup.gz.gpg"

if [ -z "${RECIPIENT_PUBLIC_KEY}" ]
then
      echo "No backup upload: RECIPIENT_PUBLIC_KEY is empty."
      exit 0
fi

echo "${RECIPIENT_PUBLIC_KEY}" | gpg --no-tty --import
echo "$S3CMD_S3CFG" > ~/.s3cfg


set -x

pg_dump -Fc $PG_DUMP_OPTS | gzip | gpg --batch --trust-model always --recipient ${RECIPIENT_PUBLIC_KEY_EMAIL} --encrypt | s3cmd -v put - "s3://${S3_BUCKET_NAME}/${FILENAME}"
