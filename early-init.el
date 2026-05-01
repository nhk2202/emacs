;; -*- lexical-binding: t -*-

(defconst gc-cons-threshold-og gc-cons-threshold "Original value of gc-cons-threshold.")
(defconst gc-cons-percentage-og gc-cons-percentage "Origincal value of gc-cons-percentage.")
(defconst file-name-handler-alist-og file-name-handler-alist "Original value of file-name-handler-alist.")
(defconst vc-handled-backends-og vc-handled-backends "Original value of vc-handled-backends.")

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 1
      file-name-handler-alist nil
      vc-handled-backends nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold gc-cons-threshold-og
                  gc-cons-percentage gc-cons-percentage-og
                  file-name-handler-alist file-name-handler-alist-og
                  vc-handled-backends vc-handled-backends-og)))


(setq package-enable-at-startup nil
      package-quickstart nil)


(dolist (item '((menu-bar-lines . 0)
                (tool-bar-lines . 0)
                (vertical-scroll-bars . nil)
                (fullscreen . maximized)))
  (add-to-list 'default-frame-alist item))
