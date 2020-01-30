# docker-compose等を利用して実際にユーザに叩いてもらうインタフェースを担うMakefile
include help.mk

## 開発用docker環境をはじめから構築
init:
	make build
	make _wakeup
	make install
	make db/drop
	make db/create
	make db/migrate

## docker build
build:
	docker-compose build

## bundle installやdb:migrate等諸々のアップデートを行って最新状態にしつつdocker立ち上げ
up:
	make install
	make db/migrate
	docker-compose up

## シンプルにdocker立ち上げ。早いが分かってる人向け
up/docker:
	docker-compose up

## docker落とす
down:
	docker-compose down

# docker-compose run空打ちしてDB等を立ち上げるワークアラウンド
_wakeup:
	docker-compose run --rm ruby date

install: app/install frontend/install

## bundlerを用いてgem install
app/install:
	docker-compose run --rm ruby make -f app.mk install

frontend/install:
	docker-compose run --rm node make -C frontend install

.PHONY: db/*

## DB作成
db/create:
	docker-compose run --rm ruby make -f app.mk db/create

## DB削除
db/drop:
	docker-compose run --rm ruby make -f app.mk db/drop

## migration状況を最新にする
db/migrate:
	docker-compose run --rm ruby make -f app.mk db/migrate

.PHONY: test/*

## minitest試す
test: test/ruby test/node

test/ruby:
	docker-compose run --rm ruby make -f app.mk test

test/node:
	docker-compose run --rm node make -C frontend test


## webコンテナのshを起動
ssh/ruby:
	docker-compose run --rm ruby ash

## nodeコンテナのshを起動
ssh/node:
	docker-compose run --rm node bash

## webコンテナ上でrails consoleを起動
rails/console:
	docker-compose run --rm ruby make -f app.mk rails/console

## webコンテナ上でrails consoleをsandboxモードで起動
rails/console/sandbox:
	docker-compose run --rm ruby make -f app.mk rails/console/sandbox

## rubocop実行
rubocop:
	docker-compose run --rm ruby make -f app.mk rubocop

## rubocopによる自動修正を施行
rubocop/autocorrect:
	docker-compose run --rm ruby make -f app.mk rubocop/autocorrect

.PHONY: credentials/*

credentials/show:
	docker-compose run --rm ruby make -f app.mk credentials/show

## credentials.yml.encを編集
credentials/edit:
	docker-compose run --rm ruby make -f app.mk credentials/edit

# make credentials/diff COMPARE=master とかやるとPRレビューの時便利そう
## credentials.yml.encのdiffを確認 COMPARE: 比較対象を指定するとそことのdiffを見れる。指定しないとHEADと比較
credentials/diff:
	docker-compose run --rm ruby make -f app.mk credentials/diff
