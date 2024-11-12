;; Configuration de l'IEDmacs
;; Version: Apollon Funky 0.0.0
;; Supprimer le message de démarrage
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)

;;(setq initial-buffer-choice "~/.emacs.d/demarrageIed8")

;; Ensure your custom startup buffer is displayed on launch
(add-hook 'emacs-startup-hook 'my-iedmacs-startup-buffer)

(defun my-startup-buffer ()
  "Create a buffer with a 'Hello World' message and a link to the FSF."
  (let ((buffer (get-buffer-create "*hello-world*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert "Hello World\n\n")
      (insert-text-button "Visit FSF"
                          'action (lambda (_) (eww "https://www.fsf.org"))
                          'follow-link t))
    (switch-to-buffer buffer)))

(defun my-iedmacs-startup-buffer ()
  "Create a startup buffer for IEDmacs with a logo, explanation, and useful links."
  (let ((buffer (get-buffer-create "*IEDmacs*")))
    (with-current-buffer buffer
      (erase-buffer)

      ;; Set up the buffer with a title and content
      ;; Title
      ;; ASCII Title (centered)
      (let* ((ascii-title '(
                            "  __   _______  _______  .___  ___.      ___       ______     _______. "
                            " |  | |   ____||       \\ |   \\/   |     /   \\     /      |   /       | "
                            " |  | |  |__   |  .--.  ||  \\  /  |    /  ^  \\   |  ,----'  |   (----` "
                            " |  | |   __|  |  |  |  ||  |\\/|  |   /  /_\\  \\  |  |        \\   \\     "
                            " |  | |  |____ |  '--'  ||  |  |  |  /  _____  \\ |  `----.----)   |    "
                            " |__| |_______||_______/ |__|  |__| /__/     \\__\\ \\______|_______/     "
                            ))
             (subtitle "Un IDE pour l'IED")
             (width (window-body-width))
             (padding-title (max 0 (/ (- width (length (car ascii-title))) 2)))
             (padding-subtitle (max 0 (/ (- width (length subtitle)) 2))))

        ;; Insert ASCII title with padding
        (dolist (line ascii-title)
          (insert (make-string padding-title ?\s)) ; add padding spaces
          (insert line "\n"))

        ;; insert subtitle with padding
        (insert "\n" (make-string padding-subtitle ?\s) subtitle "\n\n"))

      ;; paragraph 1
      (insert "Pour utiliser les commandes VIM, ~Alt-x evil-mode~. Ensuite pour
passer d'un mode de saisi à l'autre utiliser la commande ~Ctrl-z~.\n\n")

      ;; Paragraph 2 - Shortcuts Introduction
      (insert "Les commandes de bases:\n\n")

      ;; List of Shortcuts
      (insert (propertize "Ctrl-f" 'face 'bold) ": avancer le curseur\n")
      (insert (propertize "Ctrl-b" 'face 'bold) ": reculer le curseur\n")
      (insert (propertize "Ctrl-p" 'face 'bold) ": monter le curseur\n")
      (insert (propertize "Ctrl-n" 'face 'bold) ": descendre le curseur\n")
      (insert (propertize "Ctrl-g" 'face 'bold) ": sors moi de cette m****!\n")
      (insert (propertize "Ctrl-x Ctrl-c" 'face 'bold) ": pour quitter\n")
      (insert (propertize "Ctrl-x Ctrl-f" 'face 'bold) ": pour ouvrir ou créer un fichier\n")
      (insert (propertize "Ctrl-x b" 'face 'bold) ": pour basculer d'une fichier ouvert (buffer) à l'autre.\n\n")

      ;; Useful Links
      (insert "Liens utiles:\n\n")
      (insert-text-button "Tutorial Emacs en français (ENS)"
                          'action (lambda (_) (eww "https://tuteurs.ens.fr/unix/editeurs/emacs.html"))
                          'follow-link t)
      (insert "\n")
      (insert-text-button "Carte de références des raccourcis en français"
                          'action (lambda (_) (browse-url "https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf"))
                          'follow-link t)
      (insert "\n")
      (insert-text-button "Moodel IED Paris 8"
                          'action (lambda (_) (browse-url "https://moodle.iedparis8.net/login/index.php"))
                          'follow-link t)
      (insert "\n\n")

      ;; Mot de la fin
      (insert "Pour plus d'information sur la configuration de l'IEDmacs, vous pouvez vous référer au fichier idemacs.org\n")

      ;; Set buffer as read-only and enable a simple mode
      (setq buffer-read-only t))
    ;; Display the buffer
    (switch-to-buffer buffer)))

;; restart from here

(setq display-time-day-and-date t) ;; Display the day and date
(display-time-mode 1) ;; Enable time display in mode line

(setq-default mode-line-format
              (list
               '(:eval
                 (propertize
                  (format-time-string
                   "  %-d/%-m %H:%M " (current-time))
                  'face 'shadow)) 
               'default-directory
               '(:eval (propertize (format-mode-line
                                    mode-line-buffer-identification)
                                   'face 'success))
               '(:eval (if current-input-method
                           (propertize "⌨ " 'face 'warning)
                         ""))
               ))

;; Define a function to only active setting when buffer is active
(defun mode-line-window-selected-p ()
  "Return non-nil if we're updating the mode line for the selected window.
                This function is meant to be called in `:eval' mode line
                constructs to allow altering the look of the mode line depending
                on whether the mode line belongs to the currently selected window
                or not."
  (let ((window (selected-window)))
    (or (eq window (old-selected-window))
        (and (minibuffer-window-active-p (minibuffer-window))
             (with-selected-window (minibuffer-window)
               (eq window (minibuffer-selected-window)))))))

;; Install MELPA package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; PACKAGE NAME: Use-package
;; PURPOSE: to easily install package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; PACKAGE NAME: try
;; PURPOSE: to try package without install them
(use-package try
  :defer t
  :ensure t)

;; PACKAGE NAME: whick-key
;; PURPOSE: to help to find next key, using a
;; menu at the bottom of the window
(use-package which-key
  :defer t
  :ensure t
  :config (which-key-mode))

;; PACKAGE NAME: modus-themes
;; PURPOSE: theme by Protesilaos Stavrou
(use-package modus-themes
  :defer t
  :ensure t)

;; ligth theme
(load-theme 'modus-operandi-deuteranopia :no-confirm)

(defun my-modus-themes-toggle ()
  "Toggle between `modus-operandi' and `modus-vivendi' themes.
This uses `enable-theme' instead of the standard method of
`load-theme'.  The technicalities are covered in the Modus themes
manual."
  (interactive)
  (pcase (modus-themes--current-theme)
    ('modus-operandi-deuteranopia (progn (enable-theme 'modus-vivendi-tinted)
                            (disable-theme 'modus-operandi-deuteranopia)))
    ('modus-vivendi-tinted (progn (enable-theme 'modus-operandi-deuteranopia)
                            (disable-theme 'modus-vivendi-tinted)))
    (_ (error "No Modus theme is loaded; evaluate `modus-themes-load-themes' first"))))

;; PACKAGE NAME: ace-window
;; PURPOSE: select a window more easily
(global-set-key (kbd "M-o") 'ace-window)

;; PACKAGE NAME: swiper
;; PURPOSE: facilitate search in a document
(use-package counsel
  :defer t
  :ensure t
  )

(use-package swiper
  :defer t
  :ensure t
  :config
  (progn
    (ivy-mode)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    ;; enable this if you want `swiper' to use it
    ;; (setq search-default-mode #'char-fold-to-regexp)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    ))

;; ====== EVIL MODE SETTINGS ========
;; PACKAGE: evil
;; PURPOSE: using Vim shortcuts in emacs 
(use-package evil
  :defer t
  :ensure t
  :init(setq evil-want-C-i-jump nil))

(setq evil-default-state 'normal)
(require 'evil)
(evil-mode 0)

;; Biding keys
;; to change evil to emacs C-z
(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>bs") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'switch-to-buffer)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>ts") 'modus-themes-select) 
(evil-define-key 'normal 'global (kbd "<leader>tt") 'my-modus-themes-toggle) 
(evil-define-key 'normal 'global (kbd "<leader>1") 'delete-other-windows) 
(evil-define-key 'normal 'global (kbd "<leader>ws") 'ace-select-window) 
(evil-define-key 'normal 'global (kbd "<leader>wd") 'ace-delete-window) 
(evil-define-key 'normal 'global (kbd "<leader>w1") 'ace-delete-other-windows) 
(evil-define-key 'normal 'global (kbd "<leader>bk") 'save-buffers-kill-terminal)
(evil-define-key 'normal 'global (kbd "<leader>w-") 'split-window-below) 
(evil-define-key 'normal 'global (kbd "<leader>w/") 'split-window-right) 
(evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>bp") 'previous-buffer)
(evil-define-key 'normal 'global (kbd "<leader>fc") 'counsel-find-file)
(evil-define-key 'normal 'global (kbd "<leader>bl") 'list-buffers)
(evil-define-key 'normal 'global (kbd "<leader>tl") 'load-themes)
(evil-define-key 'normal 'global (kbd "<leader>ss") 'swiper)
(evil-define-key 'normal 'global (kbd "<leader>l") 'org-insert-link)

;; ====== EVIL MODE SETTINGS END ========

;; ido to easy find the names of files, docs, when searching
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; better visualization of buffer-list
(defalias 'list-buffers 'ibuffer)
;;(defalias 'list-buffers 'ibuffer-other-window)

;; to set up the directory file, when opening new file
(setq default-directory "~/")

;; to display line number
(global-display-line-numbers-mode)
;;(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Org mode stuff
(use-package org-bullets
  :defer t
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

;; for converting org to pdf
;; defined org-plain-latex used in latex-standard.org
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;;==== AUTOMATICALLY ADD BY EMACS ======

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c7a926ad0e1ca4272c90fce2e1ffa7760494083356f6bb6d72481b879afce1f2" "0f76f9e0af168197f4798aba5c5ef18e07c926f4e7676b95f2a13771355ce850" default))
 '(package-selected-packages '(which-key try use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
