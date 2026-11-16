(deftemplate traveler
  (slot payment (allowed-values cash check account))
  (slot resort (allowed-values sea ski)))

(deffunction ask-question (?question $?allowed-values)
  (printout t ?question " (" (implode$ ?allowed-values) "): ")
  (bind ?answer (read))
  (while (not (member$ ?answer ?allowed-values)) do
    (printout t "Invalid input! Choose one of: " (implode$ ?allowed-values) crlf)
    (printout t ?question " (" (implode$ ?allowed-values) "): ")
    (bind ?answer (read)))
  ?answer)

(defrule get-preferences
  (not (traveler))
  =>
  (bind ?pay (ask-question "Preferred payment method?" cash check account))
  (bind ?res (ask-question "Preferred resort type?" sea ski))
  (assert (traveler (payment ?pay) (resort ?res))))

(defrule trip-odessa
  (traveler (payment cash) (resort sea))
  =>
  (printout t crlf "--- Recommended Trip ---" crlf)
  (printout t "Destination: Odessa (Black Sea resort)" crlf)
  (printout t "Transport: Train (Sumy - Odessa)" crlf)
  (printout t "Payment: cash | Estimated budget: 12000 UAH" crlf))

(defrule trip-antalya
  (traveler (payment ?p&check|account) (resort sea))
  =>
  (printout t crlf "--- Recommended Trip ---" crlf)
  (printout t "Destination: Antalya, Turkey (Sea resort)" crlf)
  (printout t "Transport: Plane" crlf)
  (printout t "Payment: " ?p " | Estimated budget: 45000 UAH" crlf))

(defrule trip-slavske
  (traveler (payment cash) (resort ski))
  =>
  (printout t crlf "--- Recommended Trip ---" crlf)
  (printout t "Destination: Slavske, Carpathians (Ski resort)" crlf)
  (printout t "Transport: Train (Sumy - Slavske)" crlf)
  (printout t "Payment: cash | Estimated budget: 14000 UAH" crlf))

(defrule trip-bukovel
  (traveler (payment ?p&check|account) (resort ski))
  =>
  (printout t crlf "--- Recommended Trip ---" crlf)
  (printout t "Destination: Bukovel, Carpathians (Ski resort)" crlf)
  (printout t "Transport: Bus (Sumy - Bukovel)" crlf)
  (printout t "Payment: " ?p " | Estimated budget: 28000 UAH" crlf))