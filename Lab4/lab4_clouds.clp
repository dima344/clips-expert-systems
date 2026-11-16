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

(deffunction get-layer (?min ?max)
  "Determines cloud altitude layer from min and max altitude"
  (if (and (<= ?min 1800) (> ?max 6000)) then
    vertical
  else
    (if (<= ?max 1800) then
      lower
    else
      (if (and (> ?min 1800) (<= ?max 6000)) then
        middle
      else
        (if (> ?min 6000) then
          upper
        else
          unknown)))))

(deffunction is-rain-cloud (?precip ?color)
  "Checks if cloud produces precipitation and has dark-gray color"
  (and (eq ?precip yes) (eq ?color dark-gray)))

(deffunction report-cloud (?id ?type ?layer ?precip $?notes)
  "Prints identified cloud details"
  (printout t "Cloud " ?id ": " ?type
              " | Layer: " ?layer
              " | Precip: " ?precip)
  (if (> (length$ ?notes) 0) then
    (printout t " | " (implode$ ?notes)))
  (printout t crlf))

(deffunction add-cloud (?id ?min ?max ?app ?precip ?color)
  "Adds a new cloud fact to working memory"
  (assert (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
                 (appearance ?app) (precipitation ?precip) (color ?color))))

(defrule id-stratus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance smooth-sheets) (precipitation no))
  (test (eq (get-layer ?min ?max) lower))
  =>
  (report-cloud ?id Stratus lower no smooth sheets))

(defrule id-stratocumulus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance rounded-heaps) (precipitation no))
  (test (eq (get-layer ?min ?max) lower))
  =>
  (report-cloud ?id Stratocumulus lower no rounded heaps))

(defrule id-altostratus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance smooth-sheets) (precipitation no))
  (test (eq (get-layer ?min ?max) middle))
  =>
  (report-cloud ?id Altostratus middle no smooth sheets))

(defrule id-altocumulus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance rounded-heaps) (precipitation no))
  (test (eq (get-layer ?min ?max) middle))
  =>
  (report-cloud ?id Altocumulus middle no rounded heaps))

(defrule id-nimbostratus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance smooth-sheets) (precipitation ?p) (color ?c))
  (test (eq (get-layer ?min ?max) middle))
  (test (is-rain-cloud ?p ?c))
  =>
  (report-cloud ?id Nimbostratus middle yes dark-gray rain sheets))

(defrule id-cirrus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance wispy-hair) (precipitation no))
  (test (eq (get-layer ?min ?max) upper))
  =>
  (report-cloud ?id Cirrus upper no wispy hair-like))

(defrule id-cirrostratus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance smooth-sheets) (precipitation no))
  (test (eq (get-layer ?min ?max) upper))
  =>
  (report-cloud ?id Cirrostratus upper no smooth sheets))

(defrule id-cirrocumulus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance rounded-heaps) (precipitation no))
  (test (eq (get-layer ?min ?max) upper))
  =>
  (report-cloud ?id Cirrocumulus upper no rounded heaps))

(defrule id-cumulus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance rounded-heaps) (precipitation no))
  (test (eq (get-layer ?min ?max) vertical))
  =>
  (report-cloud ?id Cumulus vertical no rounded heaps))

(defrule id-cumulonimbus
  (cloud (id ?id) (altitude-min ?min) (altitude-max ?max)
         (appearance rounded-heaps) (precipitation ?p) (color ?c))
  (test (eq (get-layer ?min ?max) vertical))
  (test (is-rain-cloud ?p ?c))
  =>
  (report-cloud ?id Cumulonimbus vertical yes thunderstorm cloud))