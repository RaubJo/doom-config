(setq user-full-name "Joseph Raub"
      user-mail-address "josephraub98@gmail.com")

;;(setq fancy-splash-image "~/.doom.d/doom-emacs-bw-light.svg")
(setq doom-theme 'doom-nord-aurora)
(setq display-line-numbers-type `relative)

(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 12 :weight 'regular))

;;(add-hook 'org-mode-hook #'org-modern-mode)

(map! :leader
      :prefix-map ("o" . "open")
      (:desc "Magit" "g" #'magit
       :desc "Treemacs" "s" #'treemacs
       :desc "Calendar" "c" #'my-calendar)
      :prefix-map ("j" . "jump")
      (:desc "Counsel Outline" "c" #'counsel-outline)
)

(use-package org
  :ensure t
  :config
  (setq org-directory "~/org")
  (setq org-log-into-drawer t)
  (setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))
  (setq org-todo-keywords
      '((sequence "TODO(t)" "LESSON(l)" "TO-STUDY(s)" "TO-READ(r)" "IN-PROGRESS(i!)" "PROJ(P)" "IDEA(I)" "|" "DONE(d!)" "CANCELLED(c@)" )))
)

(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place resulting files in a different folder"
  (when (not pub-dir)
    (setq pub-dir "exported-org-files")
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))

(after! org-clock
  (setq org-clock-persist t)
  (org-clock-persistence-insinuate))

;; (use-package! org-gtd
;;   :after org
;;   :config
;;   (setq org-gtd-directory org-directory . "/gtd/")
;;   (setq org-agenda-property-list '("DELEGATED_TO"))
;;   (setq org-agenda-property-position 'next-line)
;;   (setq org-edna-use-inheritance t)
;;   (org-edna-load)
;;   :bind

;; )

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "/home/joseph/org/roam")))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (custom-set-variables
   '(org-agenda-files (list "~/org/agenda")))
  (setq org-agenda-start-day nil
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-span 1
        org-agenda-start-on-weekday nil)
  (setq org-agenda-custom-commands
        '(("c" "Cleaning View"
           ((alltodo "" ((org-agenda-overriding-header "")
                        (org-super-agenda-groups
                         '((:name "This week's cleaning")
                           (:discard (:not (:and (:category "cleaning" :tag "joseph"))))
                           (:auto-parent t)

                           ))))
            ))
          ("s" "Super View"
         ((agenda "" ((org-agenda-overriding-header "")
                    (org-super-agenda-groups
                     '((:name "Today"
                        :time-grid t
                        :date today
                        :order 0)
                       ))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '(
                          (:name "Overdue"
                                 :deadline past
                                 :order 1)
                          (:name "In Progress"
                                 :todo "IN_PROGRESS"
                                 :order 2)
                          (:name "Work"
                                 :category "childrens_church")
                          (:name "To Study"
                                 :todo "TO-STUDY"
                                 :category "ologies"
                                 :order 3)
                          (:name "To Read"
                                 :and (:todo ("TO-READ" "IN-PROGRESS") :category "books")
                                 :tag "books"
                                 :order 4)

                          ))))))
  ))
  :config
  (org-super-agenda-mode))



(defun my-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "WhiteSmoke")
    (cfw:ical-create-source "Google" "https://calendar.google.com/calendar/ical/josephraub98%40gmail.com/private-8a11016b26d257b08a7df99b3413a6a1/basic.ics" "Wheat")
    (cfw:ical-create-source "Family" "https://calendar.google.com/calendar/ical/9ibfbq446q1jahnid8npkjfn10%40group.calendar.google.com/private-cea683758b9acfd2b689309f9e48f31e/basic.ics" "Medium Slate Blue")
    (cfw:ical-create-source "Church" "https://calendar.google.com/calendar/ical/mrvsacc07hrfc4it0vnouvpffk%40group.calendar.google.com/private-5cf1d74203c478311461b8ffbb289ae9/basic.ics" "firebrick")
    )))
