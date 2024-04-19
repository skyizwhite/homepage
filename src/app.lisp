(defpackage #:hp
  (:nicknames #:hp/app)
  (:use #:cl)
  (:local-nicknames (#:jg #:jingle))
  (:local-nicknames (#:fbr #:ningle-fbr))
  (:local-nicknames (#:mw #:hp/middlewares/*))
  (:local-nicknames (#:cfg #:hp/config))
  (:export #:start
           #:stop
           #:update))
(in-package #:hp)

(defparameter *app* (jg:make-app :address "localhost"
                                 :port 3000))

(defun start ()
  (uiop:run-program (if (cfg:dev-mode-p)
                        "make dev"
                        "make build"))
  (jg:start *app*))

(defun stop ()
  (when (cfg:dev-mode-p)
    (uiop:run-program "make stop"))
  (jg:stop *app*))

(defun setup ()
  (jg:clear-middlewares *app*)
  (jg:clear-routing-rules *app*)
  (fbr:assign-routes *app*
                     :system "hp"
                     :directory "src/routes")
  (jg:static-path *app* "/assets/" "src/assets/")
  (jg:install-middleware *app* mw:*public-files*)
  (jg:install-middleware *app* mw:*recovery*)
  (jg:install-middleware *app* mw:*normalize-path*)
  (jg:install-middleware *app* mw:*accesslog*))

(defun update ()
  (stop)
  (setup)
  (start))

(setup)
