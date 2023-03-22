# numbers from Fig. 2b
target_PID <- 11 # number of target protein identifications
decoy_PID <- 7 # number of decoy protein identifications
total_PID <- 19 # total entries in the protein database

# vectors of possible TP, FP PID combinations
v_possible_FP_PID <- 0:decoy_PID
v_possible_TP_PID <- target_PID - v_possible_FP_PID
v_possible_not_TP_PID <- total_PID - v_possible_TP_PID
# hypergeometric distribution returns a probability for each number of FP PID
hyper_prob <-
  dhyper(v_possible_FP_PID, v_possible_not_TP_PID, v_possible_TP_PID, decoy_PID)
hyper_prob <- hyper_prob / sum(hyper_prob)
expectation_value_FP_PID <- round(sum(hyper_prob * v_possible_FP_PID), 0)
PID_FDR <- round(expectation_value_FP_PID / target_PID, 2)

# make a plot
plot(
  hyper_prob ~ v_possible_FP_PID,
  main = expression(paste(italic(MAYU), ": protein identification false discovery rate estimation",
                          sep = "")),
  ylab = expression("P"(h["fp"])),
  xlab = expression(h["fp"]),
  ylim = c(0, 1)
)
legend("topleft", legend = c(
  paste("protein identification false discovery rate:", PID_FDR),
  paste("target protein idenfitications:", target_PID),
  paste("decoy protein idenfitications:", decoy_PID),
  paste("total proteins in database:", total_PID))
)
abline(v = expectation_value_FP_PID, lty = 2)