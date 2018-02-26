(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(custom-enabled-themes (quote (tango-dark)))
 '(elpy-rpc-backend "jedi")
 '(global-yascroll-bar-mode nil)
 '(inhibit-startup-screen t)
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#263238" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "DAMA" :family "Fira Code"))))
 '(whitespace-empty ((t (:foreground "gray" :background "SlateGray1"))))
 '(whitespace-hspace ((t (:foreground "white" :background "red"))))
 '(whitespace-indentation ((t (:foreground "firebrick" :background "beige"))))
 '(whitespace-line ((t (:foreground "black" :background "gray"))))
 '(whitespace-newline ((t (:foreground "orange" :background "blue"))))
 '(whitespace-space ((t (:bold t :foreground "gray75"))))
 '(whitespace-space-after-tab ((t (:foreground "black" :background "green"))))
 '(whitespace-space-before-tab ((t (:foreground "black" :background "DarkOrange"))))
 '(whitespace-tab ((t (:foreground "red" :background "yellow"))))
 '(whitespace-trailing ((t (:foreground "red" :background "yellow")))))

;; =========================== Automatic packages ============================

;; Packages: list the repositories containing them
(setq package-archives '())

 (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
 (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
 (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

;;(package-refresh-contents)

;; activate all the packages (in particular autoloads)
(require 'package)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;; ============================= Generic options =============================



;;; Fira code
;; This works when using emacs --daemon + emacsclient
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
;; This works when using emacs without server/client
(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
;; I haven't found one statement that makes both of the above situations work, so I use both for now

(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
            `(,(car regex-char-pair)
              (0 (prog1 ()
                   (compose-region (match-beginning 1)
                                   (match-end 1)
                                   ;; The first argument to concat is a string containing a literal tab
                                   ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
          '(("\\(www\\)"                   #Xe100)
            ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
            ("\\(\\*\\*\\*\\)"             #Xe102)
            ("\\(\\*\\*/\\)"               #Xe103)
            ("\\(\\*>\\)"                  #Xe104)
            ("[^*]\\(\\*/\\)"              #Xe105)
            ("\\(\\\\\\\\\\)"              #Xe106)
            ("\\(\\\\\\\\\\\\\\)"          #Xe107)
            ("\\({-\\)"                    #Xe108)
            ;;("\\(\\[\\]\\)"                #Xe109) ;; deactived for empty list
            ("\\(::\\)"                    #Xe10a)
            ("\\(:::\\)"                   #Xe10b)
            ("[^=]\\(:=\\)"                #Xe10c)
            ("\\(!!\\)"                    #Xe10d)
            ("\\(!=\\)"                    #Xe10e)
            ("\\(!==\\)"                   #Xe10f)
            ("\\(-}\\)"                    #Xe110)
            ("\\(--\\)"                    #Xe111)
            ("\\(---\\)"                   #Xe112)
            ("\\(-->\\)"                   #Xe113)
            ("[^-]\\(->\\)"                #Xe114)
            ("\\(->>\\)"                   #Xe115)
            ("\\(-<\\)"                    #Xe116)
            ("\\(-<<\\)"                   #Xe117)
            ("\\(-~\\)"                    #Xe118)
            ("\\(#{\\)"                    #Xe119)
            ("\\(#\\[\\)"                  #Xe11a)
            ("\\(##\\)"                    #Xe11b)
            ("\\(###\\)"                   #Xe11c)
            ("\\(####\\)"                  #Xe11d)
            ("\\(#(\\)"                    #Xe11e)
            ("\\(#\\?\\)"                  #Xe11f)
            ("\\(#_\\)"                    #Xe120)
            ("\\(#_(\\)"                   #Xe121)
            ("\\(\\.-\\)"                  #Xe122)
            ("\\(\\.=\\)"                  #Xe123)
            ("\\(\\.\\.\\)"                #Xe124)
            ("\\(\\.\\.<\\)"               #Xe125)
            ("\\(\\.\\.\\.\\)"             #Xe126)
            ("\\(\\?=\\)"                  #Xe127)
            ("\\(\\?\\?\\)"                #Xe128)
            ("\\(;;\\)"                    #Xe129)
            ("\\(/\\*\\)"                  #Xe12a)
            ("\\(/\\*\\*\\)"               #Xe12b)
            ("\\(/=\\)"                    #Xe12c)
            ("\\(/==\\)"                   #Xe12d)
            ("\\(/>\\)"                    #Xe12e)
            ("\\(//\\)"                    #Xe12f)
            ("\\(///\\)"                   #Xe130)
            ("\\(&&\\)"                    #Xe131)
            ("\\(||\\)"                    #Xe132)
            ("\\(||=\\)"                   #Xe133)
            ("[^|]\\(|=\\)"                #Xe134)
            ("\\(|>\\)"                    #Xe135)
            ("\\(\\^=\\)"                  #Xe136)
            ("\\(\\$>\\)"                  #Xe137)
            ("\\(\\+\\+\\)"                #Xe138)
            ("\\(\\+\\+\\+\\)"             #Xe139)
            ("\\(\\+>\\)"                  #Xe13a)
            ("\\(=:=\\)"                   #Xe13b)
            ("[^!/]\\(==\\)[^>]"           #Xe13c)
            ("\\(===\\)"                   #Xe13d)
            ("\\(==>\\)"                   #Xe13e)
            ("[^=]\\(=>\\)"                #Xe13f)
            ("\\(=>>\\)"                   #Xe140)
            ("\\(<=\\)"                    #Xe141)
            ("\\(=<<\\)"                   #Xe142)
            ("\\(=/=\\)"                   #Xe143)
            ("\\(>-\\)"                    #Xe144)
            ("\\(>=\\)"                    #Xe145)
            ("\\(>=>\\)"                   #Xe146)
            ("[^-=]\\(>>\\)"               #Xe147)
            ("\\(>>-\\)"                   #Xe148)
            ("\\(>>=\\)"                   #Xe149)
            ("\\(>>>\\)"                   #Xe14a)
            ("\\(<\\*\\)"                  #Xe14b)
            ("\\(<\\*>\\)"                 #Xe14c)
            ("\\(<|\\)"                    #Xe14d)
            ("\\(<|>\\)"                   #Xe14e)
            ("\\(<\\$\\)"                  #Xe14f)
            ("\\(<\\$>\\)"                 #Xe150)
            ("\\(<!--\\)"                  #Xe151)
            ("\\(<-\\)"                    #Xe152)
            ("\\(<--\\)"                   #Xe153)
            ("\\(<->\\)"                   #Xe154)
            ("\\(<\\+\\)"                  #Xe155)
            ("\\(<\\+>\\)"                 #Xe156)
            ("\\(<=\\)"                    #Xe157)
            ("\\(<==\\)"                   #Xe158)
            ("\\(<=>\\)"                   #Xe159)
            ("\\(<=<\\)"                   #Xe15a)
            ("\\(<>\\)"                    #Xe15b)
            ("[^-=]\\(<<\\)"               #Xe15c)
            ("\\(<<-\\)"                   #Xe15d)
            ("\\(<<=\\)"                   #Xe15e)
            ("\\(<<<\\)"                   #Xe15f)
            ("\\(<~\\)"                    #Xe160)
            ("\\(<~~\\)"                   #Xe161)
            ("\\(</\\)"                    #Xe162)
            ("\\(</>\\)"                   #Xe163)
            ("\\(~@\\)"                    #Xe164)
            ("\\(~-\\)"                    #Xe165)
            ("\\(~=\\)"                    #Xe166)
            ("\\(~>\\)"                    #Xe167)
            ("[^<]\\(~~\\)"                #Xe168)
            ("\\(~~>\\)"                   #Xe169)
            ("\\(%%\\)"                    #Xe16a)
           ;; ("\\(x\\)"                   #Xe16b) This ended up being hard to do properly so i'm leaving it out.
            ("[^:=]\\(:\\)[^:=]"           #Xe16c)
            ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
            ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

(add-hook 'prog-mode-hook
          #'add-fira-code-symbol-keywords)
;; Ajout au path de chargement
(setq-default path
  (cons (expand-file-name "~/.emacs.d/site-lisp") load-path))
(setq-default load-path
  (cons (expand-file-name "~/.emacs.d/elpa") load-path))

;; Supprimer le message d'ouverture
(setq inhibit-startup-message t inhibit-startup-echo-area-message t)


;; load material theme
(load-theme 'material t)

;; Afficher la ligne, la colonne, la date
(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(setq display-time-24hr-format t)

;; Afficher les lignes
(global-linum-mode t)

;; Display path file in frame title
(setq-default frame-title-format "%b (%f)")

;; Affiche la barre des menus mais pas la barre d'outil
(menu-bar-mode t)
(tool-bar-mode -1)

;; Transforme le bip sonore en bip lumineux
;(setq visible-bell t)

;; Afficher la barre de défilement à droite
(scroll-bar-mode t)
;;(global-yascroll-bar-mode 1)
(set-scroll-bar-mode 'right)

;; Surligne lors d'un rechercher/remplacer
(setq search-highlight t query-replace-highlight t)

;; Si je cherche 2 espaces, je veux vraiment 2 espaces, et pas au moins 1
(setq search-whitespace-regexp -1)

;; Mise en surbriallance de la zone selectionnée
(transient-mark-mode t)

;; Supprime le texte selectionné lors de la saisie d'un nouveau texte
(delete-selection-mode t)

;; Remplace toutes les questions yes-no en y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Déplacement du curseur, de la souris, de la molette...
(require 'mwheel)
(mouse-wheel-mode t)
(setq scroll-preserve-screen-position t)
(setq track-eol -1)
(setq scroll-step 1)
(setq next-screen-context-lines 1)
(setq scroll-margin 1
  scroll-conservatively 100000
  scroll-up-aggressively 0.01
  scroll-down-aggressively 0.01)

;; Un « copier-coller » à la souris, insérer le texte au niveau du curseur
;(setq mouse-yank-at-point -1)

;; Configuration pour les fichiers backup
;(setq make-backup-files nil)

(setq backup-directory-alist `(("." . "~/.saves")))

(setq auto-save-file-name-transforms
          `((".*" "~/.temps" t)))
;; Supprimer les backup en trop grand nombre
(setq delete-old-versions t)

;; Ne pas sauvegarder les abréviations
(setq save-abbrevs nil)

;; Case insensitive completing file name
(setq read-file-name-completion-ignore-case t)

(require 'helm-config)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks);;too lagy
(global-set-key (kbd "C-x C-f") #'helm-find-files)


(helm-mode 1)

(require 'helm-projectile)
(helm-projectile-on)
;; ============================ Raccourcis perso ============================


;; Auto-kill compilation process and recompile
(defun interrupt-and-recompile ()
  "Interrupt old compilation, if any, and recompile."
  (interactive)
  (ignore-errors
    (process-kill-without-query
     (get-buffer-process
      (get-buffer "*compilation*"))))
  (ignore-errors
    (kill-buffer "*compilation*"))
  (recompile))

;; auto-scroll in the compilation buffer
(setq compilation-scroll-output 'first-error)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [C-f1] 'show-file-name) ;

(global-set-key [f1] 'comment-dwim)
(global-set-key [f2] 'undo)
(global-set-key [f3] 'grep)
(global-set-key [f4] 'goto-line)
(global-set-key [f5] 'compile)
(global-set-key [f6] 'interrupt-and-recompile)
(global-set-key [f7] 'next-error)
(global-set-key [f8] 'caml-types-show-type)

;; Automatically resize widow when splitting
(global-set-key
 (kbd "C-x 2") (lambda () (interactive) (split-window-below) (balance-windows)))
(global-set-key
 (kbd "C-x 3") (lambda () (interactive) (split-window-right) (balance-windows)))
(global-set-key
 (kbd "C-x 0") (lambda () (interactive) (delete-window) (balance-windows)))

;; Autocomplete
(add-hook 'after-init-hook 'global-company-mode)
(autoload 'company-mode "company" nil t)
(require 'company)
(global-set-key (kbd "C-/") 'company-complete)
(setq company-dabbrev-downcase nil)


;; ====================== Divers pour la programmation ======================

;; Whitespace
(require 'whitespace)
(setq whitespace-style '(face trailing empty lines-tail tabs tab-mark))
(setq whitespace-space 'whitespace-hspace)
(setq whitespace-line-column 80)
;(add-hook 'prog-mode-hook 'whitespace-mode)
(global-whitespace-mode 1)


;; Suppression des espaces à la sauvegarde
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)
;; Terminer les fichiers par une nouvelle ligne
(setq require-final-newline t)

;; Remplacer les tabulations par des espaces
(setq-default indent-tabs-mode nil)

;; Montrer la correspondance des parenthèses
(require 'paren)
(show-paren-mode t)
(setq blink-matching-paren t)
(setq blink-matching-paren-on-screen t)
(setq show-paren-style 'expression)
(setq blink-matching-paren-dont-ignore-comments t)


;; =================================== BASH ==================================

(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)
(add-to-list 'company-backends
             '(company-shell company-shell-env company-fish-shell))

;;==================== OCAML ==========================


;; Load (?) Tuareg, merlin, caml-mode
(load "/home/erik-helmers/.opam/system/share/emacs/site-lisp/tuareg-site-file")
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
(add-to-list 'load-path "/home/erikh/.opam/system/share/emacs/site-lisp/")


(push "/home/erikh/.opam/system/share/\
     emacs/site-lisp" load-path) ; directory containing merlin.el

(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode)

(require 'ocp-indent)

;; Load merlin-mode
;(require 'merlin)
;; Start merlin on ocaml files
;(add-hook 'tuareg-mode-hook 'merlin-mode)
;; Use opam switch to lookup ocamlmerlin binary.
;(setq merlin-command 'opam)
;(add-hook 'caml-mode-hook 'merlin-mode)
;; Enable auto-complete
(setq merlin-use-auto-complete-mode 'easy)
(setq merlin-use-auto-complete-mode t)
;(add-hook 'caml-mode-hook 'merlin-mode)
;; Make company aware of merlin
(add-to-list 'company-backends 'merlin-company-backend)
;; Enable company on merlin managed buffers
(add-hook 'merlin-mode-hook 'company-mode)


;; ================================== C/C++ ==================================


(setq-default c-basic-offset 4)


;; ================================= PYTHON ==================================

;; Elpy activation
(elpy-enable)


;; flycheck activation
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; autopep8 activation
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; (add-hook 'elpy-mode-hook
;;     (lambda ()
;;     (local-unset-key (kbd "M-TAB"))
;;     (define-key elpy-mode-map (kbd "<C-tab>") 'elpy-company-backend)))

(add-hook 'python-mode-hook
          (lambda ()
            (define-key jedi-mode-map (kbd "<C-tab>") 'jedi:complete)))
(require 'epc)
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook
          (lambda ()
            (setq-local company-backends '(company-jedi))))

;; =========================== RACCOURCIS V2 ============================

(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-<left>") 'windmove-left)
    (define-key map (kbd "M-<right>") 'windmove-right)
    (define-key map (kbd "M-<up>") 'windmove-up)
    (define-key map (kbd "M-<down>") 'windmove-down)
    (define-key map (kbd "<C-next>") 'next-buffer)
    (define-key map (kbd "<C-prior>") 'previous-buffer)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode t)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
