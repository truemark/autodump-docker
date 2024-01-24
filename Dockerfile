#FROM  truemark/aws-cli:amazonlinux-2023 AS base
#COPY --from=truemark/git:amazonlinux-2023 /usr/local/ /usr/local/
#COPY --from=truemark/node:18-amazonlinux-2023 /usr/local /usr/local/
#RUN npm install -g typescript aws-cdk pnpm yarn esbuild && \
#    npm config set fund false --location=global
#
#FROM base AS pgdump

FROM --platform=linux/amd64 amazonlinux:2

RUN yum update -y && \
    yum install -y postgresql jq && \
    yum install -y aws-cli && \
    yum clean all && \
    mkdir -p /app

WORKDIR /app
COPY --chmod=0755 . /app
RUN chmod +x dumpdb.sh

ENTRYPOINT [ "/app/dumpdb.sh" ]
#CMD [ "date" ]
#ENTRYPOINT [ "tail", "-f", "/dev/null" ]
