FROM alpine:latest

# 安装依赖
RUN apk add --no-cache wget ca-certificates

# 下载并解压 sing-box
RUN wget -O sing-box.tar.gz https://github.com/SagerNet/sing-box/releases/download/v1.10.1/sing-box-1.10.1-linux-amd64.tar.gz && \
    tar -xzf sing-box.tar.gz && \
    mv sing-box-1.10.1-linux-amd64/sing-box /usr/local/bin/ && \
    rm -rf sing-box.tar.gz sing-box-1.10.1-linux-amd64

# 复制配置文件
COPY config.json /etc/sing-box/config.json

# 暴露端口：8080给健康检查，8081给代理服务
EXPOSE 8080
EXPOSE 8081

# 启动 sing-box
CMD ["sing-box", "run", "-c", "/etc/sing-box/config.json"]
