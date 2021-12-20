(defun e-timer (minute second)
  (interactive "nminutes: \nnseconds:")
  (setq e-timer-last-min minute
	e-timer-last-sec second
	e-timer-last-all-sec (+ (* minute 60) second)
	tmp-line mode-line-format
	e-timer (run-at-time 0 1 'e-timer-loop-main)))

(defun e-timer-loop-main ()
  (setq e-timer-last-sec (- e-timer-last-sec 1))
  (if (eq e-timer-last-sec -1)
      (progn (setq e-timer-last-sec 59
		   e-timer-last-min (- e-timer-last-min 1))))
  (setq e-timer-last-all-sec (- e-timer-last-all-sec 1)
	e-timer-min (number-to-string e-timer-last-min)
	e-timer-sec (number-to-string e-timer-last-sec))
  (if (eq (length e-timer-min) 1) (setq e-timer-min (concat "0" e-timer-min)))
  (if (eq (length e-timer-sec) 1) (setq e-timer-sec (concat "0" e-timer-sec)))
  (setq time (concat  "     " e-timer-min ":" e-timer-sec " (" (number-to-string e-timer-last-all-sec) " sec)")
	    mode-line-format tmp-line
	    under-line mode-line-format
	    mode-line-format (cons time under-line))
  (if (eq e-timer-last-all-sec 0)
      (progn (e-timer-stop)
	     (play-sound-file "~/lib/emacs/se_sad05.wav")
	     (setq e-timer-restore-time 5
		   restore-timer (run-at-time 0 1 'e-timer-loop-restore)))))

(defun e-timer-loop-restore ()
  (setq e-timer-restore-time (- e-timer-restore-time 1))
  (if (eq e-timer-restore-time 0)
      (progn (setq mode-line-format tmp-line)
	     (cancel-timer restore-timer))))

(defun e-timer-stop ()
  (interactive)
  (cancel-timer e-timer))


(provide 'e-timer)
