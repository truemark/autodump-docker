FROM truemark/aws-cli:amazonlinux-2023 AS base
COPY --from=truemark/git:amazonlinux-2023 /usr/local/ /usr/local/
#COPY --from=truemark/git-crypt:amazonlinux-2023 /usr/local/ /usr/local/
COPY --from=truemark/node:18-amazonlinux-2023 /usr/local /usr/local/
RUN npm install -g typescript aws-cdk pnpm yarn esbuild && \
    npm config set fund false --location=global

FROM base AS pgdump
RUN yum update && \
    yum install -y postgresql15 && \
    yum clean all

#ENTRYPOINT ["tail"]
ENTRYPOINT [ "app/dumpdb.sh" ]
#CMD ["-f","/dev/null"]
