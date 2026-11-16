(deftemplate person
  (slot name)
  (slot age)
  (slot gender))

(deffacts people
  (person (name Berta) (age 25) (gender female))
  (person (name Hans) (age 31) (gender male))
  (person (name Ida) (age 25) (gender female)))