;Markdown mode doesn't provide anything
;(require 'markdown)

(defun blog-insert-cve-markdown-link ()
  "Read CVE/DSA number and create link to security tracker"
  (interactive)
  (let* (
         (bounds (or (and (markdown-use-region-p)
                          (cons (region-beginning) (region-end)))
                     (markdown-bounds-of-thing-at-point 'symbol)))
         (text (if bounds
                   (buffer-substring (car bounds) (cdr bounds))
                 (read-string "CVE/DSA Number: ")))
         (url (concat "http://security-tracker.debian.org/tracker/" text))
	 )
    (when bounds (delete-region (car bounds) (cdr bounds)))
    (markdown-insert-reference-link text "" url "")))

(defun blog-insert-debian-bts-markdown-link ()
  "Read CVE/DSA number and create link to security tracker"
  (interactive)
  (let* (
         (bounds (or (and (markdown-use-region-p)
                          (cons (region-beginning) (region-end)))
                     (markdown-bounds-of-thing-at-point 'symbol)))
         (text (if bounds
                   (buffer-substring (car bounds) (cdr bounds))
                 (read-string "Bugnumber Number: ")))
	 (bugnum (if (string-prefix-p "#" text)
		     (substring text 1)
		 text))
         (url (concat "http://bugs.debian.org/" bugnum))
	 )
    (when bounds (delete-region (car bounds) (cdr bounds)))
    (markdown-insert-reference-link text "" url "")))
