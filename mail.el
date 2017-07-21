;; simplify mail handling
(defun _xcpu-current-line-empty-p ()
  (eq 0 (string-match-p "^$" (thing-at-point 'line))))

(defun _xcpu-current-line-banner-p ()
  (eq 0 (string-match-p "^On" (thing-at-point 'line))))

(defun _xcpu-current-line-quoted-empty-p ()
  (eq 0 (string-match-p "^\\(> *\\)$" (thing-at-point 'line))))

(defun _xcpu-current-line-quoted-p ()
  (eq 0 (string-match-p "^\\(> *\\)" (thing-at-point 'line))))

(defun xcpu-reply-mail ()
  "Skip over header and look for first paragraph to reply to when answering mail"
  (interactive)
  (goto-char 1)
  ;; Skip the email header
  (while (not (_xcpu-current-line-empty-p))
	 (forward-line 1)
	 (beginning-of-line)
	 )
  (forward-line 1)
  ;; Insert greeting if reply or new mail
  (when (or
	 (_xcpu-current-line-banner-p)
	 (_xcpu-current-line-empty-p))
    (forward-line -1)
    (insert "\nHi,")
    (forward-line 2)
    ;; search for first quoted line that is empty 
    (when (_xcpu-current-line-quoted-p)
      (while (not (_xcpu-current-line-quoted-empty-p))
	(forward-line 1)
	(beginning-of-line)
	))
    )
)
