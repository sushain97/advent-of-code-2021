(defconstant inverse (pairlis '(#\( #\[ #\{ #\<) '(#\) #\] #\} #\>)))
(defconstant values (pairlis '(#\( #\[ #\{ #\<) '(1 2 3 4)))

(let ((lines
        (with-open-file (stream (cadr sb-ext:*posix-argv*))
          (loop for line = (read-line stream nil)
            while line
            collect line)))
      (scores ()))
  (dolist (line lines)
    (let ((seen ())
          (score 0)
          (illegal nil))
      (loop for c across line do
        (case c
          ((#\( #\[ #\{ #\<) (setf seen (cons c seen)))
          (otherwise (let ((expected (cdr (assoc (pop seen) inverse))))
            (when (not (eq expected c)) (setf illegal t))))))
      (when (not illegal)
        (dolist (c seen)
          (setf score (* score 5))
          (incf score (cdr (assoc c values))))
        (push score scores))))
  (setf scores (sort scores #'<))
  (format t "~d~%" (nth (floor (list-length scores) 2) scores)))
