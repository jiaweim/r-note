mass <- read.csv("D:/Mass.csv") # MaxQuant 提取出来的所有 feature 质量
row_mass <- nrow(mass)
mass_out <- cbind(mass,
                  Neu5Ac = rep(0, row_mass),
                  HexNAc = rep(0, row_mass),
                  Hex = rep(0, row_mass),
                  Fuc = rep(0, row_mass),
                  Red_HexNAc = rep(0, row_mass),
                  deviation = rep(0, row_mass))

identify_glycans <- function(q) {

  Neu5Ac <- 361.17366
  HexNAc <- 245.12632
  Hex <- 204.09977
  Fuc <- 174.08921
  Red_HexNAc <- 261.15762

  t <- q %/% Neu5Ac # 整除
  j <- q %/% HexNAc
  m <- q %/% Hex
  n <- q %/% Fuc
  w <- q %/% Red_HexNAc

  for (Neu5Ac_n in 0:t)
    for (HexNAc_n in 0:j)
      for (Hex_n in 0:m)
        for (Fuc_n in 0:n)
          for (Red_HexNAc_n in 0:w) {
            total_1 <- sum(407.21553 * Neu5Ac_n, 291.16819 * HexNAc_n, 250.14164 * Hex_n, 220.13108 * Fuc_n, 307.19949 * Red_HexNAc_n)
            total_2 <- total_1 - sum(Neu5Ac_n, HexNAc_n, Hex_n, Fuc_n, Red_HexNAc_n, -1) * 46.04187
            deviation <- abs(total_2 - q) / total_2 * 1000000

            if (Red_HexNAc_n == 1 &
              HexNAc_n > 0 &
              Hex_n > 2 &
              deviation < 1.5) { y <- c(Neu5Ac_n, HexNAc_n, Hex_n, Fuc_n, Red_HexNAc_n, deviation)
              return(y)
            }
          }
}

for (n_record in 1:row_mass)
{
  print(n_record)
  pass <- lapply(mass[n_record, 1], identify_glycans)
  pass_2 <- unlist(pass)
  if (length(pass_2) > 2)
  { mass_out[n_record, 2] <- pass_2[1]
    mass_out[n_record, 3] <- pass_2[2]
    mass_out[n_record, 4] <- pass_2[3]
    mass_out[n_record, 5] <- pass_2[4]
    mass_out[n_record, 6] <- pass_2[5]
    mass_out[n_record, 7] <- pass_2[6]
  }
}

write.table(mass_out, row.names = F, col.names = T, file = "D:/Monosaccharide composition.csv", sep = ",")
