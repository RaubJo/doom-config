;;(package! org-modern)
(package! org-roam
  :recipe (:host github :repo "org-roam/org-roam"
           :files (:defaults "extensions/*")))

(when (package! org-roam-ui)
  (package! org-roam))

(package! ob-ledger :recipe (:local-repo "lisp/ob-ledger"))
(package! org-super-agenda)
(package! olivetti)
(package! mw-thesaurus)
(package! org-wc)
(package! ox-reveal)
(package! htmlize)
