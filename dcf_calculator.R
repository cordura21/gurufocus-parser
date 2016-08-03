dprice <- 105.47
eps <- 8.57
dcf.discount.rate <- .12
growth.rate <- .2
years.growth <- 10
stable.growth <- .04
years.stable <- 10

growth.eps <- rep(1+growth.rate,years.growth)
growth.eps <- cumprod(growth.eps)
growth.eps <- eps * growth.eps

stable.eps <- rep(1+stable.growth,years.stable)
stable.eps <- cumprod(stable.eps)
last.growth.eps <- growth.eps[years.growth]
stable.eps <- last.growth.eps * stable.eps
stable.eps <- c(rep(0,years.growth),stable.eps)

discount.vector.growth <-  rep(1+dcf.discount.rate,years.growth)
discount.vector.growth <-  1 / cumprod(discount.vector.growth)    

discount.vector.stable <-  rep(1+dcf.discount.rate,years.growth + years.stable)
discount.vector.stable <-  1 / cumprod(discount.vector.stable)    

pv.growth <- growth.eps * discount.vector.growth
pv.stable <- stable.eps * discount.vector.stable

sum(pv.growth)
sum(pv.stable)

fv.all <- data.frame(growth = growth.eps,stable = stable.eps)
sum(cbind(growth.eps,stable.eps,))

n <- max(length(growth.eps), length(stable.eps))
length(growth.eps) <- n                      
length(stable.eps) <- n
growth.eps[is.na(growth.eps)] <- 0
stable.eps + growth.eps

full.eps.vector <- c(-price,stable.eps + growth.eps)
expected.growth.rate <- irr(full.eps.vector)
