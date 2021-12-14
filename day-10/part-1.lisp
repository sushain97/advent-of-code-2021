(defconstant inverse (pairlis '(#\( #\[ #\{ #\<) '(#\) #\] #\} #\>)))
(defconstant scores (pairlis '(#\) #\] #\} #\>) '(3 57 1197 25137)))

(let ((lines
        (with-open-file (stream (cadr sb-ext:*posix-argv*))
          (loop for line = (read-line stream nil)
            while line
            collect line)))
      (score 0))
  (dolist (line lines)
    (let ((seen ()))
      (loop for c across line do
        (case c
          ((#\( #\[ #\{ #\<) (push c seen))
          (otherwise (let ((expected (cdr (assoc (pop seen) inverse))))
            (when (not (eq expected c))
              (incf score (cdr (assoc c scores))))))))))
  (format t "~d~%" score))
