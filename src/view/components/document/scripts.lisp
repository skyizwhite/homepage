(defpackage #:hp/view/components/document/scripts
  (:use #:cl)
  (:local-nicknames (#:pi #:piccolo))
  (:import-from #:hp/view/asset
                #:defasset)
  (:export #:scripts))
(in-package #:hp/view/components/document/scripts)

(defasset *global-js*
  :js "global.js")

(defasset *htmx*
  :vendor "htmx@1.9.12.js")

(defasset *htmx-extentions*
  :htmx-ext ("alpine-morph@1.9.12.js"
             "head-support@1.9.12.js"))

(defasset *alpine*
  :vendor "alpine@3.13.8.js")

(defasset *alpine-extentions*
  :alpine-ext ("async-alpine@1.2.2.js"
               "persist@3.13.8.js"
               "morph@3.13.8.js"))

(pi:define-element extentions (paths defer)
  (pi:h
    (<>
      (mapcar (lambda (path)
                (script :src path :defer defer))
              paths))))

(pi:define-element scripts ()
  (pi:h
    (<>
      (script :src *htmx*)
      (extentions :paths *htmx-extentions*)
      (extentions :paths *alpine-extentions* :defer t)
      (script :src *global-js* :defer t)
      (script :src *alpine* :defer t))))
