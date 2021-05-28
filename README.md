## docker-init

Docker内でsupervisordを使うための検証メモ

### ロギング

```
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
```

を書いて親プロセスに標準出力と標準エラー出力をリダイレクトすれば良い


### 終了処理

```
docker kill --signal="TERM" コンテナ名
```

supervisord に `TERM` を送ると、子プロセスも即座に`TERM` を受取り、終了することを確認。

```
❯ docker logs -f jovial_northcutt
/usr/lib/python2.7/dist-packages/supervisor/options.py:461: UserWarning: Supervisord is running as root and it is searching for its configuration file in default locations (including its current working directory); you probably want to specify a "-c" argument specifying an absolute path to a configuration file for improved security.
  'Supervisord is running as root and it is searching '
2021-05-28 03:06:01,051 CRIT Supervisor is running as root.  Privileges were not dropped because no user is specified in the config file.  If you intend to run as root, you can set user=root in the config file to avoid this message.
2021-05-28 03:06:01,051 INFO Included extra file "/etc/supervisor/conf.d/supervisord.conf" during parsing
2021-05-28 03:06:01,060 INFO RPC interface 'supervisor' initialized
2021-05-28 03:06:01,060 CRIT Server 'unix_http_server' running without any HTTP authentication checking
2021-05-28 03:06:01,060 INFO supervisord started with pid 1
2021-05-28 03:06:02,063 INFO spawned: 'init-2' with pid 9
2021-05-28 03:06:02,066 INFO spawned: 'init-1' with pid 10
waiting...
waiting...
2021-05-28 03:06:03,075 INFO success: init-2 entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2021-05-28 03:06:03,076 INFO success: init-1 entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2021-05-28 03:07:01,478 WARN received SIGTERM indicating exit request
2021-05-28 03:07:01,479 INFO waiting for init-2, init-1 to die

terminated
プロセスID 10 を終了します2021-05-28 03:07:01,480 INFO stopped: init-1 (exit status 0)

terminated
プロセスID 9 を終了します2021-05-28 03:07:01,483 INFO stopped: init-2 (exit status 0)
```
