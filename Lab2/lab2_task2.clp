(deftemplate flight
  (slot from)
  (slot to))

(deffacts airline-network
  (flight (from San-Francisco) (to Chicago))
  (flight (from San-Francisco) (to Los-Angeles))
  (flight (from San-Francisco) (to Houston))
  (flight (from Los-Angeles) (to Houston))
  (flight (from Chicago) (to New-York))
  (flight (from Chicago) (to Indianapolis))
  (flight (from Indianapolis) (to Houston))
  (flight (from Houston) (to New-York)))