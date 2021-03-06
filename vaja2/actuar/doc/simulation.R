### R code from vignette source 'simulation.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: simulation.Rnw:73-75
###################################################
library(actuar)
options(width = 60, digits = 4)


###################################################
### code chunk number 2: simulation.Rnw:144-146
###################################################
rmixture(10, probs = c(2, 1),
         models = expression(rexp(3), rexp(7)))


###################################################
### code chunk number 3: simulation.Rnw:199-201
###################################################
rcompound(10, rpois(1.5), rgamma(3, 2))
rcomppois(10, 1.5, rgamma(3, 2))


###################################################
### code chunk number 4: simulation.Rnw:233-238
###################################################
x <- rcomppois(1e5, 3.5,
               rmixture(probs = c(2, 1, 0.5),
                        expression(rgamma(3),
                                   rgamma(5, 4),
                                   rlnorm(2, 1))))


###################################################
### code chunk number 5: simulation.Rnw:244-245
###################################################
mean(x)


###################################################
### code chunk number 6: simulation.Rnw:278-279 (eval = FALSE)
###################################################
## rpois(n, rgamma(n, 3, rgamma(n, 2, 2)))


###################################################
### code chunk number 7: simulation.Rnw:445-446
###################################################
set.seed(3)


###################################################
### code chunk number 8: simulation.Rnw:448-461
###################################################
nodes <- list(cohort = 2,
              contract = c(4, 3),
              year = c(4, 4, 4, 4, 5, 5, 5))
mf <- expression(cohort = rexp(2),
                 contract = rgamma(cohort, 1),
                 year = rpois(weights * contract))
ms <- expression(cohort = rnorm(2, sqrt(0.1)),
                 contract = rnorm(cohort, 1),
                 year = rlnorm(contract, 1))
wijt <- runif(31, 0.5, 2.5)
pf <- simul(nodes = nodes,
            model.freq = mf, model.sev = ms,
            weights = wijt)


###################################################
### code chunk number 9: simulation.Rnw:468-471
###################################################
class(pf)
pf$data
pf$classification


###################################################
### code chunk number 10: simulation.Rnw:483-484
###################################################
pf


###################################################
### code chunk number 11: simulation.Rnw:492-494
###################################################
aggregate(pf)
aggregate(pf, by = c("cohort", "year"), FUN = mean)


###################################################
### code chunk number 12: simulation.Rnw:501-503
###################################################
frequency(pf)
frequency(pf, by = "cohort")


###################################################
### code chunk number 13: simulation.Rnw:519-521
###################################################
severity(pf)
severity(pf, splitcol = 1)


###################################################
### code chunk number 14: simulation.Rnw:526-527
###################################################
weights(pf)


###################################################
### code chunk number 15: simulation.Rnw:532-533
###################################################
aggregate(pf, classif = FALSE) / weights(pf, classif = FALSE)


###################################################
### code chunk number 16: simulation.Rnw:561-563
###################################################
set.seed(123)
options(width = 55)


###################################################
### code chunk number 17: simulation.Rnw:565-567
###################################################
wit <- rgamma(15, rep(runif(3, 0, 100), each = 5),
              rep(runif(3, 0, 100), each = 5))


###################################################
### code chunk number 18: simulation.Rnw:575-580
###################################################
frequency(simul(list(entity = 3, year = 5),
                expression(entity = rgamma(rgamma(1, 5, 5),
                                           rgamma(1, 25, 1)),
                           year = rpois(weights * entity)),
                weights = wit))


