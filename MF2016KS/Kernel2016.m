clc
clear all
% close all

% NOTE: This MATLAB file is downloaded and modified (for plotting purposes) from Foo et al (2016) Plos Comput. Biol.
% Available for download from (https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004748)

global L theta

%% Defining Data Range
Tsp = 10;
T_12 = [ones(1,120) zeros(1,120)]; T_12 = repmat(T_12,1,4); T_12 = T_12(1:Tsp:end);
T_LL = ones(1,244); T_LL = repmat(T_LL,1,4); T_LL = T_LL(1:Tsp:end);
T_DD = zeros(1,261); T_DD = repmat(T_DD,1,4); T_DD = T_DD(1:Tsp:end);


r1 = 1; r2 = 96;        % Range of exp. data for 12L12D

q = 1;
if q == 1
    load allWTdataLL.mat % Data from 12L:12D -> LL
    Tlight = [T_12 T_LL];
    r3 = 289; r4 = 386;     % Range of exp. data for constant light
elseif q == 0
    load allWTdataDD.mat % Data from 12L:12D -> DD
    Tlight = [T_12 T_DD];
    r3 = 387; r4 = 491;   % Range of exp. data for constant dark
end

%% Model Parameter
% New Minimal Unperturbed Model
nonlineartheta = [-0.43301,-0.4949,0.4358,...                       %plight
    1.9601,0.7412,0.3821,-2.7804,...                                % mLHY
    0.83604,-0.64719,...                                            % pLHY
    0.73369,6.4976e-05,0.75976,1.3352,-0.59706,...                  % mPRR9
    0.50077,-0.22337,...                                            % pPRR9
    0.0099479,0.034706,0.87726,-0.23934,...                         % mPRR7
    0.23744,-0.18571,...                                            % pPRR7
    0.026728,0.13201,0.031588,-40.9795,...                          % mPRR5
    4.0753,-2.5872,...                                              % pPRR5
    0.01501,0.036926,0.011307,-12.2192,...                          % mTOC1
    0.40049,-0.31171,...                                            % pTOC1
    0.80816,-0.37854,...                                            % pEC
    2.2417,1.4074,-1.5159,...                                       % mRVE8
    0.32848,-0.14877,...                                            % pRVE8
    0.014607,0.23392,-0.27265,...                                   % mELF3
    14.0123,-17.3569,...                                            % pELF3
    0.014384,0.032117,0.051737,-11.007,...                          % mELF4
    0.67365,-0.39718,...                                            % pELF4
    0.028907,0.01727,0.034063,-26.4166,...                          % mLUX
    2.461,-1.4794,...                                               % pLUX
    0.0002445,0.072434,0.11811,0.456,-0.58448,...                   % mGI
    0.40246,-0.78572,-0.020811,...                                  % pGI
    -0.80938,-0.8102,0.91424,...                                    % pCOP1
    2.3354,1.275,1.5983,-0.44539,0.027925,...                       % pZTL
    0.52644,1.3764,11.6684];%,...                                   % Homolog Scale

theta = nonlineartheta;
GeneProteinLevelFull = [];

%% Unperturbed initial condition

C = [pP(1)  mLHY(1) pLHY(1) mPRR9(1) pPRR9(1) mPRR7(1) pPRR7(1) mPRR5(1) pPRR5(1)...
    mTOC1(1) pTOC1(1) pEC(1) mRVE8(1) pRVE8(1) mELF3(1) pELF3(1) mELF4(1) pELF4(1)...
    mLUX(1) pLUX(1) mGI(1) pGI(1) pCOP1(1) pZTL(1)];

Cinit = [pP(1)  mLHY(1) pLHY(1) mPRR9(1) pPRR9(1) mPRR7(1) pPRR7(1) mPRR5(1) pPRR5(1)...
    mTOC1(1) pTOC1(1) pEC(1) mRVE8(1) pRVE8(1) mELF3(1) pELF3(1) mELF4(1) pELF4(1)...
    mLUX(1) pLUX(1) mGI(1) pGI(1) pCOP1(1) pZTL(1)];

