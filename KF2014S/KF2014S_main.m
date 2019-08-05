clc
clear all
close all

% KF2014S
global theta EL

q = 1; % For constant light, q=1, constant dark, q=0
if q == 1
    load FogelmarkPCB_training_set2.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pLHY = pLHY12(r1:r2);
    mCCA1 = mCCA112(r1:r2);
    pCCA1 = pCCA112(r1:r2);
    pP = pP12(r1:r2);
    mPRR9 = mPRR912(r1:r2);
    pPRR9 = pPRR912(r1:r2);
    mPRR7 = mPRR712(r1:r2);
    pPRR7 = pPRR712(r1:r2);
    mPRR5 = mPRR512(r1:r2);
    pcPRR5 = pcPRR512(r1:r2);
    pnPRR5 = pnPRR512(r1:r2);
    mTOC1 = mTOC112(r1:r2);
    pcTOC1 = pcTOC112(r1:r2);
    pnTOC1 = pnTOC112(r1:r2);
    mELF4 = mELF412(r1:r2);
    pELF4 = pELF412(r1:r2);
    pdELF4 = pdELF412(r1:r2);
    mELF3 = mELF312(r1:r2);
    pELF3 = pELF312(r1:r2);
    pE34 = pE3412(r1:r2);
    mLUX = mLUX12(r1:r2);
    pLUX = pLUX12(r1:r2);
    pcCOP1 = pcCOP112(r1:r2);
    pnCOP1 = pnCOP112(r1:r2);
    pdCOP1 = pdCOP112(r1:r2);
    pZTL = pZTL12(r1:r2);
    pZG = pZG12(r1:r2);
    mGI = mGI12(r1:r2);
    pcGI = pcGI12(r1:r2);
    pnGI = pnGI12(r1:r2);
    mNOX = mNOX12(r1:r2);
    pNOX = pNOX12(r1:r2);
    mRVE8 = mRVE812(r1:r2);
    pRVE8 = pRVE812(r1:r2);
    TL = [TL12(r1:r2)];
    
elseif q == 0
    load FogelmarkPCB_validation_set2.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pLHY = pLHY12(r1:r2);
    mCCA1 = mCCA112(r1:r2);
    pCCA1 = pCCA112(r1:r2);
    pP = pP12(r1:r2);
    mPRR9 = mPRR912(r1:r2);
    pPRR9 = pPRR912(r1:r2);
    mPRR7 = mPRR712(r1:r2);
    pPRR7 = pPRR712(r1:r2);
    mPRR5 = mPRR512(r1:r2);
    pcPRR5 = pcPRR512(r1:r2);
    pnPRR5 = pnPRR512(r1:r2);
    mTOC1 = mTOC112(r1:r2);
    pcTOC1 = pcTOC112(r1:r2);
    pnTOC1 = pnTOC112(r1:r2);
    mELF4 = mELF412(r1:r2);
    pELF4 = pELF412(r1:r2);
    pdELF4 = pdELF412(r1:r2);
    mELF3 = mELF312(r1:r2);
    pELF3 = pELF312(r1:r2);
    pE34 = pE3412(r1:r2);
    mLUX = mLUX12(r1:r2);
    pLUX = pLUX12(r1:r2);
    pcCOP1 = pcCOP112(r1:r2);
    pnCOP1 = pnCOP112(r1:r2);
    pdCOP1 = pdCOP112(r1:r2);
    pZTL = pZTL12(r1:r2);
    pZG = pZG12(r1:r2);
    mGI = mGI12(r1:r2);
    pcGI = pcGI12(r1:r2);
    pnGI = pnGI12(r1:r2);
    mNOX = mNOX12(r1:r2);
    pNOX = pNOX12(r1:r2);
    mRVE8 = mRVE812(r1:r2);
    pRVE8 = pRVE812(r1:r2);
    TL = [TL12(r1:r2)];
end

