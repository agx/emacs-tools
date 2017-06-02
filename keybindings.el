(defun xcpu-commit-current-file ()
  (interactive)
  (magit-stage-file (magit-file-relative-name))
  (magit-commit)
  )

(defun xcpu-thank-ack ()
  (interactive)
  (search-forward "> ACK")
  (insert "\n\nPushed. Thanks\n -- Guido\n")
  (backward-char 4))

(global-set-key (kbd "C-, c") 'comment-region)
(global-set-key (kbd "C-, u") 'uncomment-region)
(global-set-key (kbd "C-, w") 'delete-trailing-whitespace)
(global-set-key (kbd "C-, r") 'revert-buffer)
(global-set-key (kbd "C-, K") 'kill-rectangle)
(global-set-key (kbd "C-, e") 'eval-region)
(global-set-key (kbd "C-, a") 'align-regexp)
(global-set-key (kbd "C-, s") 'delete-trailing-whitespace)
(global-set-key (kbd "C-, c") 'xcpu-commit-current-file)
(global-set-key (kbd "C-, C") 'blog-insert-cve-markdown-link)
(global-set-key (kbd "C-, D") 'blog-insert-debian-bts-markdown-link)
(global-set-key (kbd "C-, g") 'vc-git-grep)

(global-set-key (kbd "C-, B") 'xcpu-deb-open-bts)
(global-set-key (kbd "C-, T") 'xcpu-deb-open-tracker)
(global-set-key (kbd "C-, S") 'xcpu-deb-open-security-tracker)
(global-set-key (kbd "C-, L") 'xcpu-deb-add-dla-needed)

(global-set-key (kbd "C-< C-<") 'xcpu-thank-ack)
