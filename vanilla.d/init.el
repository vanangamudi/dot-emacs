;; add MELPA package server
(require 'package)
(package-initialize)

(add-to-list 'package-archives  '("org"       . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives  '("melpa"     . "https://melpa.org/packages/"))
(add-to-list 'package-archives  '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

;;(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))

(unless package-archive-contents
  (package-refresh-contents))

;; if not yet installed, install package use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; load org package and our emacs-config.org file
(require 'org)
(org-babel-load-file "~/emacs/vanilla.d/config.org")

(run-with-idle-timer
     3 nil
     (lambda ()
       (let ((inhibit-message t))
         (message "Emacs ready in %s with %d garbage collections."
                  (format "%.2f seconds"
                          (float-time
                           (time-subtract after-init-time before-init-time)))
                  gcs-done))))
