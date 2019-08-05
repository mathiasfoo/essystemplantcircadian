clc
clear all
% close all

% MF2016KS
global theta EL

% Loading experimental data from Foo et al (2016) Plos Comput. Biol.
% Available for download from
% (https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004748)

q = 1; % For constant light, q = 1, constant dark q = 0;

c1 = 1; c2 = 96;
if q == 1
    load allWTdataLL.mat % Data from 12L:12D -> LL
    TL = [ones(1,12) zeros(1,12) ones(1,12) zeros(1,12) ones(1,12) zeros(1,12) ones(1,12) zeros(1,12) ones(1,98)];
    c3 = 97; c4 = 194;
elseif q == 0
    load allWTdataDD.mat % Data from 12L:12D -> DD
    TL = [ones(1,12) zeros(1,12) ones(1,12) zeros(1,12) ones(1,12) zeros(1,12) ones(1,12) zeros(1,12) zeros(1,105)];
    c3 = 97; c4 = 201;
end

%% Model parameter
prpP = [0.26665,0.30894,-0.25907];
prmLHY = [0.045076,-2.3195,0.43125];
prpLHY = [0.90336,0.56609];
prmPRR9 = [0.17751,2.4292,0.25271,2.9796e-05];
prpPRR9 = [1.5325,0.57199];
prmPRR7 = [0.012587,-1.016,-0.20077,0.30016];
prpPRR7 = [0.26792,0.20489];
prmPRR5 = [0.0055421,-0.00017879,-1.3451,0.41002];
prpPRR5 = [0.53946,0.28609];
prmTOC1 = [0.015803,-1.4989,-0.0035808,1.0032];
prpTOC1 = [0.53622,0.37013];
prpEC = [0.9523,0.31455];
prmRVE8 = [0.071288,-0.89562,1.0485];
prpRVE8 = [0.15674,0.092985];
prmELF3 = [0.1431,-0.32477,0.3957];
prpELF3 = [3.1152,3.6296];
prmELF4 = [1.7651,-0.49829,-0.13774,17.7748];
prpELF4 = [0.62836,0.39627];
prmLUX = [0.0033376,-1.7393,-0.74926,1.0215];
prpLUX = [1.193,0.7305];
prmGI = [0.0025493,-0.41145,-1.2238,-0.53789,0.1348];
prpGI = [0.16452,0.047189,0.16483];
prpCOP1 = [0.88147,0.9123,-0.77032];
prpZTL = [0.86711,1.9101,-1.2816];

linearthetanl = [prpP prmLHY prpLHY prmPRR9 prpPRR9 prmPRR7 prpPRR7 prmPRR5 prpPRR5...
    prmTOC1 prpTOC1 prpEC prmRVE8 prpRVE8 prmELF3 prpELF3 prmELF4 prpELF4 prmLUX prpLUX...
    prmGI prpGI prpCOP1 prpZTL];

theta = linearthetanl;

%% Initial condition (first data point of experimental data)
C = [pP(1)  mLHY(1) pLHY(1) mPRR9(1) pPRR9(1) mPRR7(1) pPRR7(1) mPRR5(1) pPRR5(1)...
    mTOC1(1) pTOC1(1) pEC(1) mRVE8(1) pRVE8(1) mELF3(1) pELF3(1) mELF4(1) pELF4(1)...
    mLUX(1) pLUX(1) mGI(1) pGI(1) pCOP1(1) pZTL(1)];

Cinit = [pP(1)  mLHY(1) pLHY(1) mPRR9(1) pPRR9(1) mPRR7(1) pPRR7(1) mPRR5(1) pPRR5(1)...
    mTOC1(1) pTOC1(1) pEC(1) mRVE8(1) pRVE8(1) mELF3(1) pELF3(1) mELF4(1) pELF4(1)...
    mLUX(1) pLUX(1) mGI(1) pGI(1) pCOP1(1) pZTL(1)];

ProteinLevel = [];

for t = 1:length(TL)
    tspan = [t t+1];
    EL = TL(t);
    [T,C] = ode45('MF2016KS_ODE',tspan,C(end,:));
    ProteinLevel = [ProteinLevel; C(end,:)];
end
ProteinLevel = [Cinit; ProteinLevel(2:end,:)];


%% Figure plotting
tp = 0:length(TL)-1;

figure(1)
subplot (6,4,1)
hold on
plot(tp,ProteinLevel(:,1),'k.-')
title('Protein P')

