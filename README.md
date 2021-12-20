# emacs上で動作するシンプルなタイマー
## 言語
- emacs lisp
## 準備
- load-path の通っている場所に e-timer.el を置く
- ~/lib/emacs 以下にアラーム音声ファイル se_sad05.wav を置く
- emacs の設定ファイル(~/.emacs ~/.emacs.d ~/.emacs.d/init.el)に以下を追加する
```
(require 'e-timer)
```
