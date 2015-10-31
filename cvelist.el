;; Major mode for Debian's CVE list
;; currently only does some syntax highlighting
;;
;; Can be enabled via
;;
;; (autoload 'debian-cvelist-mode "cvelist.el"
;;     "Major mode for debian CVE lists" t)
;; (setq auto-mode-alist
;;     (cons '("list" . debian-cvelist-mode) auto-mode-alist))

;; indentation
(defun debian-cvelist-is-cve ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*CVE-")))

(defun debian-cvelist-indent-line ()
  "Indent current line as debian CVE list"
  (beginning-of-line)
  (if (debian-cvelist-is-cve)
      (indent-line-to 0)
    (indent-line-to 8))
  )

;; syntax highlighting
(setq debian-cvelist-highlights
      '(("^CVE-[0-9]\\{4\\}-[0-9X]\\{4\\}" . font-lock-function-name-face)
	("^\tNOTE:" . font-lock-comment-delimiter-face)
	("^\tTODO:" . font-lock-warning-face)
	("^\t\\(RESERVED\\|NOT-FOR-US\\|REJECTED\\)" . font-lock-keyword-face)
	("^CVE-[0-9]\\{4\\}-[0-9X]\\{4\\}" "\\[\\(.*\\)\\]$" nil nil (1 font-lock-variable-name-face))
	("\\<unfixed\\|undetermined\\>" . font-lock-warning-face)
	("\\<end-of-life\\|not-affected\\|no-dsa\\>" . font-lock-constant-face)	
	))

(define-derived-mode debian-cvelist-mode fundamental-mode
  (setq font-lock-defaults '(debian-cvelist-highlights))
  (setq mode-name "debian cvelist")
  (setq indent-line-function 'debian-cvelist-indent-line)
  )
