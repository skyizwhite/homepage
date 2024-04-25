(defpackage #:hp/config/asset
  (:use #:cl)
  (:export #:*asset-roots*
           #:*hx-ext*))
(in-package #:hp/config/asset)

(defparameter *asset-roots*
  '(:root "/"
    :img "/img/"
    :vendor "/vendor/"
    :htmx-ext "/vendor/htmx-ext/"
    :alpine-ext "/vendor/alpine-ext/"))

(defparameter *hx-ext*
  "head-support,alpine-morph")
