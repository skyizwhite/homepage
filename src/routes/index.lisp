(defpackage #:hp/routes/index
  (:use #:cl
        #:hsx)
  (:export #:handle-get))
(in-package #:hp/routes/index)

(defcomp page ()
  (hsx
   (div :class "h-full grid place-items-center"
     (h1 :class "text-pink-600"
       "unko"))))

(defun handle-get (params)
  (declare (ignore params))
  (page))
