function difforignew = fit_simp2popunw8_untreated( beta2new, dose, var, wknum, Vmaxall, coeffs2 )
%This function is called by lsqnonlin.
% beta is a vector that contains the coefficeints of the equation. dose and
% var are the input data sets that were passed to lswqnonlin
slope1 = coeffs2(1); % slope
cen1 = coeffs2(2); % MD50 bulk
slope2 = coeffs2(3);
cen2 = coeffs2(4);
f11 = beta2new(1);
f21 = beta2new(2);% fraction of population 1 week 1
f31 = beta2new(3);
f41 = beta2new(4);
f51 = beta2new(5);
f61 = beta2new(6);
f71 = beta2new(7);
f81 = beta2new(8);



n= length(dose);

nsize = wknum(:,2);

fvec1 = zeros([n 1]);
fvec1(1:sum(nsize(1))) = f11;
fvec1((sum(nsize(1))+1:sum(nsize(1:2)))) = f21;
fvec1((sum(nsize(1:2))+1:sum(nsize(1:3)))) = f31;
fvec1((sum(nsize(1:3))+1:sum(nsize(1:4)))) = f41;
fvec1((sum(nsize(1:4))+1:sum(nsize(1:5)))) = f51;
fvec1((sum(nsize(1:5))+1:sum(nsize(1:6)))) = f61;
fvec1((sum(nsize(1:6))+1:sum(nsize(1:7)))) = f71;
fvec1((sum(nsize(1:7))+1:sum(nsize(1:8)))) = f81;



 difforignew = ((((fvec1)./( 1 + exp(slope1.*(dose - cen1)))) + ((1-fvec1)./(1 + exp(slope2.*(dose - cen2)))) + 0).*Vmaxall) - var;