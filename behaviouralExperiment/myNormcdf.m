function y = myNormcdf(p, x)
% myNormcdf - re-wrap normcdf
%               lsqcurvefit needs the outputs of this to be in this way!

mu = p(1);
sigma = p(2);

y = normcdf(x, mu, sigma)



end