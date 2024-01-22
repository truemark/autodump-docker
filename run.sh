#!/bin/bash
docker run -dit  \
    --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    --env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
    --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    --env AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
    --env SECRET_ARN=$SECRET_ARN \
    --mount type=bind,source="$(pwd)",target=/app \
  autodump
