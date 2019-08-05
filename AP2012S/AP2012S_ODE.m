function dC = AP2012S_ODE(t,C)


global theta EL 

dC = zeros(28,1);

% mLHY
dC(1) = real((theta(1)*(C(6)+C(8)+C(10)+C(12))^(theta(2)) - theta(3)*C(1)) + theta(4)*C(4)*EL + theta(5)*C(1)*EL);

% pLHY
dC(2) = real(theta(6)*C(1) - theta(7)*C(2) + theta(8)*C(1)*EL);

% pLHYmod
dC(3) = real(theta(9)*C(2)^(theta(10)) - theta(11)*C(3));

% pP
dC(4) = real(theta(12)*(1 - EL) + theta(13)*C(4)*(1 - EL)  + theta(14)*C(4)*EL);

% mPRR9
dC(5) = real((theta(15)*C(2)^(theta(16))*C(24)^(theta(17)) - theta(18)*C(5)) + theta(19)*C(4)*EL); 

% pPRR9
dC(6) = real(theta(20)*C(5) - theta(21)*C(6) + theta(22)*C(6)*(1 - EL));

% mPRR7
dC(7) = real((theta(23)*(C(2)+C(3))^(theta(24))*C(6)^(theta(25))) - theta(26)*C(7));

% pPRR7
dC(8) = real(theta(27)*C(7) - theta(28)*C(8) + theta(29)*C(8)*(1 - EL));

% mNI
dC(9) = real(theta(30)*C(3)^(theta(31))*C(8)^(theta(32)) - theta(33)*C(9));

% pNI
dC(10) = real(theta(34)*C(9) - theta(35)*C(10) + theta(36)*C(10)*(1 - EL));

% mTOC1 
dC(11) = real((theta(37)*C(2)^(theta(38))*C(24)^(theta(39))) - theta(40)*C(11));
 
% pTOC1 
dC(12) = real(theta(41)*C(11) - theta(42)*C(12) - theta(43)*C(12)*C(25) - theta(44)*C(12)*C(26) ...
    + theta(45)*C(12)*C(25)*(1 - EL) + theta(46)*C(12)*C(26)*(1 - EL));

% mELF4 
dC(13) = real((theta(47)*C(2)^(theta(48))*C(24)^(theta(49))) - theta(50)*C(13));

% pELF4
dC(14) = real(theta(51)*C(13) - theta(52)*C(14) - theta(53)*C(14)*C(17)*C(19)) - theta(54)*C(14)*C(17) ;

% mELF3 
dC(15) = real((theta(55)*C(2)^(theta(56))) - theta(57)*C(15));

% pELF3c
dC(16) = real(theta(58)*C(15)^(theta(59)) - theta(60)*C(16) - theta(61)*C(16)*C(20) - theta(62)*C(16)*C(28));

% pELF3n
dC(17) = real(theta(63)*C(16)^(theta(64)) - theta(65)*C(17) - theta(66)*C(17)*C(28) - theta(67)*C(17)*C(22) - theta(68)*C(17)*C(21)...
    - theta(69)*C(14)*C(17)*C(19)) - theta(70)*C(17)*C(14);

% mLUX
dC(18) = real((theta(71)*C(2)^(theta(72))*C(24)^(theta(73))) - theta(74)*C(18));

% pLUX
dC(19) = real(theta(75)*C(18) - theta(76)*C(19) - theta(77)*C(19)*C(14)*C(17));

% pCOP1c
dC(20) = real(theta(78) - theta(79)*C(20) + theta(80)*C(20)*EL);

% pCOP1n
dC(21) = real(theta(81)*C(20)^(theta(82)) - theta(83)*C(21) + theta(84)*C(21)*C(4)*EL + theta(85)*C(21)*EL);

% pCOP1d
dC(22) = real(theta(86)*C(21) - theta(87)*C(22) + theta(88)*C(21)*C(4)*EL + theta(89)*C(22)*(1 - EL));

% pEG
dC(23) = real(theta(90)*C(16)*C(28) - theta(91)*C(23) - theta(92)*C(23)*C(20) - theta(93)*C(17)*C(28));

% pEC
dC(24) = real(theta(94)*C(19)*C(14)*C(17) - theta(95)*C(24) - theta(96)*C(24)*C(21) - theta(97)*C(24)*C(22) + theta(98)*C(24)*C(28)*EL);

% pZTL
dC(25) = real((theta(99) - theta(100)*C(25) + theta(101)*EL*C(28)*C(25) + theta(102)*C(26)*(1 - EL)));

% pZG
dC(26) = real(-theta(103)*C(26) + theta(104)*C(28)*C(25)*EL + theta(105)*C(26)*(1 - EL));

% mGI
dC(27) = real(theta(106)*C(2)^(theta(107))*C(24)^(theta(108)) - theta(109)*C(27) + theta(110)*C(4)*EL);

% pGI
dC(28) = real(theta(111)*C(27) - theta(112)*C(28) - theta(113)*C(16)*C(28) + theta(114)*C(28)*C(25)*EL + theta(115)*C(26)*(1 - EL));

