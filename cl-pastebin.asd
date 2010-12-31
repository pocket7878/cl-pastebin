(asdf:defsystem :cl-pastebin
  :name "cl-pastebin"
  :version "1.0"
  :maintainer "Masato Sogame"
  :author "Masato Sogame <poketo7878@yahoo.co.jp>"
  :description "Pastebin API wrapper"
  :depends-on (:drakma)
  :serial t
  :components
  ((:file "package")
   (:file "cl-pastebin")))
