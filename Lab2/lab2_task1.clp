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