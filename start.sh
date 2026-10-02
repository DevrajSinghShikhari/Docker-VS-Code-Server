#!/usr/bin/env bash
set -e

# ===== Keepalive: 后台定时 curl（可用环境变量控制）=====
PING_URL="${PING_URL:-}"
PING_INTERVAL="${PING_INTERVAL:-300}"

if [ -n "$PING_URL" ]; then
  (
    while true; do
      echo "[keepalive] $(date -Iseconds) curl $PING_URL"
      curl -fsS -L --max-time 20 "$PING_URL" >/dev/null 2>&1 || true
      sleep "$PING_INTERVAL"
    done
  ) &
fi
# =========================================================

mkdir -p /home/coder/.config/code-server

# 生成配置文件
cat > /home/coder/.config/code-server/config.yaml <<EOF
bind-addr: 0.0.0.0:${PORT}
auth: password
password: ${PASSWORD:-changeme}
cert: false
EOF

echo "Starting code-server on 0.0.0.0:${PORT}"
exec code-server /home/coder/project
