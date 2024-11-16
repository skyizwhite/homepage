(defpackage #:hp/renderer
  (:use #:cl
        #:hsx
        #:trivia)
  (:import-from #:str)
  (:local-nicknames (#:jg #:jingle))
  (:import-from #:hsx/element
                #:element)
  (:local-nicknames (#:env #:hp/env)))
(in-package #:hp/renderer)

(defun bust-cache (url)
  (format nil "~a?~a" url #.(get-universal-time)))

(defcomp page-header ()
  (let ((links '(("Work" "/work")
                 ("Blog" "/blog"))))
    (hsx
     (header :class "flex justify-between container mx-auto py-4"
       (h1 :class "text-lg font-bold"
         (a :href "/" "skyizwhite"))
       (ul :class "flex"
         (loop
           :for (content href) :in links :collect
              (li
                (a
                  :href href
                  :class (concatenate 'string
                                      "pl-4"
                                      (and (str:starts-with? href (jg:request-uri jg:*request*))
                                           " text-pink-600"))
                  content))))))))

(defcomp document (&key title description children)
  (hsx
   (html :lang "ja"
     (head
       (meta :charset "UTF-8")
       (meta :name "viewport" :content "width=device-width, initial-scale=1")
       (link :rel "icon" :href "/favicon.ico")
       (link :rel "apple-touch-icon" :href "/favicon.ico")
       (link :rel "stylesheet" :href (bust-cache "/dist.css"))
       (script :src "https://cdn.jsdelivr.net/npm/htmx.org@2.0.0/dist/htmx.min.js")
       (script :src "https://cdn.jsdelivr.net/npm/htmx-ext-head-support@2.0.0/head-support.min.js")
       (script :src "https://cdn.jsdelivr.net/npm/htmx-ext-response-targets@2.0.0/response-targets.min.js")
       (script :src "https://cdn.jsdelivr.net/npm/alpinejs@3.14.0/dist/cdn.min.js" :defer t)
       (title (format nil "~@[~a - ~]skyizwhite" title))
       (meta
         :name "description"
         :content (or description "pakuの個人サイト")))
     (body
       :hx-ext "head-support, response-targets"
       :hx-boost "true"
       :hx-target-404 "body"
       :hx-target-5* "body"
       :class "h-[100svh] flex flex-col"
       (page-header)
       (main :class "flex-1 h-full mx-auto container"
         children)))))

(defmethod jg:process-response ((app jg:app) result)
  (jg:set-response-header :content-type "text/html; charset=utf-8")
  (when (env:dev-mode-p)
    (jg:set-response-header :cache-control "no-store, no-cache, must-revalidate")
    (jg:set-response-header :pragma "no-cache")
    (jg:set-response-header :expires "0"))
  (call-next-method app
                    (hsx:render-to-string
                     (match result
                       ((guard (or (list element metadata)
                                   element)
                               (typep element 'element))
                        (document metadata element))
                       (_ (error "Invalid response form"))))))
