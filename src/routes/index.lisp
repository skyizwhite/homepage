(defpackage #:hp/routes/index
  (:use #:cl)
  (:local-nicknames (#:f #:flute))
  (:local-nicknames (#:jg #:jingle))
  (:local-nicknames (#:ui #:hp/ui/*))
  (:local-nicknames (#:utils #:hp/utils/*))
  (:export #:*index-app*))
(in-package #:hp/routes/index)

;;; View

(f:define-element page ()
  (f:h
    (ui:layout
     (section 
      :class "h-full flex justify-center items-center"
      (h1 
       :class "text-4xl text-amber-500"
       "Hello HTMX from Common Lisp!")))))

;;; Controller

(defun index (params)
  (declare (ignore params))
  (jg:with-html-response
    (f:element-string (page))))

(defparameter *index-app* (jg:make-app))

(utils:register-routes
 *index-app*
 `((:method :GET :path "/" :handler ,#'index)))
