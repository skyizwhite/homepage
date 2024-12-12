(defpackage #:hp/middlewares/recoverer
  (:use #:cl
        #:hsx)
  (:local-nicknames (#:tb #:trivial-backtrace))
  (:local-nicknames (#:env #:hp/env))
  (:export #:*recoverer*))
(in-package #:hp/middlewares/recoverer)

(defun error-page (condition)
  (hsx
   (html :lang "ja"
     (head
       (title "Internal Server Error"))
     (body
       (main
         (h1 "500 Internal Server Error")
         (when (env:dev-mode-p)
           (hsx
            (pre
              (code (tb:print-backtrace condition :output nil))))))))))

(defparameter *recoverer*
  (lambda (app)
    (lambda (env)
      (handler-case
          (funcall app env)
        (error (c)
          `(500 (:content-type "text/html; charset=utf-8")
                (,(hsx:render-to-string (error-page c)))))))))
