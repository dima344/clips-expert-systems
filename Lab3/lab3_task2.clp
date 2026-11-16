(deftemplate cloud
  (slot id)
  (slot altitude-min (type NUMBER))
  (slot altitude-max (type NUMBER))
  (slot appearance (allowed-values rounded-heaps smooth-sheets wispy-hair))
  (slot precipitation (allowed-values yes no))
  (slot color (allowed-values white light-gray dark-gray)))

(deffacts sample-clouds
  (cloud (id C1) (altitude-min 500) (altitude-max 1500)
         (appearance smooth-sheets) (precipitation no) (color light-gray))
  (cloud (id C2) (altitude-min 2500) (altitude-max 4000)
         (appearance smooth-sheets) (precipitation yes) (color dark-gray))
  (cloud (id C3) (altitude-min 7000) (altitude-max 9500)
         (appearance wispy-hair) (precipitation no) (color white))
  (cloud (id C4) (altitude-min 1000) (altitude-max 8500)
         (appearance rounded-heaps) (precipitation yes) (color dark-gray))
  (cloud (id C5) (altitude-min 3000) (altitude-max 5000)
         (appearance rounded-heaps) (precipitation no) (color white)))

(defrule id-stratus
  (cloud (id ?id) (altitude-max ?max&:(<= ?max 1800))
         (appearance smooth-sheets) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Stratus (lower layer)" crlf))

(defrule id-stratocumulus
  (cloud (id ?id) (altitude-max ?max&:(<= ?max 1800))
         (appearance rounded-heaps) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Stratocumulus (lower layer)" crlf))

(defrule id-altostratus
  (cloud (id ?id) (altitude-min ?min&:(> ?min 1800)) (altitude-max ?max&:(<= ?max 6000))
         (appearance smooth-sheets) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Altostratus (middle layer)" crlf))

(defrule id-altocumulus
  (cloud (id ?id) (altitude-min ?min&:(> ?min 1800)) (altitude-max ?max&:(<= ?max 6000))
         (appearance rounded-heaps) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Altocumulus (middle layer)" crlf))

(defrule id-nimbostratus
  (cloud (id ?id) (altitude-min ?min&:(> ?min 1800)) (altitude-max ?max&:(<= ?max 6000))
         (appearance smooth-sheets) (precipitation yes) (color dark-gray))
  =>
  (printout t "Cloud " ?id ": Nimbostratus (middle layer, precipitation)" crlf))

(defrule id-cirrus
  (cloud (id ?id) (altitude-min ?min&:(> ?min 6000))
         (appearance wispy-hair) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Cirrus (upper layer)" crlf))

(defrule id-cirrostratus
  (cloud (id ?id) (altitude-min ?min&:(> ?min 6000))
         (appearance smooth-sheets) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Cirrostratus (upper layer)" crlf))

(defrule id-cirrocumulus
  (cloud (id ?id) (altitude-min ?min&:(> ?min 6000))
         (appearance rounded-heaps) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Cirrocumulus (upper layer)" crlf))

(defrule id-cumulus
  (cloud (id ?id) (altitude-min ?min&:(<= ?min 1800)) (altitude-max ?max&:(> ?max 6000))
         (appearance rounded-heaps) (precipitation no))
  =>
  (printout t "Cloud " ?id ": Cumulus (vertical development)" crlf))

(defrule id-cumulonimbus
  (cloud (id ?id) (altitude-min ?min&:(<= ?min 1800)) (altitude-max ?max&:(> ?max 6000))
         (appearance rounded-heaps) (precipitation yes) (color dark-gray))
  =>
  (printout t "Cloud " ?id ": Cumulonimbus (vertical development, precipitation)" crlf))