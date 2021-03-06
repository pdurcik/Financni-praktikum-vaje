### R code from vignette source 'credibility.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: credibility.Rnw:65-67
###################################################
library(actuar)
options(width = 60, digits = 4)


###################################################
### code chunk number 2: credibility.Rnw:102-104
###################################################
data(hachemeister)
hachemeister


###################################################
### code chunk number 3: credibility.Rnw:258-264
###################################################
X <- cbind(cohort = c(1, 2, 1, 2, 2), hachemeister)
fit <- cm(~cohort + cohort:state, data = X,
          ratios = ratio.1:ratio.12,
          weights = weight.1:weight.12,
          method = "iterative")
fit


###################################################
### code chunk number 4: credibility.Rnw:271-272
###################################################
predict(fit)


###################################################
### code chunk number 5: credibility.Rnw:277-278
###################################################
summary(fit)


###################################################
### code chunk number 6: credibility.Rnw:284-286
###################################################
summary(fit, levels = "cohort")
predict(fit, levels = "cohort")


###################################################
### code chunk number 7: credibility.Rnw:318-319
###################################################
cm(~state, hachemeister, ratios = ratio.1:ratio.12)


###################################################
### code chunk number 8: credibility.Rnw:324-326
###################################################
cm(~state, hachemeister, ratios = ratio.1:ratio.12,
   weights = weight.1:weight.12)


###################################################
### code chunk number 9: credibility.Rnw:355-360
###################################################
fit <- cm(~state, hachemeister, regformula = ~ time,
          regdata = data.frame(time = 1:12),
          ratios = ratio.1:ratio.12,
          weights = weight.1:weight.12)
fit


###################################################
### code chunk number 10: credibility.Rnw:365-366
###################################################
predict(fit, newdata = data.frame(time = 13))


###################################################
### code chunk number 11: credibility.Rnw:376-389
###################################################
plot(NA, xlim = c(1, 13), ylim = c(1000, 2000), xlab = "", ylab = "")
x <- cbind(1, 1:12)
lines(1:12, x %*% fit$means$portfolio,
      col = "blue", lwd = 2)
lines(1:12, x %*% fit$means$state[, 4],
      col = "red", lwd = 2, lty = 2)
lines(1:12, x %*% coefficients(fit$adj.models[[4]]),
      col = "darkgreen", lwd = 2, lty = 3)
points(13, predict(fit, newdata = data.frame(time = 13))[4],
       pch = 8, col = "darkgreen")
legend("bottomright",
       legend = c("collective", "individual", "credibility"),
       col = c("blue", "red", "darkgreen"), lty = 1:3)


###################################################
### code chunk number 12: credibility.Rnw:406-412
###################################################
fit2 <- cm(~state, hachemeister, regformula = ~ time,
           regdata = data.frame(time = 1:12),
           adj.intercept = TRUE,
           ratios = ratio.1:ratio.12,
           weights = weight.1:weight.12)
summary(fit2, newdata = data.frame(time = 13))


###################################################
### code chunk number 13: credibility.Rnw:419-433
###################################################
plot(NA, xlim = c(1, 13), ylim = c(1000, 2000), xlab = "", ylab = "")
x <- cbind(1, 1:12)
R <- fit2$transition
lines(1:12, x %*% solve(R, fit2$means$portfolio),
      col = "blue", lwd = 2)
lines(1:12, x %*% solve(R, fit2$means$state[, 4]),
      col = "red", lwd = 2, lty = 2)
lines(1:12, x %*% solve(R, coefficients(fit2$adj.models[[4]])),
      col = "darkgreen", lwd = 2, lty = 3)
points(13, predict(fit2, newdata = data.frame(time = 13))[4],
       pch = 8, col = "darkgreen")
legend("bottomright",
       legend = c("collective", "individual", "credibility"),
       col = c("blue", "red", "darkgreen"), lty = 1:3)


