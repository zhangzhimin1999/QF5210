dat0.csv + theta1 -> getb.R -> b.csv

dat0.csv + b.csv -> insert.R -> dat10.csv

dat10.csv + theta2 -> filt.R -> dat1.csv

dat1.csv -> poly.R -> coef_poly.csv

coef.csv + theta1 + theta2 -> payoff.R -> payoff

optmize(payoff) -> theta10 + theta20