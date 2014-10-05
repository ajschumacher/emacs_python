
;; For 'slide' functionality, run this elisp
;; It's a less-sexy version of Magnars'
;; see: https://www.youtube.com/watch?v=TMoPuv-xXMM

(defun buffer-file-name-body ()
  "Buffer file name stripped of directory and extension"
  (if (buffer-file-name)
      (file-name-nondirectory (file-name-sans-extension (buffer-file-name)))
    (cadr (reverse (split-string (dired-current-directory) "/")))))

(defun incs (s &optional num)
  (let* ((inc (or num 1))
         (new-number (number-to-string (+ inc (string-to-number s))))
         (zero-padded? (s-starts-with? "0" s)))
    (if zero-padded?
        (s-pad-left (length s) "0" new-number)
      new-number)))

(defun next-slide-number ()
  (incs (car (split-string (buffer-file-name-body) "-"))))

(defun next-slide-path ()
(car (file-expand-wildcards
 (concat "~/emacs_python/" (next-slide-number) "-*"))))

(defun go-to-next-slide ()
  (interactive)
  (find-file (next-slide-path)))

(global-set-key (kbd "C-x C-n") 'go-to-next-slide)


; My current email setup is just for sending email, and it prompts for
; a password at least once per session. So send a throw-away email
; before the demo starts, to hopefully save having to type it in live.

; Check the right zoom level for the graphical interface, to avoid
; fiddling around too much when switching from console emacs to
; graphical emacs launched from a shell in emacs.
