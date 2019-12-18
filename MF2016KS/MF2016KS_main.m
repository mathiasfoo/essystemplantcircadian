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
prpP = [0.26552,0.30933,-0.2585];
prmLHY = [0.044774,-2.3152,0.43135];
prpLHY = [0.91121,0.56596];
prmPRR9 = [0.17802,2.4323,0.25015,2.9838e-05];
prpPRR9 = [1.5339,0.5711];
prmPRR7 = [0.012619,-1.0164,-0.20046,0.30018];
prpPRR7 = [0.26797,0.20473];
prmPRR5 = [0.00557,-0.00017869,-1.3506,0.40974];
prpPRR5 = [0.54245,0.28647];
prmTOC1 = [0.015772,-1.4978,-0.0035676,1.0041];
prpTOC1 = [0.53515,0.36928];
prpEC = [0.7582,0.31674];
prmRVE8 = [0.070893,-0.89262,1.0452];
prpRVE8 = [0.15676,0.092973];
prmELF3 = [0.1438,-0.32918,0.39371];
prpELF3 = [3.1255,3.5977];
prmELF4 = [2.1919,-0.5002,-0.13695,17.8622];
prpELF4 = [0.62456,0.39792];
prmLUX = [0.0033442,-1.7339,-0.75591,1.0217];
prpLUX = [1.1968,0.73119];
prmGI = [0.0025231,-0.40755,-1.2183,-0.53464,0.13651];
prpGI = [0.16668,0.046246,0.16598];
prpCOP1 = [0.87588,0.90156,-0.77621];
prpZTL = [0.89411,1.9106,-1.2984,1.0077,1.0119];

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
