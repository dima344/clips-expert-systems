(deftemplate family-relation
  (slot type (allowed-values father mother parents))
  (slot child)
  (multislot parent))

(deftemplate family-role
  (slot person)
  (slot role (allowed-values father mother son daughter)))

(deftemplate gender
  (slot person)
  (slot sex (allowed-values male female)))

(deffacts family-facts
  (family-relation (type father) (child John) (parent Tom))
  (family-relation (type mother) (child John) (parent Susan))
  (family-relation (type parents) (child John) (parent Tom Susan))
  (family-role (person Tom) (role father))
  (family-role (person Susan) (role mother))
  (family-role (person John) (role son))
  (gender (person Tom) (sex male))
  (gender (person Susan) (sex female))
  (gender (person John) (sex male)))

(defrule print-father-of
  (declare (salience 90))
  (family-relation (type father) (child ?c) (parent ?p))
  =>
  (printout t "The father of " ?c " is " ?p "." crlf))

(defrule print-mother-of
  (declare (salience 80))
  (family-relation (type mother) (child ?c) (parent ?p))
  =>
  (printout t "The mother of " ?c " is " ?p "." crlf))

(defrule print-parents-of
  (declare (salience 70))
  (family-relation (type parents) (child ?c) (parent ?p1 ?p2))
  =>
  (printout t "The parents of " ?c " are " ?p1 " and " ?p2 "." crlf))

(defrule print-is-father
  (declare (salience 60))
  (family-role (person ?p) (role father))
  =>
  (printout t ?p " is a father." crlf))

(defrule print-is-mother
  (declare (salience 50))
  (family-role (person ?p) (role mother))
  =>
  (printout t ?p " is a mother." crlf))

(defrule print-is-son
  (declare (salience 40))
  (family-role (person ?p) (role son))
  =>
  (printout t ?p " is a son." crlf))

(defrule print-father-gender
  (declare (salience 30))
  (family-role (person ?p) (role father))
  (gender (person ?p) (sex ?s))
  =>
  (printout t ?p " is a " ?s "." crlf))

(defrule print-mother-gender
  (declare (salience 20))
  (family-role (person ?p) (role mother))
  (gender (person ?p) (sex ?s))
  =>
  (printout t ?p " is a " ?s "." crlf))

(defrule print-son-gender
  (declare (salience 10))
  (family-role (person ?p) (role son))
  (gender (person ?p) (sex ?s))
  =>
  (printout t ?p " is a " ?s "." crlf))