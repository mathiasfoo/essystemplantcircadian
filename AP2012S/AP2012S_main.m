clc
clear all
close all

% AP2012S
global theta EL


q = 1; % For constant light, q=1, constant dark, q=0
if q == 1
    load PokhilkoMSB_training.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pLHY = pLHY12(r1:r2);
    pLHYmod = pLHYmod12(r1:r2);
    pP = pP12(r1:r2);
    mPRR9 = mPRR912(r1:r2);
    pPRR9 = pPRR912(r1:r2);
    mPRR7 = mPRR712(r1:r2);
    pPRR7 = pPRR712(r1:r2);
    mNI = mNI12(r1:r2);
    pNI = pNI12(r1:r2);
    mTOC1 = mTOC112(r1:r2);
    pTOC1 = pTOC112(r1:r2);
    mELF4 = mELF412(r1:r2);
    pELF4 = pELF412(r1:r2);
    mELF3 = mELF312(r1:r2);
    pELF3c = pELF3c12(r1:r2);
    pELF3n = pELF3n12(r1:r2);
    mLUX = mLUX12(r1:r2);
    pLUX = pLUX12(r1:r2);
    pCOP1c = pCOP1c12(r1:r2);
    pCOP1n = pCOP1n12(r1:r2);
    pCOP1d = pCOP1d12(r1:r2);
    pEG = pEG12(r1:r2);
    pEC = pEC12(r1:r2);
    pZTL = pZTL12(r1:r2);
    pZG = pZG12(r1:r2);
    mGI = mGI12(r1:r2);
    pGI = pGI12(r1:r2);
    pHY5 = pHY512(r1:r2);
    pHFR1 = pHFR112(r1:r2);
    TL = TL12(r1:r2);
    
elseif q == 0
    load PokhilkoMSB_validation.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pLHY = pLHY12(r1:r2);
    pLHYmod = pLHYmod12(r1:r2);
    pP = pP12(r1:r2);
    mPRR9 = mPRR912(r1:r2);
    pPRR9 = pPRR912(r1:r2);
    mPRR7 = mPRR712(r1:r2);
    pPRR7 = pPRR712(r1:r2);
    mNI = mNI12(r1:r2);
    pNI = pNI12(r1:r2);
    mTOC1 = mTOC112(r1:r2);
    pTOC1 = pTOC112(r1:r2);
    mELF4 = mELF412(r1:r2);
    pELF4 = pELF412(r1:r2);
    mELF3 = mELF312(r1:r2);
    pELF3c = pELF3c12(r1:r2);
    pELF3n = pELF3n12(r1:r2);
    mLUX = mLUX12(r1:r2);
    pLUX = pLUX12(r1:r2);
    pCOP1c = pCOP1c12(r1:r2);
    pCOP1n = pCOP1n12(r1:r2);
    pCOP1d = pCOP1d12(r1:r2);
    pEG = pEG12(r1:r2);
    pEC = pEC12(r1:r2);
    pZTL = pZTL12(r1:r2);
    pZG = pZG12(r1:r2);
    mGI = mGI12(r1:r2);
    pGI = pGI12(r1:r2);
    pHY5 = pHY512(r1:r2);
    pHFR1 = pHFR112(r1:r2);
    TL = TL12(r1:r2);
