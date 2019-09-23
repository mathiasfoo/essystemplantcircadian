function dC = MF2016KSorig_ODE(t,C)


global theta EL 

dC = zeros(24,1);

%% ODE
% pP
dC(1) = real(theta(1) - theta(2)*EL^(theta(3))*C(1)^(theta(4)));

% mLHY
dC(2) = real(theta(5)*C(5)^(theta(6))*C(7)^(theta(7))*C(9)^(theta(8)) - theta(9)*C(2)); 

% pLHY
dC(3) = real(theta(10)*C(2) - theta(11)*C(3)); 

% mPRR9
dC(4) = real(theta(12)*C(3)^(theta(13))*C(1)^(theta(14))*EL^(theta(15)) - theta(16)*C(4)); 

% pPRR9
dC(5) = real(theta(17)*C(4) - theta(18)*C(5)); 

% mPRR7
dC(6) = real(theta(19)*(C(11)^theta(20))*(C(12)^theta(21)) - theta(22)*C(6)); 

% pPRR7
dC(7) = real(theta(23)*C(6) - theta(24)*C(7)); 

% mPRR5
dC(8) = real(theta(25)*(C(3)^theta(26))*(C(11)^theta(27)) - theta(28)*C(8)); 

% pPRR5
dC(9) = real(theta(29)*C(8) - theta(30)*C(9)); 

% mTOC1 
dC(10) = real(theta(31)*(C(3)^theta(32))*(C(12)^theta(33)) - theta(34)*C(10)); 
 
% pTOC1 
dC(11) = real(theta(35)*C(10) - theta(36)*C(11)); 

% pEC
dC(12) = real(theta(37)*C(16)*C(18)*C(20) - theta(38)*C(12)); 

% mRVE8
dC(13) = real(theta(39)*C(9)^(theta(40)) - theta(41)*C(13)); 

% pRVE8
dC(14) = real(theta(42)*C(13) - theta(43)*C(14)); 

% mELF3 
dC(15) = real(theta(44)*C(3)^(theta(45)) - theta(46)*C(15)); 

% pELF3
dC(16) = real(theta(47)*C(15) - theta(48)*C(16)); 

% mELF4 
dC(17) = real(theta(49)*C(3)^(theta(50))*C(12)^(theta(51)) - theta(52)*C(17)); 

% pELF4
dC(18) = real(theta(53)*C(17) - theta(54)*C(18)); 

% mLUX
dC(19) = real(theta(55)*C(3)^(theta(56))*C(12)^(theta(57)) - theta(58)*C(19)); 

% pLUX
dC(20) = real(theta(59)*C(19) - theta(60)*C(20)); 

% mGI
dC(21) = real(theta(61)*(C(3)^theta(62))*(C(11)^theta(63))*(C(16)^theta(64)) - theta(65)*C(21)); 

% pGI
dC(22) = real(theta(66)*C(21) - theta(67)*C(22)^(theta(68))*C(16)^(theta(69))*C(23)^(theta(70))); 

% pCOP1
dC(23) = real(theta(71) - theta(72)*EL^(theta(73))*C(23)^(theta(74)));

% % pZTL
dC(24) = real(theta(75)*C(24)^(theta(76))*C(22)^(theta(77)) - theta(78)*C(24)); 

