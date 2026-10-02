FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PING_URL=https://zhanghuaao-code-server.hf.space/
ENV PING_INTERVAL=3600

# 基础依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates git openssh-client \
    tini \
    && rm -rf /var/lib/apt/lists/*

# 安装 code-server（官方安装脚本会装到 /usr/bin/code-server）
RUN curl -fsSL https://code-server.dev/install.sh | sh

# 创建普通用户（不建议用 root 跑）
RUN useradd -m -s /bin/bash coder
USER coder
WORKDIR /home/coder

# code-server 配置目录
RUN mkdir -p /home/coder/.config/code-server /home/coder/project

# 拷贝启动脚本
COPY --chown=coder:coder start.sh /home/coder/start.sh
RUN chmod +x /home/coder/start.sh

# HF Spaces 通常会提供 PORT 环境变量
ENV PORT=7860

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/home/coder/start.sh"]
