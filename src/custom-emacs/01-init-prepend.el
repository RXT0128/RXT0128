;;;- This file is prepended to the created init.el file
;;; init.el -- APPEND_DISTRO_NAME initization file
;; Based on emacs-distro-from-scratch project <URL_HERE> origically created by Jacob Hrbek identified using an electronic mail kreyren@rixotstudio.cz with GPG 0x765AED304211C28410D5C478FCBA0482B0AB9F10 under all rights reserved in 17.07.2020 13:22:47

;; RELEVANT: Making emacs file-hierarchy independant https://emacs.stackexchange.com/questions/4253/how-to-start-emacs-with-a-custom-user-emacs-directory

;; Define the name of this distribution
(defvar emacs-distro-name "APPEND_DISTRO_NAME" "Non-standard variable storing the name of used emacs distribution, this must be a string")

(message (concat "Welcome to " emacs-distro-name "!"))
