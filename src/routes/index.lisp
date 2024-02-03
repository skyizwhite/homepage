(defpackage #:hp/routes/index
  (:use #:cl)
  (:local-nicknames (#:mk #:markup))
  (:local-nicknames (#:jg #:jingle))
  (:local-nicknames (#:ui #:hp/ui/*))
  (:local-nicknames (#:utils #:hp/utils/*))
  (:export #:*index-app*))
(in-package #:hp/routes/index)

(mk:enable-reader)

;;; View

(mk:deftag page ()
  <ui:layout>
    <section class="h-full flex justify-center items-center" >
      <h1 class="text-4xl text-amber-500" >
        Hello, World!
      </h1>
    </section>
  </ui:layout>)

;;; Controller

(defun index (params)
  (declare (ignore params))
  (jg:with-html-response
    (mk:write-html <page />)))

(defparameter *index-app* (jg:make-app))

(utils:register-routes
 *index-app*
 `((:method :GET :path "/" :handler ,#'index)))
