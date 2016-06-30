(defun xcpu-deb-open-bug ()
  "Open the bug under the cursor in the debian bts"
  (interactive)
  (let* (
         (bounds (bounds-of-thing-at-point 'symbol))
         (text (if bounds
                   (buffer-substring (car bounds) (cdr bounds))
                 (read-string "Debian Number: ")))
         (url (concat "http://bugs.debian.org/" text))
	 )
    (browse-url url)
    ))

