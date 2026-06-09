#!/bin/sh
set -e

# 保底默认值：替换为你的新 AWS 公网 IP
VITE_GRAPHQL_URI="${VITE_GRAPHQL_URI:-http://54.226.166.100:8082/graphql}"
VITE_SERVER_URI="${VITE_SERVER_URI:-http://54.226.166.100:8082}"

# 替换打包生成的静态 JS 中的占位符
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_GRAPHQL_URI_PLACEHOLDER__|${VITE_GRAPHQL_URI}|g" {} +
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_SERVER_URI_PLACEHOLDER__|${VITE_SERVER_URI}|g" {} +

echo "Configured VITE_GRAPHQL_URI=${VITE_GRAPHQL_URI}"
echo "Configured VITE_SERVER_URI=${VITE_SERVER_URI}"

# 核心：必须使用 daemon off 让 nginx 在前台持续运行，否则容器启动后就会立刻退出
exec nginx -g 'daemon off;'