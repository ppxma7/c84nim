function[t1, t2, r2] = returnStats(betas, pred, oneTimecourse, G)
% returnStats - Returns r2 and t for given betas/design matrix/contrast
%
%
%               
%
%
% ma 2015-12-14 see also: statsAssignment, makeDM, voxView

load sliceData;
% Get the squared error
resids = (pred - oneTimecourse);
sResids = resids.^2;

% Get the sum of squared errors
ssR = sum(sResids);

% r2 is the coefficient of determination (bigger r2, more variability
% explained by our model).
% r2 = 1 - ssR/ssData
r2 = 1 - var(resids)./var(oneTimecourse);


% define a contrast
c = info.facesVhouses(:);
% Get the t-statistic
sigma2 = ssR / (length(oneTimecourse) - size(G,2));
t1 = c' * betas / sqrt(sigma2 * c' * inv(G'*G) * c);

% disp('Faces vs Houses')
% disp(t1)

c = info.houseVfaces(:);
sigma2 = ssR / (length(oneTimecourse) - size(G,2));
t2 = c' * betas / sqrt(sigma2 * c' * inv(G'*G) * c);

% disp('Houses vs Faces')
% disp(t2)




end