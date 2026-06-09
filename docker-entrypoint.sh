#!/bin/sh
set -e

# 如果没有外部注入，则使用默认值
VITE_GRAPHQL_URI="${VITE_GRAPHQL_URI:-http://43.208.224.38:8082/graphql}"
VITE_SERVER_URI="${VITE_SERVER_URI:-http://43.208.224.38:8082}"

# 动态将打包时生成的占位符替换为真实的运行时环境变量
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_GRAPHQL_URI_PLACEHOLDER__|${VITE_GRAPHQL_URI}|g" {} +
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_SERVER_URI_PLACEHOLDER__|${VITE_SERVER_URI}|g" {} +

echo "Configured VITE_GRAPHQL_URI=${VITE_GRAPHQL_URI}"
echo "Configured VITE_SERVER_URI=${VITE_SERVER_URI}"

exec nginx -g 'daemon off;'