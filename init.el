;; melpa
;; =====
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; ido
;; ===
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; windmove
;; ========
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(global-set-key (kbd "ESC <up>") 'windmove-up)
(global-set-key (kbd "ESC <down>") 'windmove-down)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <left>") 'windmove-left)

;; reassign undo
(global-set-key (kbd "M-'") 'undo)

;; packages
;; ========

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    smartparens

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    ;;cider

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    ;;smex

    ;; colorful parenthesis matching
    rainbow-delimiters

    multi-term

    company

    move-text
    ))

;; install packages when not already installed
(dolist (p my-packages)
  (when (not (package-installed-p p))
        (package-install p)))

;; smartparens
;; ===========
(add-hook 'clojure-mode-hook #'turn-on-smartparens-strict-mode)

;; (require 'smartparens-clojure)

;; keybindings
(require 'smartparens-config)

(define-key smartparens-mode-map (kbd "C-i") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-u") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-M-i") 'sp-backward-barf-sexp)

;; show-paren-mode
;; ===============
(add-hook 'clojure-mode-hook #'show-paren-mode)

;; rainbow-delimiters
;; ==================
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

;; company-mode
;; ============
(add-hook 'clojure-mode-hook #'global-company-mode)

;; linum-mode
;; ==========
(add-hook 'clojure-mode-hook #'linum-mode)

(setq linum-format "%3d ") ;; put a space separator between line number and buffer contents

;; turn off menu bar
(menu-bar-mode -1)

;; turn off alarm sound
(setq ring-bell-function 'ignore)

;; multi-term
;; ==========

(require 'multi-term)

(setq multi-term-program "/bin/bash")

;; move-text
;; =========

(require 'move-text)
(move-text-default-bindings)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (move-text which-key smartparens rainbow-delimiters paredit multi-term company cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
