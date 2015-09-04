# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Name of QuantLet : MVAlinreg2bh
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Published in : Applied Multivariate Statistical Analysis
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Description : Performs a linear regression for the 
# subset of the transformed Boston housing data.
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Keywords : linear, regression, linear regression, 
# multivariate, transformation
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# See also : MVAlinregbh
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Author : Till Grossmass, Jorge Patron, 
# Vladimir Georgescu, Song Song, Awdesch Melzer
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Submitted : Wed, April 04 2012 by Dedy Dwi Prastyo
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Datafile : bostonh.dat
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


rm(list=ls(all=TRUE))
graphics.off()

x   = read.table("bostonh.dat")
xt  = x;

xt[,1]  = log(x[,1]);
xt[,2]  = x[,2]/10;
xt[,3]  = log(x[,3]);
xt[,5]  = log(x[,5]);
xt[,6]  = log(x[,6]);
xt[,7]  = (x[,7]^(2.5))/10000;
xt[,8]  = log(x[,8]);
xt[,9]  = log(x[,9]);
xt[,10] = log(x[,10]);
xt[,11] = exp(0.4*x[,11])/1000;
xt[,12] = x[,12]/100;
xt[,13] = sqrt(x[,13]);
xt[,14] = log(x[,14]);

Z = cbind(rep(1,length(xt[,1])), xt[,4], xt[,5], 
  xt[,6], xt[,8], xt[,9], xt[,10], xt[,11], xt[,12], xt[,13])
y = xt[,14];

dump    = dim(Z);
m       = dump[1]
n       = dump[2]
df      = m-n;
b       = solve(t(Z)%*%Z)%*%t(Z)%*%y;
yhat    = Z%*%b;
r       = y - yhat;
mse     = t(r)%*%r/df;
covar   = solve(t(Z)%*%Z)%*%diag(rep(mse,n));
se      = sqrt(diag(covar));
t       = b/se;
t2      = abs(t);
k       = t2^2/(df + t2^2);
p       = 0.5*(1+sign(t2)*pbeta( k, 0.5, 0.5*df)) ;
Pvalues = 2*(1-p);

tablex  = cbind(round(b,4), round(se,4), round(t,3), round(Pvalues,4))

print('Table with coefficient estimates, Standard error, value of the t-statistic and ');
print('p-value (for the intercept (first line) and variables 4 to 6 and 8 to 13 (lines 2 to 10))');
tablex
