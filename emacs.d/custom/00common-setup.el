;; Set the starting position and width and height of Emacs Window
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; To get rid of Weird color escape sequences in Emacs.
;; Instruct Emacs to use emacs term-info not system term info
;; http://stackoverflow.com/questions/8918910/weird-character-zsh-in-emacs-terminal
(setq system-uses-terminfo nil)

;; Prefer utf-8 encoding
(prefer-coding-system 'utf-8)

;; Use windmove bindings
;; Navigate between windows using Alt-1, Alt-2, Shift-left, shift-up, shift-right
(windmove-default-keybindings) 

;; Display continuous lines
(setq-default truncate-lines nil)
;; Do not use tabs for indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(menu-bar-mode t)
;;(enable-theme 'solarized-dark)

;; trucate even even when screen is split into multiple windows
(setq-default truncate-partial-width-windows nil)

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)              

(set-cursor-color "red")

(setq default-frame-alist
      '((cursor-color . "red")))

;; Highlight incremental search
(setq search-highlight t)
(transient-mark-mode t)

(global-visual-line-mode 1)

(display-time)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;(scroll-bar-mode nil)

;; Enable copy and pasting from clipboard
(setq x-select-enable-clipboard t)

(global-set-key [f2] 'comment-region)
(global-set-key [f3] 'uncomment-region)
(global-set-key [f5] 'indent-region)
;;(global-set-key "\C-w" 'backward-kill-word)
;;(global-set-key "\C-l" 'end-of-line)

(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-xt" 'select-frame-by-name)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-xy" 'revert-buffer)

;; Disable backups
(setq backup-inhibited t)
;;disable auto save
(setq auto-save-default nil)

;;some custom functions, stolen for internet
(defun geosoft-forward-word ()
   ;; Move one word forward. Leave the pointer at start of word
   ;; instead of emacs default end of word. Treat _ as part of word
   (interactive)
   (forward-char 1)
   (backward-word 1)
   (forward-word 2)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
         (t (forward-char 1)))) 
(defun geosoft-backward-word ()
 ;; Move one word backward. Leave the pointer at start of word
 ;; Treat _ as part of word
  (interactive)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (geosoft-backward-word))
        (t (forward-char 1)))) 

(global-set-key [C-right] 'geosoft-forward-word)
(global-set-key [C-left] 'geosoft-backward-word)


(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)
(global-set-key (kbd "<f9> t") 'bh/switch-to-todo)
(global-set-key (kbd "<f9> b") 'switch-to-prev-buffer)
(global-set-key (kbd "<f9> n") 'switch-to-next-buffer)

(setq org-agenda-files (quote ("~/task")))

(setq path-to-ctags "/usr/local/bin/ctags") ;; <- you're ctags path here

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name dir-name))
  )

(global-set-key "\C-ct" 'visit-tags-table)
(global-set-key "\C-cd" 'create-tags)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)


(defun recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  ;; TODO: remove elpa-to-submit once everything's submitted.
  (byte-recompile-directory dotfiles-dir 0))


(define-key isearch-mode-map (kbd "C-o") ; occur easily inside isearch
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

(require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun colorize-compilation-buffer ()
  (interactive)
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


(require 'auto-complete-config)
;;(require 'ac-emmet)
(add-to-list 'ac-dictionary-directories  "/home/dailuong/.emacs.d/.cask/24.5.11/elpa/auto-complete-20150618.1949/dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)


;; web-mode
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.css$"  . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . web-mode))

(add-hook 'css-mode-hook 'rainbow-mode)

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\."))
)

(defvar ac-source-css-property-names
  '((candidates . (loop for property in ac-css-property-alist
                        collect (car property)))))
(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property-names ac-source-css-property ac-source-words-in-buffer))
        ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'js2-mode)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

(font-lock-add-keywords 'js2-mode
                        '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
                           1 font-lock-warning-face t)))

(require 'smartparens-config)
(smartparens-global-mode)
(setq skeleton-pair t)
;; (show-smartparens-global-mode t)

(sp-with-modes '(web-mode)
  (sp-local-pair "<" nil)
  (sp-local-pair "<%" "%>")
  (sp-local-pair "<?php" "?>"))

;; (add-hook 'web-mode-hook #'(lambda () (smartparens-mode -1)))



(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "s-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)
(global-set-key (kbd "C-c p <home>") 'projectile-dired)

(require 'highlight-indentation)

(require 'flyspell)
(setq flyspell-issue-message-flg nil)

(add-hook 'web-mode-hook
          (lambda () (flyspell-prog-mode)))

(add-hook 'js2-mode-hook
          (lambda () (flyspell-prog-mode)))

;; flyspell mode breaks auto-complete mode without this.
(ac-flyspell-workaround)


(require 'powerline)
(require 'cl)
(setq powerline-arrow-shape 'arrow14) ;; best for small fonts
(custom-set-faces
'(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(setq js2-highlight-level 3)
(setq js2-bounce-indent-p t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'flymake-jshint)
(add-hook 'js2-mode-hook (lambda ()
                           (setq-local jshint-configuration-path
                                       (expand-file-name ".jshintrc"
                                                         (locate-dominating-file
                                                          default-directory ".jshintrc")))
                           (flymake-jshint-load)))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))


(find-file "~/todo.org")

(defun bh/switch-to-todo ()
  (interactive)
  (switch-to-buffer "todo.org"))
