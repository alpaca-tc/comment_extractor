;;;;[-1-] COMMENT-EXAMPLE function.
;;;[-2-] This function is useless except to demonstrate comments.
;;;[-3-] (Actually, this example is much too cluttered with them.)

(defun comment-example (x y)      ;[-5-]X is anything; Y is an a-list.
  (cond ((listp x) x)             ;[-6-]If X is a list, use that.
        ;;[-7-] X is now not a list.  There are two other cases.
        ((symbolp x)
        ;;[-9-] Look up a symbol in the a-list.
        (cdr (assoc x y)))       ;[-10-]Remember, (cdr nil) is nil.
        ;;[-11-] Do this when all else fails:
        (t (cons x                ;[-12-]Add x to a default list.
                 '((lisp t)       ;[-13-]LISP is okay.
                   (fortran nil)  ;[-14-]FORTRAN is not.
                   (pl/i -500)    ;[-15-]Note that you can put comments in
                   (ada .001)     ;[-16-] "data" as well as in "programs".
                   ;;[-17-] COBOL??
                   (teco -1.0e9))))))