%% Model parameter
prmLHY = [0.16544,-2.0558,1.7392,0.16759];
prpLHY = [0.49276,0.64424,0.54488];
prmCCA1 = [0.13445,-1.5602,0.85654,0.50295];
prpCCA1 = [1.075,0.82192,0.015409];
prpP = [0.27588,-0.28229,-0.96463];
prmPRR9 = [1.0913,1.4395,-0.14184,-1.7397,-0.0060951,-0.53981,-1.4908e-05,0.87699,0.20276];
prpPRR9 = [1.0909,0.43031];
prmPRR7 = [1.8273,-0.0023192,-2.2365,-0.18211,-0.45998,-0.00010297,0.48854];
prpPRR7 = [1.0623,0.1153,-0.065596];
prmPRR5 = [0.33454,1.0947,-1.6729,-1.2459,-0.25405,-0.00025037,1.8135];
prpcPRR5 = [0.96356,1.0768,0.52735,1.9788];
prpnPRR5 = [1.3849,0.59687,1.1299];
prmTOC1 = [0.21682,0.011704,-0.76416,-0.01854,-0.053719,-0.0022059,4.0754];
prpcTOC1 = [0.12907,0.88768,0.44348,3.3327];
prpnTOC1 = [2.9835,1.7478,0.24736];
prmELF4 = [0.036253,0.25873,-1.4757,-0.0040069,-0.50844,-0.015968,9.853];
prpELF4 = [0.98303,0.83742];
prpdELF4 = [0.29144,0.34821,1.4952];
prmELF3 = [0.095423,-0.59241,0.66174];
prpELF3 = [0.37726,0.091059,0.96865,0.010166,6.4433,0.0076552];
prpE34 = [1.4329,0.12811,0.012303,0.85755,0.0018745];
prmLUX = [0.98792,0.81993,-0.85584,-0.039984,-0.028823,-0.017031,2.8521];
prpLUX = [0.79267,0.17751];
prpcCOP1 = [0.16956,0.51549,-0.21823];
prpnCOP1 = [0.5644,1.034,0.16717,-22.6595,-0.28771];
prpCOP1d = [0.10426,0.24572,19.5485,-4.586];
prpZTL = [0.31141,1.5723,8.0358,0.20212,0.67972];
prpZG = [7.5757,0.10762,-0.20295,-0.7164];
prmGI = [0.013692,0.42471,-0.0043262,-0.62141,-0.0041443,-0.55875,0.23768];
prpcGI = [1.7779,1.4744,0.21697,0.19815,0.0026174,-0.0002457];
prpnGI = [3.199,1.3817,21.7247,0.51551,4.3588,5.2823];
prmNOX = [0.17311,-0.63975,-0.013368,0.37991];
prpNOX = [0.98412,0.79879];
prmRVE8 = [0.091271,-1.8614,0.33879];
prpRVE8 = [1.2125,0.1753];

linearthetanl = [prmLHY prpLHY prmCCA1 prpCCA1 prpP prmPRR9 prpPRR9 prmPRR7 prpPRR7 prmPRR5 prpcPRR5 prpnPRR5...
    prmTOC1 prpcTOC1 prpnTOC1 prmELF4 prpELF4 prpdELF4 prmELF3 prpELF3 prpE34 prmLUX prpLUX...
    prpcCOP1 prpnCOP1 prpCOP1d prpZTL prpZG prmGI prpcGI prpnGI prmNOX prpNOX prmRVE8 prpRVE8];

theta = linearthetanl;

%% Initial condition (first data point of synthetic data)
C = [0.3609,0.4513,0.6803,0.6719,0.4942,0.3239,0.2153,0.0465,0.0745,0.0746,0.0612,0.0714,0.0374,0.0081,0.0177,0.0093,0.0144,...
    0.0004,0.0934,0.0158,0.0564,1.3161,10.0716,0.2663,0.0147,0.8207,0.1524,0.2005,0.0250,0.0563,0.0050,0.8044,1.4879,1.0153,3.4137];

Cinit = [0.3609,0.4513,0.6803,0.6719,0.4942,0.3239,0.2153,0.0465,0.0745,0.0746,0.0612,0.0714,0.0374,0.0081,0.0177,0.0093,0.0144,...
    0.0004,0.0934,0.0158,0.0564,1.3161,10.0716,0.2663,0.0147,0.8207,0.1524,0.2005,0.0250,0.0563,0.0050,0.8044,1.4879,1.0153,3.4137];

ProteinLevel = [];

for t = 1:length(TL)
    tspan = [t t+1];
    EL = TL(t);
    [T,C] = ode45('KF2014S_ODE',tspan,C(end,:));
    ProteinLevel = [ProteinLevel; C(end,:)];
end
ProteinLevel = [Cinit; ProteinLevel(2:end,:)];

%% Figure plotting
tp = 0:length(TL)-1;

figure(11)
subplot (6,6,1)
plot(tp,mLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,1),'r.-')
title('LHY mRNA')
grid on

subplot (6,6,2)
plot(tp,pLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,2),'r.-')
title('LHY protein')
grid on

subplot (6,6,3)
plot(tp,mCCA1,'b.-')
hold on
plot(tp,ProteinLevel(:,3),'r.-')
title('CCA1 mRNA')
grid on

subplot (6,6,4)
plot(tp,pCCA1,'b.-')
hold on
plot(tp,ProteinLevel(:,4),'r.-')
title('CCA1 protein')
grid on

subplot (6,6,5)
plot(tp,pP,'b.-')
hold on
plot(tp,ProteinLevel(:,5),'r.-')
title('Protein P')
grid on

subplot (6,6,6)
plot(tp,mPRR9,'b.-')
hold on
plot(tp,ProteinLevel(:,6),'r.-')
title('PRR9 mRNA')
grid on

subplot (6,6,7)
plot(tp,pPRR9,'b.-')
hold on
plot(tp,ProteinLevel(:,7),'r.-')
title('PRR9 protein')
grid on

