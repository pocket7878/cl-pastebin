;;; -* Mode: Lisp; Package: COMMON-LISP-USER -*-

;;;    cl-pastebin: Common Lisp Pastebin wrapper.
;;;    Copyright (C) 2010 Masato Sogame (poketo7878@yahoo.co.jp)
;;;
;;;    This program is free software: you can redistribute it and/or modify
;;;    it under the terms of the GNU General Public License as published by
;;;    the Free Software Foundation, either version 3 of the License, or
;;;    (at your option) any later version.
;;;
;;;    This program is distributed in the hope that it will be useful,
;;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;    GNU General Public License for more details.
;;;
;;;    You should have received a copy of the GNU General Public License
;;;    along with this program.  If not, see <http://www.gnu.org/licenses/>.

(in-package :cl-pastebin)

(defvar *api-url* "http://pastebin.com/api_public.php")

(defun paste-str (str &key (name "") (email "") (subdomain "") (private 0) (expire-date "N") (paste-format "text"))
  (values 
    (http-request "http://pastebin.com/api_public.php"
		  :method :post
		  :parameters `(("paste_code" . ,str)
				("paste_name" . ,name)
				("paste_email" . ,email)
				("paste_subdomain" . ,subdomain)
				("paste_private" . ,(write-to-string private))
				("paste_expire_date"  . ,expire-date)
				("paste_format" . ,paste-format)))))

(defun file-to-str (file-path)
  (let ((acm nil))
    (with-open-file (fp file-path
			:direction :input)
      (loop for line = (read-line fp nil 'foo)
	    until (eq line 'foo)
	    do
	    (progn
	      (format t "~A~%" line)
	      (setf acm (concatenate 'string acm (format nil "~A~%" line))))))
    acm))

(defun paste-file (file-path &key (name "") (email "") (subdomain "") (private 0) (expire-date "N") (paste-format "text"))
  (let ((file-contents (file-to-str file-path)))
    (paste-str file-contents :name name 
	       :email email 
	       :subdomain subdomain 
	       :private private
	       :expire-date expire-date
	       :paste-format paste-format)))
