# railsの入ったコンテナ上で実行可能なものが並ぶMakefile
include help.mk
RAILS_PORT = 3000

install:
	bundle install

## rails s立ち上げ(pidファイル消しつつ)
server:
	rm -f tmp/pids/server.pid && bundle exec rails s -p $(RAILS_PORT) -b 0.0.0.0

.PHONY: db/*

db/create:
	bundle exec rails db:create

db/drop:
	bundle exec rails db:drop

db/migrate:
	bundle exec rails db:migrate
#	make -f app.mk rubocop/autocorrect

.PHONY: test

## minitest試す
test:
	echo 'testしたい'

.PHONY: rails/*

rails/console:
	bundle exec rails c

rails/console/sandbox:
	bundle exec rails c -s

rubocop:
	bundle exec rubocop --parallel

## rubocopによる自動修正を施行
rubocop/autocorrect:
	bundle exec annotate
	bundle exec annotate --routes
	bundle exec rubocop -a

.PHONY: credentials/*

## credentials.yml.encを復号して確認
credentials/show:
	bundle exec rails credentials:show

## credentials.yml.encを編集
credentials/edit:
	bundle exec rails credentials:edit

# make credentials/diff COMPARE=master とかやるとPRレビューの時便利そう
## credentials.yml.encのdiffを確認 COMPARE: 比較対象を指定するとそことのdiffを見れる。指定しないとHEADと比較
credentials/diff:
	git -c diff.rails_credentials.textconv='rails encrypted:show' -c diff.rails_credentials.cachetextconv=false diff $(COMPARE) -- config/credentials/$(CREDENTIALS_YML_ENC)
