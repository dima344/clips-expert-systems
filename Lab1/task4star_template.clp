(deftemplate person
  (multislot name)
  (slot age (type INTEGER))
  (slot gender (allowed-values male female)))

(deffacts people
  (person (name Berta Ida) (age 25) (gender female))
  (person (name Hans Peter) (age 31) (gender male))
  (person (name Ida Maria) (age 25) (gender female)))