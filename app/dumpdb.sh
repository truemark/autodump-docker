#!/bin/bash
set -x


export PATH=/usr/local/bin:/usr/bin

usage() {
    echo ""
    echo "Usage: dumpdb.sh"
    echo "SECRET_ARN must be set in the environment variables."
}

export SECRET_ARN=${SECRET_ARN:?'environment variable is required'}
export FILE_NAME=$(date "+%Y-%m-%d-%H-%M").dmp

# Access the secret, retrieve the secret string
returnval=$(aws secretsmanager get-secret-value --secret-id ${SECRET_ARN} --output text --query 'SecretString')

# yank out the items we need to connect as the autodump user
BUCKET_NAME=$(echo ${returnval} | jq -r '.bucketname')
ENGINE=$(echo ${returnval} | jq -r '.engine')

if [[ $ENGINE == "postgres" ]]
then
        export PGPASSWORD=$(echo ${returnval} | jq -r '.password')
        export PGUSER=$(echo ${returnval} | jq -r '.username')
        export PGHOST=$(echo ${returnval} | jq -r '.endpoint')
        export PGDATABASE=$(echo ${returnval} | jq -r '.databasename')

        echo -e "starting dump $(date -u)\n"
        pg_dump -Fc  -O -Z 9 -f $FILE_NAME -d $PGDATABASE -U $PGUSER -h $PGHOST


        if [[ $? -eq 0 ]]
                then
                echo "successfully completed pg_dump $(date -u)"
        else
                echo "there was a problem with pg_dump, result is $?"
                exit 1
        fi

else
        echo "engine $ENGINE not supported"
        exit 1
fi

echo "starting copy to s3 $(date -u)"

aws s3 cp $FILE_NAME "s3://${BUCKET_NAME}/${FILE_NAME}"
if [[ $? -eq 0 ]]
then
  echo "successfully completed copy to s3 $(date -u)"
else
  echo "there was a problem with copy, result is $?"
fi
