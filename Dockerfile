FROM  truemark/aws-cli:amazonlinux-2023 AS base
COPY --from=truemark/git:amazonlinux-2023 /usr/local/ /usr/local/
COPY --from=truemark/node:18-amazonlinux-2023 /usr/local /usr/local/
RUN npm install -g typescript aws-cdk pnpm yarn esbuild && \
    npm config set fund false --location=global

FROM base AS pgdump
RUN yum update && \
    yum install -y postgresql15 && \
    yum clean all && \
    mkdir -p /app  && \
    chmod 777 /app

WORKDIR /app
COPY --chmod=0755 . /app
#RUN chmod +x dumpdb.sh

ENTRYPOINT [ "/app/dumpdb.sh" ]
#ENTRYPOINT [ "tail", "-f", "/dev/null" ]
