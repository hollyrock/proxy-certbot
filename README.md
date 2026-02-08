# FIX ME

- ログインセッションが切れている際、frontend/src/stores/user.jsのrefreshTokenでログアウト処理が走るはずだが、以下のエラーが連続発生する。

``` bash
Bad Request: /account/auth/token/refresh/
[27/Aug/2025 14:45:54] "POST /account/auth/token/refresh/ HTTP/1.1" 400 56
```
