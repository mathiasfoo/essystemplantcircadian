function dC = MF2016KSorig_ODE(t,C)


global theta EL 

dC = zeros(24,1);

%% ODE
% pP
dC(1) = theta(1)*EL^(theta(2)) - theta(3)*C(1);

% mLHY
dC(2) = theta(4)*(C(5)+C(7)+C(9))^(theta(5)) - theta(6)*C(2); 

% pLHY
dC(3) = theta(7)*C(2) - theta(8)*C(3); 

% mPRR9
dC(4) = theta(9)*C(3)^(theta(10))*C(1)^(theta(11)) - theta(12)*C(4); 

% pPRR9
dC(5) = theta(13)*C(4) - theta(14)*C(5); 

% mPRR7
dC(6) = theta(15)*(C(11)^theta(16))*(C(12)^theta(17)) - theta(18)*C(6); 

% pPRR7
dC(7) = theta(19)*C(6) - theta(20)*C(7); 

% mPRR5
dC(8) = theta(21)*(C(3)^theta(22))*(C(11)^theta(23)) - theta(24)*C(8); 

% pPRR5
dC(9) = theta(25)*C(8) - theta(26)*C(9); 

% mTOC1 
dC(10) = theta(27)*(C(3)^theta(28))*(C(12)^theta(29)) - theta(30)*C(10); 
 
% pTOC1 
dC(11) = theta(31)*C(10) - theta(32)*C(11); 

% pEC
dC(12) = theta(33)*C(16)*C(18)*C(20) - theta(34)*C(12); 

% mRVE8
dC(13) = theta(35)*C(9)^(theta(36)) - theta(37)*C(13); 

% pRVE8
dC(14) = theta(38)*C(13) - theta(39)*C(14); 

% mELF3 
dC(15) = theta(40)*C(3)^(theta(41)) - theta(42)*C(15); 

% pELF3
dC(16) = theta(43)*C(15) - theta(44)*C(16); 

% mELF4 
dC(17) = theta(45)*C(3)^(theta(46))*C(12)^(theta(47)) - theta(48)*C(17); 
 
% pELF4
dC(18) = theta(49)*C(17) - theta(50)*C(18); 

% mLUX
dC(19) = theta(51)*C(3)^(theta(52))*C(12)^(theta(53)) - theta(54)*C(19); 

% pLUX
dC(20) = theta(55)*C(19) - theta(56)*C(20); 

% mGI
dC(21) = theta(57)*(C(3)^theta(58))*(C(11)^theta(59))*(C(16)^theta(60)) - theta(61)*C(21); 

% pGI
dC(22) = theta(62)*C(21)*(C(16)*C(23)*C(22))^(theta(63)) - theta(64)*C(22) ; 

% pCOP1
dC(23) = theta(65)*EL^(theta(66)) - theta(67)*C(23);

% % pZTL
dC(24) = theta(68)*C(22)*C(24) - theta(69)*C(24);

