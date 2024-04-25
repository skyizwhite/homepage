(defpackage #:hp/routes/index
  (:use #:cl
        #:piccolo)
  (:local-nicknames (#:view #:hp/view/*))
  (:export #:handle-get))
(in-package #:hp/routes/index)

(define-element page ()
  (div :class "h-full place-content-center"
    (h1
      :class "text-4xl text-center"
      "Hello, world!")))

(defun handle-get (params)
  (declare (ignore params))
  (view:render (page)))
