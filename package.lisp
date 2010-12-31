(cl:defpackage :cl-pastebin
  (:use :common-lisp :drakma)
  (:nicknames "pastebin")
  (:export #:paste-str
	   #:paste-file))
