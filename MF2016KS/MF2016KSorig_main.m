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
prpP = [0.015782,-0.45883,0.52739];
prmLHY = [0.08581,-1.7661,0.54502];
prpLHY = [0.96879,0.71864];
prmPRR9 = [0.7879,2.402,0.31039,0.22138];
prpPRR9 = [1.3885,1.0875];
prmPRR7 = [0.0032414,-2.0744,-0.058049,0.21285];
prpPRR7 = [0.24776,0.18436];
prmPRR5 = [0.00083628,-1.6391e-05,-2.4634,0.21619];
prpPRR5 = [0.45581,0.37398];
prmTOC1 = [0.037215,-1.4952,-0.0024853,1.7447];
prpTOC1 = [0.388,0.28055];
prpEC = [0.94284,0.52923];
prmRVE8 = [0.055984,-0.90104,0.89346];
prpRVE8 = [0.31291,0.17179];
prmELF3 = [0.052787,-0.69938,0.26526];
prpELF3 = [1.8154,2.4039];
prmELF4 = [0.0074574,-1.3269,-0.49865,0.7708];
prpELF4 = [1.0724,0.6629];
prmLUX = [0.0018256,-1.9789,-0.78952,0.87233];
prpLUX = [0.94359,0.55719];
prmGI = [0.020541,-0.67404,-0.66998,-0.45225,0.55727];
prpGI = [20.0118,0.51235,4.2858];
prpCOP1 = [0.60686,-0.24679,3.7261];
prpZTL = [0.071243,0.021746];
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