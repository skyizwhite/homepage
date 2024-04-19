(defpackage #:hp/components/document
  (:use #:cl)
  (:local-nicknames (#:pi #:piccolo))
  (:export #:document))
(in-package #:hp/components/document)

(pi:define-element document (title description)
  (pi:h
    (html :lang "ja"
      (head
        (meta :charset "UTF-8")
        (script :src "/assets/js/htmx.js")
        (script :src "/assets/js/htmx-ext/head-support.js")
        (script :src "/assets/js/alpine.js" :defer t)
        (link :rel "stylesheet" :type "text/css" :href "/assets/css/dist.css")
        (link :rel "preconnect" :href "https://fonts.googleapis.com")
        (link :rel "preconnect" :href "https://fonts.gstatic.com" :crossorigin t)
        (link 
          :rel "stylesheet"
          :href "https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&display=swap")
        (title (format nil "~@[~a - ~]skyizwhite.dev" title))
        (meta
          :name "description"
          :content (or description "pakuの個人サイト")))
      pi:children)))