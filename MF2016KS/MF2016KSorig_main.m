clc
clear all
% close all

% MF2016K Pure S-System - Using original S-System modelling framework

global theta EL

% Loading experimental data from Foo et al (2016) Plos Comput. Biol.
% Available for download from
% (https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004748)

q = 1; % For constant light, q = 1, constant dark q = 0;

c1 = 1; c2 = 96;
if q == 1
    load allWTdataLL.mat % Data from 12L:12D -> LL
    TL = [ones(1,12) 0.001*ones(1,12) ones(1,12) 0.001*ones(1,12) ones(1,12) 0.001*ones(1,12) ones(1,12) 0.001*ones(1,12) ones(1,98)];
    c3 = 97; c4 = 194;
elseif q == 0
    load allWTdataDD.mat % Data from 12L:12D -> DD
    TL = [ones(1,12) 0.001*ones(1,12) ones(1,12) 0.001*ones(1,12) ones(1,12) 0.001*ones(1,12) ones(1,12) 0.001*ones(1,12) 0.001*ones(1,105)];
    c3 = 97; c4 = 201;
end

%% Model parameters
prpP = [0.12328,0.84032,0.41903,0.68947];
prmLHY = [0.058801,-0.21583,-0.27051,-0.4991,1.9153];
prpLHY = [0.98384,0.469];
prmPRR9 = [0.65516,0.73463,0.030917,1.3117,2.0981];
prpPRR9 = [1.3954,0.43927];
prmPRR7 = [0.0036286,-2.2477,-0.055745,0.24954];
prpPRR7 = [0.23322,0.21307];
prmPRR5 = [0.00072912,-1.6468e-05,-2.9009,0.25428];
prpPRR5 = [0.51669,0.40782];
prmTOC1 = [0.034123,-1.6459,-0.0021816,1.588];
prpTOC1 = [0.38023,0.25083];
prpEC = [0.91532,0.56083];
prmRVE8 = [0.056025,-0.81231,1.0326];
prpRVE8 = [0.34231,0.17998];
prmELF3 = [0.058804,-0.70406,0.25942];
prpELF3 = [1.8694,2.1363];
prmELF4 = [0.0076198,-1.5118,-0.49478,0.83136];
prpELF4 = [1.2916,0.68801];
prmLUX = [0.0015581,-2.1824,-0.80925,0.86232];
prpLUX = [1.1027,0.58588];
prmGI = [0.019243,-0.74026,-0.58389,-0.43611,0.62224];
prpGI = [0.14839,0.49723,2.1771,1.8459,1.3754];
prpCOP1 = [0.10127,1.2943,1.5038,1.3948];
prpZTL = [1.9545,0.012697,1.6218,1.2789];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

PureProteinLevel = [];

for t = 1:length(TL)
    tspan = [t t+1];
    EL = TL(t);
    [T,C] = ode45('MF2016KSorig_ODE',tspan,C(end,:));
    PureProteinLevel = [PureProteinLevel; C(end,:)];
end
PureProteinLevel = [Cinit; PureProteinLevel(2:end,:)];

%% Figure plotting
tp = 0:length(TL)-1;

figure(1)
subplot (6,4,1)
hold on
plot(tp,PureProteinLevel(:,1),'g.-')
title('Protein P')

subplot (6,4,2)
hold on
plot(tp,[PureProteinLevel(c1:c2,2)' PureProteinLevel(c3:c4,2)'],'g.-')
title('LHY/CCA1 mRNA')

subplot (6,4,3)
hold on
plot(tp,[PureProteinLevel(c1:c2,3)' PureProteinLevel(c3:c4,3)'] ,'g.-')
title('LHY/CCA1 protein')

subplot (6,4,4)
hold on
plot(tp,[PureProteinLevel(c1:c2,4)' PureProteinLevel(c3:c4,4)'],'g.-')
title('PRR9 mRNA')

