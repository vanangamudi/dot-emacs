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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq
 user-emacs-directory "/tmp/emacs/")

(use-package quelpa
  :ensure t)

(run-with-idle-timer
     3 nil
     (lambda ()
       (let ((inhibit-message t))
         (message "Emacs ready in %s with %d garbage collections."
                  (format "%.2f seconds"
                          (float-time
                           (time-subtract after-init-time before-init-time)))
                  gcs-done))))

(quelpa '(asoc.el :repo "troyp/asoc.el" :fetcher github))
(quelpa 's)
(quelpa 'doct)

(require 'org-capture)
(require 'asoc)
(require 'doct)
(require 'org-capture-ref)
(let ((templates
       (doct
	'(:group "Browser link"
		 :type entry
		 :file "~/Org/inbox.org"
		 :fetch-bibtex (lambda () (org-capture-ref-process-capture)) ; this must run first
		 :link-type (lambda () (org-capture-ref-get-bibtex-field :type))
		 :extra (lambda () (if (org-capture-ref-get-bibtex-field :journal)
				       (s-join "\n"
					       '("- [ ] download and attach pdf"
						 "- [ ] [[elisp:org-attach-open][read paper capturing interesting references]]"
						 "- [ ] [[elisp:(browse-url (url-encode-url (format \"https://www.semanticscholar.org/search?q=%s\" (org-entry-get nil \"TITLE\"))))][check citing articles]]"
						 "- [ ] [[elisp:(browse-url (url-encode-url (format \"https://www.connectedpapers.com/search?q=%s\" (org-entry-get nil \"TITLE\"))))][check related articles]]"
						 "- [ ] check if bibtex entry has missing fields"))
				     ""))
		 :org-entry (lambda () (org-capture-ref-get-org-entry))
		 :template
		 ("%{fetch-bibtex}* TODO %?%{space}%{org-entry}"
		  "%{extra}"
		  "- Keywords: #%{link-type}")
		 :children (("Interactive link"
			     :keys "b"
			     :clock-in t
			     :space " "
			     :clock-resume t
			     )
			    ("Silent link"
			     :keys "B"
			     :space ""
			     :immediate-finish t))))))
  (dolist (template templates)
    (asoc-put! org-capture-templates
	       (car template)
	       (cdr  template)
	       'replace)))
