(defrule find-men
  (person (name $?name) (gender male))
  =>
  (printout t "Man found: " (implode$ ?name) crlf))