subplot (6,4,5)
hold on
plot(tp,[PureProteinLevel(c1:c2,5)' PureProteinLevel(c3:c4,5)'],'g.-')
title('PRR9 protein')

subplot (6,4,6)
hold on
plot(tp,[PureProteinLevel(c1:c2,6)' PureProteinLevel(c3:c4,6)'],'g.-')
title('PRR7 mRNA')

subplot (6,4,7)
hold on
plot(tp,[PureProteinLevel(c1:c2,7)' PureProteinLevel(c3:c4,7)'],'g.-')
title('PRR7 protein')

subplot (6,4,8)
hold on
plot(tp,[PureProteinLevel(c1:c2,8)' PureProteinLevel(c3:c4,8)'],'g.-')
title('PRR5 mRNA')

subplot (6,4,9)
hold on
plot(tp,[PureProteinLevel(c1:c2,9)' PureProteinLevel(c3:c4,9)'],'g.-')
title('PRR5 protein')

subplot (6,4,10)
hold on
plot(tp,[PureProteinLevel(c1:c2,10)' PureProteinLevel(c3:c4,10)'],'g.-')
title('TOC1 mRNA')

subplot (6,4,11)
hold on
plot(tp,[PureProteinLevel(c1:c2,11)' PureProteinLevel(c3:c4,11)'],'g.-')
title('TOC1 protein')

subplot (6,4,12)
hold on
plot(tp,[PureProteinLevel(c1:c2,12)' PureProteinLevel(c3:c4,12)'],'g.-')
title('EC complex')

subplot (6,4,13)
hold on
plot(tp,[PureProteinLevel(c1:c2,13)' PureProteinLevel(c3:c4,13)'],'g.-')
title('RVE8 mRNA')

subplot (6,4,14)
hold on
plot(tp,[PureProteinLevel(c1:c2,14)' PureProteinLevel(c3:c4,14)'],'g.-')
title('RVE8 protein')

subplot (6,4,15)
hold on
plot(tp,[PureProteinLevel(c1:c2,15)' PureProteinLevel(c3:c4,15)'],'g.-')
title('ELF3 mRNA')

subplot (6,4,16)
hold on
plot(tp,[PureProteinLevel(c1:c2,16)' PureProteinLevel(c3:c4,16)'],'g.-')
title('ELF3 protein')

subplot (6,4,17)
hold on
plot(tp,[PureProteinLevel(c1:c2,17)' PureProteinLevel(c3:c4,17)'],'g.-')
title('ELF4 mRNA')

subplot (6,4,18)
hold on
plot(tp,[PureProteinLevel(c1:c2,18)' PureProteinLevel(c3:c4,18)'],'g.-')
title('ELF4 protein')

subplot (6,4,19)
hold on
plot(tp,[PureProteinLevel(c1:c2,19)' PureProteinLevel(c3:c4,19)'],'g.-')
title('LUX mRNA')

subplot (6,4,20)
hold on
plot(tp,[PureProteinLevel(c1:c2,20)' PureProteinLevel(c3:c4,20)'],'g.-')
title('LUX protein')

subplot (6,4,21)
hold on
plot(tp,[PureProteinLevel(c1:c2,21)' PureProteinLevel(c3:c4,21)'],'g.-')
title('GI mRNA')

subplot (6,4,22)
hold on
plot(tp,[PureProteinLevel(c1:c2,22)' PureProteinLevel(c3:c4,22)'],'g.-')
title('GI protein')

subplot (6,4,23)
hold on
plot(tp,[PureProteinLevel(c1:c2,23)' PureProteinLevel(c3:c4,23)'],'g.-')
title('COP1 protein')

subplot (6,4,24)
hold on
plot(tp,[PureProteinLevel(c1:c2,24)' PureProteinLevel(c3:c4,24)'],'g.-')
title('ZTL protein')
legend('Exp.','MF2016K','MF2016KS','MF2016KSori','Location','Best')