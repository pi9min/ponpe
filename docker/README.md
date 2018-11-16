# Overview

- `precompile.Dockerfile`: rake assets:precompile の検証用Dockerイメージ
- `test-compose.yml`: 各種テストを行うためのdocker-composeファイル

# Usage

```sh
# プロジェクトルートにて以下を実行
% docker-compose -f ./docker/test-compose.yml run assets_precompile
# servicesとして登録されているすべてのテストを実行する場合
% docker-compose -f ./docker/test-compose.yml up
# ただし、upを使う場合はexit codeが0となるので、CIなどでは使えない.
```