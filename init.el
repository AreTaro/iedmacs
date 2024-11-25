;; IDEmacs by Emacs, un IDE pour l'IED.
;; VERSION : Apollon Funky 0.4.0
;; LICENCE : GPLV3

;; Supprimer le message de démarrage
(setq inhibit-startup-message t)

;; Supprimer le bar de menu
(menu-bar-mode -1)

;; Supprimer la bar d'icon
(tool-bar-mode -1)

;; Lancer le buffer de démarrage
(add-hook 'emacs-startup-hook 'iedmacs-startup-buffer)

(defun iedmacs-startup-buffer ()
  "Créez un buffer de démarrage pour IEDmacs avec un logo, une explication et des liens utiles."
  (let ((buffer (get-buffer-create "*IEDmacs*")))
    (with-current-buffer buffer
      (erase-buffer)

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

        ;; Insérez un titre ASCII avec des marges.
        (dolist (line ascii-title)
          (insert (make-string padding-title ?\s)) ; add padding spaces
          (insert line "\n"))

        ;; Insérer un sous-titre avec des marges
        (insert "\n" (make-string padding-subtitle ?\s) subtitle "\n\n"))

      ;; Paragraphe - Raccourcis utiles
      (insert "Les commandes de bases:\n\n")

      ;; List des raccourcis
      (insert (propertize "Ctrl-f" 'face 'bold) ": avancer le curseur\n")
      (insert (propertize "Ctrl-b" 'face 'bold) ": reculer le curseur\n")
      (insert (propertize "Ctrl-p" 'face 'bold) ": monter le curseur\n")
      (insert (propertize "Ctrl-n" 'face 'bold) ": descendre le curseur\n")
      (insert (propertize "Ctrl-g" 'face 'bold) ": sors moi de cette m****!\n")
      (insert (propertize "Ctrl-x Ctrl-f" 'face 'bold) ": pour ouvrir ou créer un fichier\n")
      (insert (propertize "Ctrl-x b" 'face 'bold) ": pour basculer d'une fichier ouvert (buffer) à l'autre.\n")
      (insert (propertize "Ctrl-x Ctrl-c" 'face 'bold) ": pour quitter\n\n")

      ;; paragraphe
      (insert "Pour celles et ceux qui sont familiers avec les commandes VIM, activer les avec la commande : ")
      (insert (propertize "\"Alt-x evil-mode\"" 'face 'bold) ". Ensuite pour passer d'un mode de saisi à l'autre utiliser la commande ")
      (insert (propertize "Ctrl-z" 'face 'bold) ".\n\n")

      ;; Liens
      (insert "Liens utiles:\n")
      (insert-text-button "Rédiger un devoir avec l'IEDmacs"
                        'action (lambda (_) (modele-devoir-ied-buffer))
                        'follow-link t)
      (insert "\n")
      (insert-text-button "Le Wiki Paris 8 IED"
                          'action (lambda (_) (wiki-ied-buffer))
                          'follow-link t)
                          ;;'action (lambda (_) (browse-url "https://wiki.paris8-ied.net/"))
                          ;;'follow-link t)
      (insert "\n")
      (insert-text-button "Carte de références des raccourcis en français"
                          'action (lambda (_) (browse-url "https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf"))
                          'follow-link t)
      (insert "\n")
      (insert-text-button "Tutorial Emacs en français (ENS)"
                          'action (lambda (_) (eww "https://tuteurs.ens.fr/unix/editeurs/emacs.html"))
                          'follow-link t)
      (insert "\n\n")

      ;; Mot de la fin
      (insert "Pour plus d'information sur la configuration de l'IEDmacs, vous pouvez vous référer au fichier: ")
      (insert-text-button "iedmacs.org\n"
                  'action (lambda (_) (find-file "~/.emacs.d/iedmacs.org"))
                  'follow-link t) 

      ;; Configurer le buffer en mode read-only
      (setq buffer-read-only t))
    ;; Afficher le buffer 
    (switch-to-buffer buffer)))

(defun modele-devoir-ied-buffer ()
"Creation d'un nouveau buffer avec un modèle pour les devoirs."
(let ((buffer (get-buffer-create "*Devoir*")))
  (with-current-buffer buffer
    (erase-buffer)
    (org-mode)  ;; Basculer en Orgmode
    ;; Insérer le contenu du modèle
    (insert "#+TITLE: [NOM DU CHAPITRE]\n")
    (insert "#+SUBTITLE: [NOM DU COURS]\n")
    (insert "#+OPTIONS: toc:t author:nil\n")
    (insert "#+LaTeX_HEADER: \\author{[PRENOM NOM] \\\\ N. Etudiant : [NUMERO]}\n")
    (insert "#+SETUPFILE: ~/.emacs.d/ied-latex-standard.org\n\n")
    (insert "\\newpage\n\n")
    (insert "* Exercice X\n")
    (insert "** Enoncé\n")
    (insert " :PROPERTIES:\n")
    (insert " :UNNUMBERED: t\n")
    (insert " :END:\n\n")
    (insert "** Réponse\n")
    (insert " :PROPERTIES:\n")
    (insert " :UNNUMBERED: t\n")
    (insert " :END:\n\n")
    (insert " Instructions:\n")
    (insert " 1. Remplacer les blocks indiqués par [] par vos informations\n")
    (insert " 2. Rédiger votre devoir en utilisant la synthaxe Orgmode\n")
    (insert " 3. Enregister votre devoir avec la commande " (propertize "Ctrl-x Ctrl-s" 'face 'bold)".\n")
    (insert " 4. Une fois terminé, utilisez la commande " (propertize "Ctrl-c Ctrl-e l p" 'face 'bold)" pour convertir\n")
    (insert "    votre fichier en LaTex puis pour créer le pdf correspondant.\n")
    ;; Basculer vers le nouveau modèle
    (switch-to-buffer buffer))))

(defun wiki-ied-buffer ()
"Creation d'un nouveau buffer qui affiche les liens vers les chapitres du Wiki"
(let ((buffer (get-buffer-create "*WikiIED8*")))
  (with-current-buffer buffer
    (erase-buffer)
    ;; Insérer le contenu du modèle
    (insert (propertize "Sommaire du Wiki\n\n" 'face 'bold))
    (insert "Cliquer sur le lien pour ouvrir la page dans eww (Emacs Web Browser)\n\n")

    ;; Paragraphe - Raccourcis utiles eww
    (insert "Les commandes utiles pour naviguer avec eww:\n\n")

    ;; List des raccourcis
    (insert (propertize "r" 'face 'bold) ": page eww précédente\n")
    (insert (propertize "l" 'face 'bold) ": page eww suivante \n")
    (insert (propertize "H" 'face 'bold) ": historique des pages eww\n\n")

    ;; Paragraphe - Raccourcis utiles emacs
    (insert "Petit rappel des commandes Emacs:\n\n")
    (insert (propertize "Ctrl-f" 'face 'bold) ": avancer le curseur\n")
    (insert (propertize "Ctrl-b" 'face 'bold) ": reculer le curseur\n")
    (insert (propertize "Ctrl-p" 'face 'bold) ": monter le curseur\n")
    (insert (propertize "Ctrl-n" 'face 'bold) ": descendre le curseur\n")
    (insert (propertize "Ctrl-g" 'face 'bold) ": sors moi de cette m****!\n")
    (insert (propertize "Ctrl-x b" 'face 'bold) ": pour basculer d'une fichier ouvert (buffer) à l'autre.\n\n")

    ;; Sommaire
    (insert (propertize "Général" 'face 'bold) "\n\n")
    (insert-text-button "Trucs cools"
                        'action (lambda (_) (eww "https://wiki.paris8-ied.net/fr/general/cool"))
                        'follow-link t)
    (insert "\n")
    (insert-text-button "Installation sur ce serveur Wiki"
                        'action (lambda (_) (eww "https://wiki.paris8-ied.net/fr/general/installation"))
                        'follow-link t)
    (insert "\n\n")
    (insert (propertize "Informations" 'face 'bold) "\n\n")
    (insert-text-button "Licence 1"
                        'action (lambda (_) (eww "https://wiki.paris8-ied.net/fr/L1"))
                        'follow-link t)
    (insert "\n")
    (insert-text-button "Licence 2"
                        'action (lambda (_) (eww "https://wiki.paris8-ied.net/fr/L2"))
                        'follow-link t)
    (insert "\n")
    (insert-text-button "Licence 3"
                        'action (lambda (_) (eww "https://wiki.paris8-ied.net/fr/L3"))
                        'follow-link t)


      ;; Configurer le buffer en mode read-only
      (setq buffer-read-only t))

    ;; Basculer vers le nouveau modèle
    (switch-to-buffer buffer)))

(display-time-mode 1)
(setq display-time-day-and-date t)
(setq column-number-mode t)
(setq column-line-mode t)

(setq-default mode-line-format
              (list
               '(:eval (propertize
                        (if (and (boundp 'evil-state)
                              (eq evil-state 'normal) )
                          " V " ;; VIM
                          (if (and (boundp 'evil-state)
                                  (eq evil-state 'insert) )
                          " I " ;; Insert
                          " E ") ) ;; Emacs
                      'face 'cursor) )
               '(:eval (if current-input-method
                          (propertize "FR" 'face 'italic)
                        (propertize "EN" 'face 'italic) ) )
               '(:eval
                   (propertize
                   (format-time-string
                   "  %-d/%-m %H:%M " (current-time) )
                   'face 'shadow) ) 
               ;;'default-directory
               '(:eval (propertize (format-mode-line
                                   mode-line-buffer-identification)
                                   'face 'success) )
               '(:eval (propertize " %l:%c " 'face 'shadow))
               ) )

;; Define a function to only active setting when buffer is active
(defun mode-line-window-selected-p ()
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
  :ensure t
  :config (which-key-mode))

;; PACKAGE NAME: modus-themes
;; PURPOSE: theme by Protesilaos Stavrou
(use-package modus-themes
  :defer t
  :ensure t)

;; Ligth theme
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
  :ensure t
  )

(use-package swiper
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

(use-package pdf-tools
  :ensure t
  :defer t
  :config
  (pdf-tools-install) )

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
;; (global-display-line-numbers-mode)

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
