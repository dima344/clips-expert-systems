(defrule find-by-name-and-age
  (person (name $?name&:(member$ Ida ?name)) (age 25))
  =>
  (printout t "Found person: " (implode$ ?name) ", age 25" crlf))