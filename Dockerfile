# イメージ
FROM node:21-alpine

# パッケージ最新化とインストール
RUN apk update && apk add git curl

# docker-composeからの引数を受け取る
ARG PROJECT_NAME

# コンテナにフォルダ作成
RUN mkdir -p /workspace/docker

# workspaceディレクトリに移動
WORKDIR /workspace

# next.jsプロジェクト生成
RUN npx create-next-app@latest ${PROJECT_NAME} \
      --typescript --eslint --app --src-dir \
      --import-alias --use-yarn --no-tailwind

# next.jsプロジェクトに移動
WORKDIR /workspace/${PROJECT_NAME}

# next.jsプロジェクト内にdocker関連ファイルをコピー
RUN mkdir -p /workspace/${PROJECT_NAME}/docker
COPY ./ /workspace/${PROJECT_NAME}/docker

# git初期化
RUN git init