library(dplyr)
dcf_calc(price =  105.47,
eps = 8.57,
dcf.discount.rate = .12,
growth.rate = .2,
years.growth = 10,
stable.growth = .04,
years.stable = 10) %>% lapply(., sum) %>% unlist()

dcf_calc <- function(price ,
                     eps,
                     dcf.discount.rate = .10,
                     growth.rate,
                     years.growth = 10,
                     stable.growth = .03,
                     years.stable = 10
  
){
  
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
  
 fv.all <- data.frame(growth = growth.eps,stable = stable.eps)
 
  n <- max(length(pv.growth), length(pv.stable))
  length(pv.growth) <- n                      
  length(pv.stable) <- n
  pv.growth[is.na(pv.growth)] <- 0

  full.eps.vector <- c(-price,stable.eps + growth.eps)
  return(list(pv.growth,pv.stable,pv.growth + pv.stable))

}