end
%% Model parameters
prmLHY = [0.028984,-1.9737,0.20607,0.59197,-0.21762];
prpLHY = [0.29468,0.29247,0.14558];
prpLHYmod = [0.13049,1.8637,0.18633];
prpP = [0.25207,-0.2893,-0.90379];
prmPRR9 = [0.055885,0.587,-0.28685,1.306,3.354];
prpPRR9 = [0.52346,0.26911,0.1829];
prmPRR7 = [0.71571,1.5493,0.020724,0.35294];
prpPRR7 = [0.7861,0.68755,-0.76475];
prmNI = [0.55414,0.014716,1.3107,0.62891];
prpNI = [0.54328,0.50707,-0.096964];
prmTOC1 = [0.00023655,-1.4163,-0.68516,0.37013];
prpTOC1 = [0.47828,0.40273,1.1809,0.32298,-2.8598,-0.72891];
prmELF4 = [0.0038058,-0.9857,-0.64472,1.121];
prpELF4 = [0.38013,0.2722,-0.98198,9.7979];
prmELF3 = [0.07081,-0.55014,0.47452];
prpELF3c = [0.6022,1.5735,0.79938,0.38052,0.85008];
prpELF3n = [0.8086,0.81615,0.031903,27.037,1.3398,3.2021,7.7305,1.1152];
prmLUX = [0.0028972,-0.86982,-0.57394,0.88663];
prpLUX = [0.53976,0.1984,0.73637];
prpCOP1c = [0.23068,0.70609,-0.28733];
prpCOP1n = [0.60989,0.99812,0.1988,-19.7551,-0.28522];
prpCOP1d = [0.099885,0.30031,19.1516,-4.6314];
prpEG = [5.0022,3.9124,1.2039,-0.10684];
prpEC = [1.1125,0.14195,0.0058894,1.0111,-5.5232];
prpZTL = [0.13915,0.6014,-3.4769,0.09204];
prpZG = [0.080547,3.4317,-0.091798];
prmGI = [0.013011,-0.89842,-0.73189,3.8473,2.184];
prpGI = [0.45348,1.3219,4.3258,-3.8148,-0.12045];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

linearthetanl = [prmLHY prpLHY prpLHYmod prpP prmPRR9 prpPRR9 prmPRR7 prpPRR7 prmNI prpNI...
    prmTOC1 prpTOC1 prmELF4 prpELF4 prmELF3 prpELF3c prpELF3n prmLUX prpLUX...
    prpCOP1c prpCOP1n prpCOP1d prpEG prpEC prpZTL prpZG prmGI prpGI];

theta = linearthetanl;


%% Initial condition (first data point of synthetic data)
C = [0.7963,0.4584,0.0559,0.3578,1.0400,0.5348,0.3622,0.2080,0.0435,0.0346,0.1278,0.0839...
    0.1930,0.2358,0.3442,0.1553,0.0334,0.0929,0.3078,0.2663,0.0191,0.8171,0.0136,0.0179...
    0.2128,0.1202,0.4598,0.0684];

Cinit = [0.7963,0.4584,0.0559,0.3578,1.0400,0.5348,0.3622,0.2080,0.0435,0.0346,0.1278,0.0839...
    0.1930,0.2358,0.3442,0.1553,0.0334,0.0929,0.3078,0.2663,0.0191,0.8171,0.0136,0.0179...
    0.2128,0.1202,0.4598,0.0684];

ProteinLevel = [];

for t = 1:length(TL)
    tspan = [t t+1];
    EL = TL(t);
    [T,C] = ode45('AP2012S_ODE',tspan,C(end,:));
    ProteinLevel = [ProteinLevel; C(end,:)];
end
ProteinLevel = [Cinit; ProteinLevel(2:end,:)];

%% Figure plotting
tp = 0:length(TL)-1;

figure(11)
subplot (6,5,1)
plot(tp,mLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,1),'r.-')
title('LHY/CCA1 mRNA')
grid on

subplot (6,5,2)
plot(tp,pLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,2),'r.-')
title('LHY/CCA1 protein')
grid on

subplot (6,5,3)
plot(tp,pLHYmod,'b.-')
hold on
plot(tp,ProteinLevel(:,3),'r.-')
title('LHY/CCA1 modified protein')
grid on

subplot (6,5,4)
plot(tp,pP,'b.-')
hold on
plot(tp,ProteinLevel(:,4),'r.-')
title('Protein P')
grid on

subplot (6,5,5)
plot(tp,mPRR9,'b.-')
hold on
plot(tp,ProteinLevel(:,5),'r.-')
title('PRR9 mRNA')
grid on