for t = 1:length(Tlight)
    tspan = [t t+1];
    L = Tlight(t);
    [T,C] = ode23('Kernel2016_ODE',tspan,C(end,:));
    GeneProteinLevelFull = [GeneProteinLevelFull; C(end,:)];
end
GeneProteinLevelFull = [Cinit; GeneProteinLevelFull(2:end,:)];

%% Plotting

tp = 0:length(Tlight)-1;

figure(1)
subplot (6,4,1)
plot(tp,pP,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,1),'r.-')
hold on
title('Protein P')
grid on

subplot (6,4,2)
plot(tp,mLHY,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,2),'r.-')
hold on
title('LHY/CCA1 mRNA')
grid on

subplot (6,4,3)
plot(tp,pLHY,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,3),'r.-')
hold on
title('LHY/CCA1 protein')
grid on

subplot (6,4,4)
plot(tp,mPRR9,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,4),'r.-')
hold on
title('PRR9 mRNA')
grid on

subplot (6,4,5)
plot(tp,pPRR9,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,5),'r.-')
hold on
title('PRR9 protein')
grid on

subplot (6,4,6)
plot(tp,mPRR7,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,6),'r.-')
hold on
title('PRR7 mRNA')
grid on

subplot (6,4,7)
plot(tp,pPRR7,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,7),'r.-')
hold on
title('PRR7 protein')
grid on

subplot (6,4,8)
plot(tp,mPRR5,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,8),'r.-')
hold on
title('PRR5 mRNA')
grid on

subplot (6,4,9)
plot(tp,pPRR5,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,9),'r.-')
hold on
title('PRR5 protein')
grid on

subplot (6,4,10)
plot(tp,mTOC1,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,10),'r.-')
hold on
title('TOC1 mRNA')
grid on

subplot (6,4,11)
plot(tp,pTOC1,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,11),'r.-')
hold on
title('TOC1 protein')
grid on

subplot (6,4,12)
plot(tp,pEC,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,12),'r.-')
hold on
title('EC complex')
grid on

subplot (6,4,13)
plot(tp,mRVE8,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,13),'r.-')
hold on
title('RVE8 mRNA')
grid on

subplot (6,4,14)
plot(tp,pRVE8,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,14),'r.-')
hold on
title('RVE8 protein')
grid on

subplot (6,4,15)
plot(tp,mELF3,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,15),'r.-')
hold on
title('ELF3 mRNA')
grid on

subplot (6,4,16)
plot(tp,pELF3,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,16),'r.-')
hold on
title('ELF3 protein')
grid on

subplot (6,4,17)
plot(tp,mELF4,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,17),'r.-')
hold on
title('ELF4 mRNA')
grid on

subplot (6,4,18)
plot(tp,pELF4,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,18),'r.-')
hold on
title('ELF4 protein')
grid on

subplot (6,4,19)
plot(tp,mLUX,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,19),'r.-')
hold on
title('LUX mRNA')
grid on

subplot (6,4,20)
plot(tp,pLUX,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,20),'r.-')
hold on
title('LUX protein')
grid on

subplot (6,4,21)
plot(tp,mGI,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,21),'r.-')
hold on
title('GI mRNA')
grid on

subplot (6,4,22)
plot(tp,pGI,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,22),'r.-')
hold on
title('GI protein')
grid on

subplot (6,4,23)
plot(tp,pCOP1,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,23),'r.-')
hold on
title('COP1 protein')
grid on

subplot (6,4,24)
plot(tp,pZTL,'b.-')
hold on
plot(tp,GeneProteinLevelFull(:,24),'r.-')
hold on
title('ZTL protein')
grid on


MF2016KS_main % Execute MF2016K extended S-System model to combine figure

MF2016KSorig_main % Execute MF2016K original S-System model to combine figure
