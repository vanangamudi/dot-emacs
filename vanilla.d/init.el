;; add MELPA package server
(require 'package)
(package-initialize)


(add-to-list 'package-archives  '("melpa"     . "https://melpa.org/packages/"))
(add-to-list 'package-archives  '("org"       . "http://orgmode.org/elpa/"))
;;(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))

(unless package-archive-contents
  (package-refresh-contents))



;; if not yet installed, install package use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; load org package and our emacs-config.org file
(require 'org)
(org-babel-load-file "~/emacs/vanilla.d/config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (htmlize org-plus-contrib which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