subplot (6,5,6)
plot(tp,pPRR9,'b.-')
hold on
plot(tp,ProteinLevel(:,6),'r.-')
title('PRR9 protein')
grid on

subplot (6,5,7)
plot(tp,mPRR7,'b.-')
hold on
plot(tp,ProteinLevel(:,7),'r.-')
title('PRR7 mRNA')
grid on

subplot (6,5,8)
plot(tp,pPRR7,'b.-')
hold on
plot(tp,ProteinLevel(:,8),'r.-')
title('PRR7 protein')
grid on

subplot (6,5,9)
plot(tp,mNI,'b.-')
hold on
plot(tp,ProteinLevel(:,9),'r.-')
title('NI mRNA')
grid on

subplot (6,5,10)
plot(tp,pNI,'b.-')
hold on
plot(tp,ProteinLevel(:,10),'r.-')
title('NI protein')
grid on

subplot (6,5,11)
plot(tp,mTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,11),'r.-')
title('TOC1 mRNA')
grid on

subplot (6,5,12)
plot(tp,pTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,12),'r.-')
title('TOC1 protein')
grid on

subplot (6,5,13)
plot(tp,mELF4,'b.-')
hold on
plot(tp,ProteinLevel(:,13),'r.-')
title('ELF4 mRNA')
grid on

subplot (6,5,14)
plot(tp,pELF4,'b.-')
hold on
plot(tp,ProteinLevel(:,14),'r.-')
title('ELF4 protein')
grid on

subplot (6,5,15)
plot(tp,mELF3,'b.-')
hold on
plot(tp,ProteinLevel(:,15),'r.-')
title('ELF3 mRNA')
grid on

subplot (6,5,16)
plot(tp,pELF3c,'b.-')
hold on
plot(tp,ProteinLevel(:,16),'r.-')
title('ELF3 cytoplasmic protein')
grid on

subplot (6,5,17)
plot(tp,pELF3n,'b.-')
hold on
plot(tp,ProteinLevel(:,17),'r.-')
title('ELF3 nuclear protein')
grid on

subplot (6,5,18)
plot(tp,mLUX,'b.-')
hold on
plot(tp,ProteinLevel(:,18),'r.-')
title('LUX mRNA')
grid on

subplot (6,5,19)
plot(tp,pLUX,'b.-')
hold on
plot(tp,ProteinLevel(:,19),'r.-')
title('LUX protein')
grid on

subplot (6,5,20)
plot(tp,pCOP1c,'b.-')
hold on
plot(tp,ProteinLevel(:,20),'r.-')
title('COP1 cytoplasmic protein')
grid on

subplot (6,5,21)
plot(tp,pCOP1n,'b.-')
hold on
plot(tp,ProteinLevel(:,21),'r.-')
title('COP1 nuclear protein')
grid on

subplot (6,5,22)
plot(tp,pCOP1d,'b.-')
hold on
plot(tp,ProteinLevel(:,22),'r.-')
title('COP1 dark protein')
grid on

subplot (6,5,23)
plot(tp,pEG,'b.-')
hold on
plot(tp,ProteinLevel(:,23),'r.-')
title('EG complex')
grid on

subplot (6,5,24)
plot(tp,pEC,'b.-')
hold on
plot(tp,ProteinLevel(:,24),'r.-')
title('EC comlex')
grid on

subplot (6,5,25)
plot(tp,pZTL,'b.-')
hold on
plot(tp,ProteinLevel(:,25),'r.-')
title('ZTL protein')
grid on

subplot (6,5,26)
plot(tp,pZG,'b.-')
hold on
plot(tp,ProteinLevel(:,26),'r.-')
title('ZG complex')
grid on

subplot (6,5,27)
plot(tp,mGI,'b.-')
hold on
plot(tp,ProteinLevel(:,27),'r.-')
title('GI mRNA')
grid on

subplot (6,5,28)
plot(tp,pGI,'b.-')
hold on
plot(tp,ProteinLevel(:,28),'r.-')
title('GI protein')
grid on
legend('AP2012','AP2012S','Location','Best')

