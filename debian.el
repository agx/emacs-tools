(defun xcpu-deb-open-bts ()
  "Open the bug under the cursor in the debian bts"
  (interactive)
  (let* (
         (bounds (bounds-of-thing-at-point 'symbol))
         (text (if bounds
                   (buffer-substring (car bounds) (cdr bounds))
                 (read-string "Debian Bug Number: ")))
         (url (concat "http://bugs.debian.org/" text))
	 )
    (browse-url url)
    ))

(defun xcpu-deb-open-security-tracker ()
  "Open the symbol under the cursor in the debian security tracker"
  (interactive)
  (let* (
         (bounds (bounds-of-thing-at-point 'symbol))
         (text (if bounds
                   (buffer-substring (car bounds) (cdr bounds))
                 (read-string "CVE Number: ")))
         (url (concat "http://security-tracker.debian.org/" text))
	 )
    (browse-url url)
    ))

(defun xcpu-deb-open-tracker ()
  "Open the symbol under the cursor in the debian package tracker"
  (interactive)
  (let* (
         (bounds (bounds-of-thing-at-point 'symbol))
         (text (if bounds
                   (buffer-substring (car bounds) (cdr bounds))
                 (read-string "Package name: ")))
         (url (concat "http://tracker.debian.org/pkg/" text))
	 )
    (browse-url url)
    ))

