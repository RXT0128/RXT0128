;; Created by Jacob Hrbek identified using an electronic mail kreyren@rixotstudio.cz with GPG 0x765AED304211C28410D5C478FCBA0482B0AB9F10 under all rights reserved in 17.07.2020 13:22:47

;;;! # find-emacs-dirs.el
;;;! Find emacs directories allowing for an emacs distro that is independent from file hierarchy
;;;!
;;;! ## Expected directories
;;;! On GNU/Linux we are expecting path '$XDG_CONFIG_HOME/<distro-name>' if XDG_CONFIG_HOME is not defined we will try to use '$HOME/.local/<distro-name>'
;;;!
;;;! On Windows FIXME-DOCS
;;;!
;;;! ## Variable EMACS_DISTRIBUTION_DATA
;;;! Because 'emacs --eval ...' is evaluated after init.el we are using variable 'EMACS_DISTRIBUTION_DATA' that is evaluated during the init.el initialization to set value for 'user-emacs-directory' to make the distribution independent on the filesystem hierarchy
;;;!
;;;! If the variable is not defined, then the distribution is going to use hardcodded logic to find it
;;;!
;;;! ---
;;;!
;;;! WARNING: Use only standard functions as this is used at the header of the file during initialization to find the directory
(cond
 ((> (length (getenv "EMACS_DIR")) 0)
  (setq user-emacs-directory (getenv "EMACS_DIR")))
 ;; If EMACS_DIR variable is unset or blank
 ((= (length (getenv "EMACS_DIR")) 0)
  (cl-case system-type
    ((gnu gnu/linux)
     (cond
      ((> (length (getenv "XDG_CONFIG_HOME")) 0)
       ;; FIXME-QA: Implement check for expected directory
       (setq user-emacs-directory (concat (getenv "XDG_CONFIG_HOME") "/" emacs-distro-name)))
      ((= (length (getenv "XDG_CONFIG_HOME")) 0)
       ;; FIXME-QA: Implement check for expected directory
       (setq user-emacs-directory (concat (getenv "HOME") "/" emacs-distro-name)))
      (t
       (message "Unexpected happend while trying to find custom emacs distribution directory which is most likely a bug, you might want to use environment variable 'EMACS_DIR'")
       (kill-emacs 250))))
    ((windows-nt ms-dos)
     (princ "FIXME: Platform '%1$s' is not implemented in find-emacs-dirs.el codeblock")
     (kill-emacs 28))
    ((gnu/kfreebsd darwin cygwin aix berkeley-unix hpux irix usg-unix-v)
     (princ "FIXME: Platform '%1$s' is unimplemented aldo theoretically supported, exitting for safety as it was not tested" system-type)
     (kill-emacs 28))
    (t
     (princ "Unexpected happend while processing system-type variable storing '%1$s', guessing not implemented?" system-type))))
 (t
  (message "Unexpected happend while looking for emacs directories in codeblock 'find-emacs-dirs.el'")
  (kill-emacs 255)))
