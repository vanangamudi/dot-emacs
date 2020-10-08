;; add MELPA package server
(require 'package)
(package-initialize)


(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/"))

(unless package-archive-contents
  (package-refresh-contents))



;; if not yet installed, install package use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; load org package and our emacs-config.org file
(require 'org)
(org-babel-load-file "~/emacs/emacs.d/config.org")
