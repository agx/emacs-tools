(defvar deb_secure_testing_path "~/secure-tesing" "Path to your secure-testing-checkout")

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


(defun xcpu-deb-dla-insert-pkg-buffer (pkg)
  "Insert a package at the right position in the current buffer"
  (setq source_re "^[a-z0-9][a-z0-9+-.]+")
  (setq more_lines t)
  (setq found nil)

  (goto-char 1)
  (search-forward "--\n")

  (while more_lines
    (setq found_pkg (buffer-substring-no-properties (line-beginning-position) (point)))
    (if (string< found_pkg pkg)
	(setq more_lines (re-search-forward source_re (point-max) t))
      (progn
	(setq more_lines nil)
	(setq found t))
      ))
  (unless found
    (goto-char (point-max)))

  (search-backward "--\n")
  (insert (concat "--\n" pkg "\n"))
  (backward-char 1)
)

(defun xcpu-deb-dla-insert-pkg-file (filename)
  "Add a package to dla-needed.txt or dsa-needed.txt"
  (find-file (expand-file-name
	      filename
	      (concat
	       deb_secure_testing_path "/data")))
  (let ((pkg (read-string "Package: ")))
    (xcpu-deb-dla-insert-pkg-buffer pkg)
    )
)

(defun xcpu-deb-add-dla-needed ()
  "Add a package to dla-needed.txt"
  (interactive)
  (xcpu-deb-dla-insert-pkg-file "dla-needed.txt"))

(defun xcpu-deb-add-dsa-needed ()
  "Add a package to dsa-needed.txt"
  (interactive)
  (xcpu-deb-dla-insert-pkg-file "dsa-needed.txt"))
