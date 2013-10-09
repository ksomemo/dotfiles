;; auto-installによってインストールされるEmacs Lispをロードパスに加える
;; デフォルトは ~/.emacs.d/auto-install/
(add-to-list 'load-path "~/.emacs.d/auto-install/")
(require 'auto-install)
;;(setq auto-install-use-wget nil)
;;(setq auto-install-use-wget t)

;; 起動時にEmacsWikiのページ名を補完候補に加える
(auto-install-update-emacswiki-package-name t)
;; install-elisp.el互換モードにする
(auto-install-compatibility-setup)
;; ediff関連のバッファを1つのフレームにまとめる
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; パッケージマネージャーELPA
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;;(when
;; (load
;; (expand-file-name "~/.emacs.d/elpa/package-install.el"))
;; (package-initialize))

;; バッファの切り替えを部分一致(正規表現込み)にする
(iswitchb-mode 1)
(setq iswitchb-regexp t) ; 正規表現込み

;; オートコンプリートモードON
;; (require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; 最近開いたファイルの一覧設定
(setq recentf-max-saved-items 100)
(setq recentf-exclude '("c:/WINDOWS/Temp/"))
(require 'recentf-ext)

;; anything
;; (auto-install-batch "anything")
;; (require 'anything)
;; (require 'anything-config)
(require 'anything-startup)

;; C-hをバックスペースにする
(global-set-key "\C-h" 'delete-backward-char)

;; 現在行のハイライト
(global-hl-line-mode 1)
 
;; 対応する括弧に色をつける
(show-paren-mode 1)
 
;; 行番号と横方向の桁数(半角ベース)をバーに表示する
(line-number-mode 1)
(column-number-mode 1)
 
;; ファイルを開いているバッファの左に行番号を5桁で表示する
(global-linum-mode t)
(setq linum-format "%5d")

;; ツールバーの非表示
(tool-bar-mode -1)
 
;; スタートアップページを表示しない
(setq inhibit-startup-message t)

;; 現在より1つ前にいた位置にカーソルを戻す
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)
 
;; 最後に修正した位置にカーソルを戻す
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)

;;; 関連付けられたソフトで開く
(defun my-unix-to-dos-filename (s)
  (encode-coding-string
   (concat (mapcar '(lambda (x) (if(= x ?/) ?\\ x)) (string-to-list s)))
   'sjis))

(defun my-x-open ()
  "open file."
  (interactive)
  (let ((file (dired-get-filename)))
    (message "Opening %s..." file)
    (cond ((not window-system)
           (find-file file))
          ((eq system-type 'windows-nt)
           (call-process "cmd.exe" nil 0 nil "/c" "start" ""
                         (my-unix-to-dos-filename file)))
          ((eq system-type 'darwin)
           (call-process "open" nil 0 nil file))
          (t
           (call-process "xdg-open" nil 0 nil file)))
    (recentf-add-file file)
    (message "Opening %s...done" file))
  )
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "z" 'my-x-open)))

;; undoとredo
(require 'redo+)
(setq undo-no-redo t)

;; undoする情報を保持する量
(setq undo-limit 60000)
(setq undo-strong-limit 90000)

;; (install-elisp "http://www.dr-qubit.org/undo-tree/undo-tree.el")
(require 'undo-tree)
(global-undo-tree-mode)


;; Phpモード
(require 'php-mode)
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))

(add-hook 'php-mode-hook
         (lambda ()
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
             (make-variable-buffer-local 'ac-sources)
             (add-to-list 'ac-sources 'ac-source-php-completion)
             (auto-complete-mode t))))

;; 矩形(くけい)選択の改善
;; (install-elisp http://taiyaki.org/elisp/sense-region/src/sense-region.el)
(require 'sense-region)
(sense-region-on)

;; 使い捨てファイル
;; (install-elisp-from-emacswiki "open-junk-file.el")
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y/%m/%d/%H-%M.")

;; ロードパスの追加
(add-to-list 'load-path "~/.emacs.d/init/")

;; cmigemoの設定
;;(load "init_cmigemo")

;; フォントの設定
;;(load "ime_japanese")

;; SKKモード
;;(setq skk-sticky-key ";")
;;(require 'skk-autoloads)
;;(global-set-key "\C-x\C-j" 'skk-mode)
;;(global-set-key "\C-xj" 'skk-auto-fill-mode)
;;(setq skk-large-jisyo "C:/emacs-23.3-20110402/site-lisp/skk/SKK-JISYO.L")
;;(setq skk-tut-file (expand-file-name "C:/emacs-23.3-20110402/site-lisp/skk/SKK.tut"))

;; stickyモード
;; (install-elisp-from-emacswiki "sticky.el")
(require 'sticky)
(use-sticky-key ?\; sticky-alist:ja) ; for japanese keyboards

;; yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;; goto-line
(global-set-key "\M-l" 'goto-line)