subplot (6,6,8)
plot(tp,mPRR7,'b.-')
hold on
plot(tp,ProteinLevel(:,8),'r.-')
title('PRR7 mRNA')
grid on

subplot (6,6,9)
plot(tp,pPRR7,'b.-')
hold on
plot(tp,ProteinLevel(:,9),'r.-')
title('PRR7 protein')
grid on

subplot (6,6,10)
plot(tp,mPRR5,'b.-')
hold on
plot(tp,ProteinLevel(:,10),'r.-')
title('PRR5 mRNA')
grid on

subplot (6,6,11)
plot(tp,pcPRR5,'b.-')
hold on
plot(tp,ProteinLevel(:,11),'r.-')
title('PRR5 cytoplasmic protein')
grid on

subplot (6,6,12)
plot(tp,pnPRR5,'b.-')
hold on
plot(tp,ProteinLevel(:,12),'r.-')
title('PRR5 nuclear protein')
grid on

subplot (6,6,13)
plot(tp,mTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,13),'r.-')
title('TOC1 mRNA')
grid on

subplot (6,6,14)
plot(tp,pcTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,14),'r.-')
title('TOC1 cytoplasmic protein')
grid on

subplot (6,6,15)
plot(tp,pnTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,15),'r.-')
title('TOC1 nuclear protein')
grid on

subplot (6,6,16)
plot(tp,mELF4,'b.-')
hold on
plot(tp,ProteinLevel(:,16),'r.-')
title('ELF4 mRNA')
grid on

subplot (6,6,17)
plot(tp,pELF4,'b.-')
hold on
plot(tp,ProteinLevel(:,17),'r.-')
title('ELF4 protein')
grid on

subplot (6,6,18)
plot(tp,pdELF4,'b.-')
hold on
plot(tp,ProteinLevel(:,18),'r.-')
title('ELF4 dark protein')
grid on

subplot (6,6,19)
plot(tp,mELF3,'b.-')
hold on
plot(tp,ProteinLevel(:,19),'r.-')
title('ELF3 mRNA')
grid on

subplot (6,6,20)
plot(tp,pELF3,'b.-')
hold on
plot(tp,ProteinLevel(:,20),'r.-')
title('ELF3 protein')
grid on

subplot (6,6,21)
plot(tp,pE34,'b.-')
hold on
plot(tp,ProteinLevel(:,21),'r.-')
title('ELF3/ELF4 complex')
grid on

subplot (6,6,22)
plot(tp,mLUX,'b.-')
hold on
plot(tp,ProteinLevel(:,22),'r.-')
title('LUX mRNA')
grid on

subplot (6,6,23)
plot(tp,pLUX,'b.-')
hold on
plot(tp,ProteinLevel(:,23),'r.-')
title('LUX protein')
grid on

subplot (6,6,24)
plot(tp,pcCOP1,'b.-')
hold on
plot(tp,ProteinLevel(:,24),'r.-')
title('COP1 cytoplasmic protein')
grid on

subplot (6,6,25)
plot(tp,pnCOP1,'b.-')
hold on
plot(tp,ProteinLevel(:,25),'r.-')
title('COP1 nuclear protein')
grid on

subplot (6,6,26)
plot(tp,pdCOP1,'b.-')
hold on
plot(tp,ProteinLevel(:,26),'r.-')
title('COP1 dark protein')
grid on

subplot (6,6,27)
plot(tp,pZTL,'b.-')
hold on
plot(tp,ProteinLevel(:,27),'r.-')
title('ZTL protein')
grid on

subplot (6,6,28)
plot(tp,pZG,'b.-')
hold on
plot(tp,ProteinLevel(:,28),'r.-')
title('ZTL/GI complex')
grid on

subplot (6,6,29)
plot(tp,mGI,'b.-')
hold on
plot(tp,ProteinLevel(:,29),'r.-')
title('GI mRNA')
grid on

subplot (6,6,30)
plot(tp,pcGI,'b.-')
hold on
plot(tp,ProteinLevel(:,30),'r.-')
title('GI cytoplasmic protein')
grid on

subplot (6,6,31)
plot(tp,pnGI,'b.-')
hold on
plot(tp,ProteinLevel(:,31),'r.-')
title('GI nuclear protein')
grid on

subplot (6,6,32)
plot(tp,mNOX,'b.-')
hold on
plot(tp,ProteinLevel(:,32),'r.-')
title('NOX mRNA')
grid on

subplot (6,6,33)
plot(tp,pNOX,'b.-')
hold on
plot(tp,ProteinLevel(:,33),'r.-')
title('NOX protein')
grid on

subplot (6,6,34)
plot(tp,mRVE8,'b.-')
hold on
plot(tp,ProteinLevel(:,34),'r.-')
title('RVE8 mRNA')
grid on

subplot (6,6,35)
plot(tp,pRVE8,'b.-')
hold on
plot(tp,ProteinLevel(:,35),'r.-')
title('RVE8 protein')
grid on
legend('KF2014','KF2014S','Location','Best')