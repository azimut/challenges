(asdf:defsystem #:lisperati
  :description "Describe lisperati here"
  :author "azimut <azimut.github@protonmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "lisperati"))
  :in-order-to ((asdf:test-op (asdf:test-op :lisperati/test))))

(asdf:defsystem #:lisperati/test
  :description "Tests for lisperati"
  :author "azimut <azimut.github@protonmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:lisperati #:parachute)
  :pathname "t"
  :components ((:file "package"))
  :perform (asdf:test-op (op c) (uiop:symbol-call :parachute :test :lisperati-test)))
