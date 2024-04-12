(defpackage #:hp/components/global/layout
  (:use #:cl)
  (:local-nicknames (#:pi #:piccolo))
  (:export #:layout))
(in-package #:hp/components/global/layout)

(pi:define-element layout ()
  (pi:h
    (body :hx-ext "head-support"
      (main pi:children))))
