function[lowerlim2, upperlim2] = BSerrorinparams2(residuals2_8, beta2_8, cohort_8)
dose = cohort_8(:,2);

[ Vmaxbyweek, Vmaxweekavg, ninweek, wknum, Vmaxall] = findVmaxandsize(cohort_8);
nsize = wknum(:,2);
v_model2=model2popallweeksnormed( dose, beta2_8, Vmaxbyweek, nsize);
nboot = 500;
[~, bootIndices] = bootstrp(nboot, [], residuals2_8); % randomly generates indices
bootResiduals = residuals2_8(bootIndices); % uses indices to sample from residuals with replacement
varBoot = repmat(v_model2,1,nboot) + bootResiduals; % creates simulated data set
% build up the bootstrap data sets to the single population function
cohort_8_boot = cohort_8;
options = optimset('Display','off','FunValCheck','on', ...
                   'MaxFunEvals',Inf,'MaxIter',Inf, ...
                   'TolFun',1e-6,'TolX',1e-6);
%define bounds for all parameters
            % m1 cen1 m2 cen 2 wk1sens wk1res etc...
 for i = 1:nboot
     cohort_8_boot(:,3) = varBoot(:,i);
    [ Vmaxbyweek_boot, Vmaxweekavg_boot, ninweek_boot, wknum_boot, Vmaxall_boot] = findVmaxandsize(cohort_8_boot);
if length(Vmaxbyweek) == 6
options = optimset('Display','off','FunValCheck','on', ...
                   'MaxFunEvals',Inf,'MaxIter',Inf, ...
                   'TolFun',1e-6,'TolX',1e-6);
paramslb = zeros([10 1]);
paramsub = [ Inf; Inf; Inf; Inf; 1; 1; 1; 1; 1; 1];

% sets up initial values of beta2new
params0 = [ .1; 17; .04; 50; .5; .5; .5; .5; .5; .5];
% outputs betaLD50 with first 12 paramters slope values, second 12 are
% center values in week order

betaboot(i,:) = lsqnonlin(@fit_simp2popunw6,...
    params0,...
    paramslb,...
    paramsub,...
    options,...
    dose,...
    varBoot(:,i),...
    wknum_boot,...
    Vmaxall_boot);
end 
if length(Vmaxbyweek) == 8 
options = optimset('Display','off','FunValCheck','on', ...
                   'MaxFunEvals',Inf,'MaxIter',Inf, ...
                   'TolFun',1e-6,'TolX',1e-6);
paramslb = zeros([12 1]);
paramsub = [ Inf; Inf; Inf; Inf; 1; 1; 1; 1; 1; 1; 1; 1];

% sets up initial values of beta2new
params0 = [ .1; 17; .04; 50; .5; .5; .5; .5; .5; .5; .5; .5];
% outputs betaLD50 with first 12 paramters slope values, second 12 are
% center values in week order

betaboot(i,:) = lsqnonlin(@fit_simp2popunw8,...
    params0,...
    paramslb,...
    paramsub,...
    options,...
    dose,...
    varBoot(:,i),...
    wknum_boot,...
    Vmaxall_boot);
end 

if length(Vmaxbyweek) == 15 
paramslb = zeros([19 1]);
paramsub = [ Inf; Inf; Inf; Inf; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1;];

% sets up initial values of beta2new
params0 = [ .1; 17; .04; 50; .5; .5; .5; .5; .5; .5; .5; .5; .5; .5; .5; .5; .5; .5; .5];

    betaboot(i,:)= lsqnonlin(@fit_simp2popunw15,...
    params0,...
    paramslb,...
    paramsub,...
    options,...
    dose,...
    varBoot(:,i),...
    wknum_boot,...
    Vmaxall_boot);
     
end
end

 bootCI = prctile(betaboot, [2.5 97.5]);
 lowerlim2 = bootCI(1,:);
 upperlim2 = bootCI(2,:);
end