subplot (6,4,2)
hold on
plot(tp,[ProteinLevel(c1:c2,2)' ProteinLevel(c3:c4,2)'],'k.-')
title('LHY/CCA1 mRNA')

subplot (6,4,3)
hold on
plot(tp,[ProteinLevel(c1:c2,3)' ProteinLevel(c3:c4,3)'] ,'k.-')
title('LHY/CCA1 protein')

subplot (6,4,4)
hold on
plot(tp,[ProteinLevel(c1:c2,4)' ProteinLevel(c3:c4,4)'],'k.-')
title('PRR9 mRNA')

subplot (6,4,5)
hold on
plot(tp,[ProteinLevel(c1:c2,5)' ProteinLevel(c3:c4,5)'],'k.-')
title('PRR9 protein')

subplot (6,4,6)
hold on
plot(tp,[ProteinLevel(c1:c2,6)' ProteinLevel(c3:c4,6)'],'k.-')
title('PRR7 mRNA')

subplot (6,4,7)
hold on
plot(tp,[ProteinLevel(c1:c2,7)' ProteinLevel(c3:c4,7)'],'k.-')
title('PRR7 protein')

subplot (6,4,8)
hold on
plot(tp,[ProteinLevel(c1:c2,8)' ProteinLevel(c3:c4,8)'],'k.-')
title('PRR5 mRNA')

subplot (6,4,9)
hold on
plot(tp,[ProteinLevel(c1:c2,9)' ProteinLevel(c3:c4,9)'],'k.-')
title('PRR5 protein')

subplot (6,4,10)
hold on
plot(tp,[ProteinLevel(c1:c2,10)' ProteinLevel(c3:c4,10)'],'k.-')
title('TOC1 mRNA')

subplot (6,4,11)
hold on
plot(tp,[ProteinLevel(c1:c2,11)' ProteinLevel(c3:c4,11)'],'k.-')
title('TOC1 protein')

subplot (6,4,12)
hold on
plot(tp,[ProteinLevel(c1:c2,12)' ProteinLevel(c3:c4,12)'],'k.-')
title('EC complex')

subplot (6,4,13)
hold on
plot(tp,[ProteinLevel(c1:c2,13)' ProteinLevel(c3:c4,13)'],'k.-')
title('RVE8 mRNA')

subplot (6,4,14)
hold on
plot(tp,[ProteinLevel(c1:c2,14)' ProteinLevel(c3:c4,14)'],'k.-')
title('RVE8 protein')

subplot (6,4,15)
hold on
plot(tp,[ProteinLevel(c1:c2,15)' ProteinLevel(c3:c4,15)'],'k.-')
title('ELF3 mRNA')

subplot (6,4,16)
hold on
plot(tp,[ProteinLevel(c1:c2,16)' ProteinLevel(c3:c4,16)'],'k.-')
title('ELF3 protein')

subplot (6,4,17)
hold on
plot(tp,[ProteinLevel(c1:c2,17)' ProteinLevel(c3:c4,17)'],'k.-')
title('ELF4 mRNA')

subplot (6,4,18)
hold on
plot(tp,[ProteinLevel(c1:c2,18)' ProteinLevel(c3:c4,18)'],'k.-')
title('ELF4 protein')

subplot (6,4,19)
hold on
plot(tp,[ProteinLevel(c1:c2,19)' ProteinLevel(c3:c4,19)'],'k.-')
title('LUX mRNA')

subplot (6,4,20)
hold on
plot(tp,[ProteinLevel(c1:c2,20)' ProteinLevel(c3:c4,20)'],'k.-')
title('LUX protein')

subplot (6,4,21)
hold on
plot(tp,[ProteinLevel(c1:c2,21)' ProteinLevel(c3:c4,21)'],'k.-')
title('GI mRNA')

subplot (6,4,22)
hold on
plot(tp,[ProteinLevel(c1:c2,22)' ProteinLevel(c3:c4,22)'],'k.-')
title('GI protein')

subplot (6,4,23)
hold on
plot(tp,[ProteinLevel(c1:c2,23)' ProteinLevel(c3:c4,23)'],'k.-')
title('COP1 protein')

subplot (6,4,24)
hold on
plot(tp,[ProteinLevel(c1:c2,24)' ProteinLevel(c3:c4,24)'],'k.-')
title('ZTL protein')
