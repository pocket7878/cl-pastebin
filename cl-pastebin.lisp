(in-package :cl-pastebin)

(defvar *api-url* "http://pastebin.com/api_public.php")

(defun paste-str (str &key (name "") (email "") (subdomain "") (private 0) (expire-date "N") (paste-format "text"))
  (when (string= "" str)
    (error "ERROR: Passed empty string."))
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
