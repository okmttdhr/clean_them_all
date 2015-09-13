## デプロイ

cap deploy:cold

## Railsコンテナ再起動

cap unicorn:start
cap unicorn:stop
cap unicorn:restart

## メンテナンスモード

cap deploy:web:disable
cap deploy:web:enable

## CDPタグ
