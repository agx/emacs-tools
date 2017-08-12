;; Major mode for Debian's CVE list
;; currently only does some syntax highlighting
;;
;; Can be enabled via
;;
;; (autoload 'debian-cvelist-mode "cvelist.el"
;;     "Major mode for debian CVE lists" t)
;; (setq auto-mode-alist
;;     (cons '("list" . debian-cvelist-mode) auto-mode-alist))

(defvar cve_classifiers '("unfixed" "no-dsa" "end-of-life" "not-affected" "removed" "undetermined") "valid cve classifiers")

(defun debian-cvelist-insert-not-for-us ()
  "Insert NOT-FOR-US keyword"
  (interactive)
  (insert "\tNOT-FOR-US: "))

(defun debian-cvelist-insert-note ()
  "Insert NOTE comment"
  (interactive)
  (insert "\tNOTE: "))

(defun _debian-cvelist-next-classification (cls)
  (let* ((c (member cls cve_classifiers)))
    (if c
	(if (> (length c) 1)
	    (car (cdr c))
	  (car cve_classifiers))
      (car cve_classifiers))))

;; cycle through available classifiations from above
(defun _debian-cvelist-cycle-classification (line)
  "Cycle the classification of an issue"
  (setq classifiers_ (copy-sequence cve_classifiers))
  (while classifiers_
    (let* ((clf (car classifiers_))
	   (next (_debian-cvelist-next-classification clf))
	   )
      (when (string-match (format "<%s>" clf) line)
	(setq ret (replace-match (format "<%s>" next) t t line)))
      )
    (setq classifiers_ (cdr classifiers_)))
  ret
  )

;; cycle through classifiations on current line
(defun debian-cvelist-cycle-classification-in-line ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((line (_debian-cvelist-cycle-classification (thing-at-point 'line)))
	  (beg (point)))
      (end-of-line)
      (delete-region beg (point))
      (insert line)
      (delete-char -1)
      )
    )
  )

(defvar debian-cvelist-mode-map
   (let ((map (make-sparse-keymap)))
     (define-key map (kbd "C-c C-f") 'debian-cvelist-insert-not-for-us)
     (define-key map (kbd "C-c C-n") 'debian-cvelist-insert-note)
     (define-key map (kbd "C-c C-c") 'debian-cvelist-cycle-classification-in-line)
     map)
   "Keymap for `debian-cvelist-mode'.")

(defvar debian-cvelist-font-lock-keywords
  '(("^CVE-[0-9]\\{4\\}-[0-9X]\\{4,5\\}" . font-lock-function-name-face)
    ("^\tNOTE:" . font-lock-comment-delimiter-face)
    ("^\tTODO:" . font-lock-warning-face)
    ("^\t\\(RESERVED\\|NOT-FOR-US\\|REJECTED\\)" . font-lock-keyword-face)
    ("^CVE-[0-9]\\{4\\}-[0-9X]\\{4,5\\}" "\\[\\(.*\\)\\]$" nil nil (1 font-lock-variable-name-face))
    ("\\<unfixed\\|undetermined\\>" . font-lock-warning-face)
    ("\\<end-of-life\\|not-affected\\|no-dsa\\>" . font-lock-constant-face))
  "Keyword highlighting for `debian-cvelist-mode'")

(defun debian-cvelist-is-cve ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*CVE-")))

(defun debian-cvelist-indent-line ()
  "Indent current line as debian CVE list"
  (beginning-of-line)
  (if (debian-cvelist-is-cve)
      (indent-line-to 0)
    (indent-line-to 8)))

(define-derived-mode debian-cvelist-mode fundamental-mode "debian-cvelist"
  "A major mode for editing data/CVE/list in the Debian secure-testing repo."
  (setq-local font-lock-defaults '(debian-cvelist-font-lock-keywords nil))
  (setq indent-line-function 'debian-cvelist-indent-line))

(provide 'debian-cvelist)
