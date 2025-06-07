(defpackage #:website/components/header
  (:use #:cl
        #:hsx
        #:jingle)
  (:export #:~header))
(in-package #:website/components/header)

(defparameter *pc-menu*
  '(("/about" "about")
    ("/works" "works")
    ("/blog" "blog")))

(defparameter *sp-menu*
  (cons '("/" "home") *pc-menu*))

(defcomp ~pc-header ()
  (hsx
   (header :class "hidden md:flex justify-between py-4 border-b-1 top-0 bg-white"
     (p :class "z-20 text-3xl font-bold"
       (a :href "/" "skyizwhite"))
     (nav :class "flex items-end"
       (ul :class "flex gap-4 text-xl font-bold"
         (loop
           :for (href label) :in *pc-menu* :collect
              (if (string= href (request-uri *request*))
                  (hsx (li :class "text-pink-500" label))
                  (hsx (li (a :href href :class "hover:text-pink-500" label))))))))))

(defcomp ~sp-header ()
  (hsx
   (header
     :data-signals-open "false"
     :class "flex md:hidden justify-between py-2 border-b-1 top-0 bg-white"
     (p :class "z-20 text-2xl font-bold"
       (a :href "/" "skyizwhite"))
     (div
       (button
         :aria-label "Open menu"
         :class "z-20 size-8 flex flex-col justify-center cursor-pointer relative"
         :type "button"
         :data-on-click "$open = !$open"
         (div :class "grid justify-items-center gap-1.5"
           (span
             :class "h-1 w-8 rounded-full bg-black transition duration-400"
             :data-class "{'rotate-45 translate-y-2.5': $open}")
           (span
             :class "h-1 w-8 rounded-full bg-black transition duration-400"
             :data-class "{'scale-x-0': $open}")
           (span
             :class "h-1 w-8 rounded-full bg-black transition duration-400"
             :data-class "{'-rotate-45 -translate-y-2.5': $open}")))
       (nav
         :data-show.duration_300ms "$open"
         :class (clsx "fixed flex flex-col items-center justify-center"
                      "z-10 top-0 right-0 w-full h-full gap-16 bg-gray-200"
                      "transition duration-300 opacity-0")
         :data-class "{'opacity-100': $open}"
         (h2 :class "text-5xl font-bold"
           "Menu")
         (ul :class "flex flex-col h-fit gap-8 text-3xl font-bold"
           (loop
             :for (href label) :in *sp-menu* :collect
                (if (string= href (request-uri *request*))
                    (hsx (li :class "text-pink-500" label))
                    (hsx (li (a :href href :class "hover:text-pink-500" label)))))))))))

(defcomp ~header ()
  (hsx
   (<>
     (~pc-header)
     (~sp-header))))
