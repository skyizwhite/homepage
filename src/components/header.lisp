(defpackage #:hp/components/header
  (:use #:cl
        #:hsx)
  (:export #:page-header))
(in-package #:hp/components/header)

(defcomp page-header ()
  (let ((links '(("Home" "/")
                 ("About" "/about")
                 ("Work" "/work")
                 ("Article" "/article")
                 ("Contact" "/contact"))))
    (hsx
     (header :class "fixed top-0 w-full"
       (div :class "container flex justify-between py-6"
         (h1
           (a :href "/"
             (img
               :src "/logo.png" :alt "Amongtellers"
               :class "w-52 h-auto")))
         (ul :class "flex flex-col gap-4"
           (loop
             :for (title href) :in links :collect
                (hsx
                 (li :class "flex items-center"
                   (a :href href :class "text-lg hover:text-orange-600"
                     title))))))))))
