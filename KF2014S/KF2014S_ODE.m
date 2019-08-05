function dC = KF2014S_ODE(t,C)


global theta EL 

dC = zeros(35,1);

% mLHY
dC(1) = real((theta(1)*(C(7)+C(9)+C(12)+C(15))^theta(2)  - theta(3)*C(1) + theta(4)*C(5)*EL));

% pLHY
dC(2) = real(theta(5)*C(1) - theta(6)*C(2) + theta(7)*C(1)*EL);

% mCCA1
dC(3) = real((theta(8)*(C(7)+C(9)+C(12)+C(15))^(theta(9)) - theta(10)*C(3) + theta(11)*C(5)*EL));

% pCCA1
dC(4) = real(theta(12)*C(3) - theta(13)*C(4) + theta(14)*C(3)*EL);

% pP
dC(5) = real(theta(15)*(1 - EL) + theta(16)*C(5)*(1 - EL)  + theta(17)*C(5)*EL);

% mPRR9
dC(6) = real(theta(18)*C(35)^(theta(19))*(C(2)+C(4))^(theta(20))*(C(23)+C(33))^(theta(21))*(C(20)+C(21))^(theta(22))*C(12)^(theta(23))*C(15)^(theta(24))...
    - theta(25)*C(6) + theta(26)*C(5)*EL);

% pPRR9
dC(7) = real(theta(27)*C(6) - theta(28)*C(7));

% mPRR7
dC(8) = real(theta(29)*(C(2)+C(4))^(theta(30))*(C(23)+C(33))^(theta(31))*(C(20)+C(21))^(theta(32))*C(12)^(theta(33))*C(15)^(theta(34))...
    - theta(35)*C(8));

% pPRR7
dC(9) = real(theta(36)*C(8) - theta(37)*C(9) + theta(38)*C(9)*(1-EL));

% mPRR5 
dC(10) = real(theta(39)*C(35)^(theta(40))*(C(2)+C(4))^(theta(41))*(C(23)+C(33))^(theta(42))*(C(20)+C(21))^(theta(43))*C(15)^(theta(44))...
    - theta(45)*C(10));

% pcPRR5
dC(11) = real(theta(46)*C(10)^(theta(47)) - theta(48)*C(11) - theta(49)*C(27)*C(11));

% pnPRR5
dC(12) = real(theta(50)*C(11)^(theta(51)) - theta(52)*C(12));

% mTOC1 
dC(13) = real(theta(53)*C(35)^(theta(54))*(C(2)+C(4))^(theta(55))*(C(23)+C(33))^(theta(56))*(C(20)+C(21))^(theta(57))*C(15)^(theta(58))...
    - theta(59)*C(13));

% pcTOC1
dC(14) = real(theta(60)*C(13)^(theta(61)) - theta(62)*C(14) - theta(63)*C(27)*C(14));

% pnTOC1
dC(15) = real(theta(64)*C(14)^(theta(65)) - theta(66)*C(15));

% mELF4 
dC(16) = real(theta(67)*C(35)^(theta(68))*(C(2)+C(4))^(theta(69))*(C(23)+C(33))^(theta(70))*(C(20)+C(21))^(theta(71))*C(15)^(theta(72))...
    - theta(73)*C(16));

% pELF4
dC(17) = real(theta(74)*C(16) - theta(75)*C(17));

% pdELF4
dC(18) = real(theta(76)*C(17) - theta(77)*C(18) - theta(78)*C(20)*C(18));

% mELF3
dC(19) = real(theta(79)*(C(2)+C(4))^(theta(80)) - theta(81)*C(19));

% pELF3
dC(20) = real(theta(82)*C(19)  - theta(83)*C(20) - theta(84)*C(18)*C(20) - theta(85)*C(25)*C(20) - theta(86)*C(26)*C(20) - theta(87)*C(31)*C(20));

% pE34
dC(21) = real(theta(88)*C(18)*C(20) - theta(89)*C(21) - theta(90)*C(25)*C(21) - theta(91)*C(26)*C(21) - theta(92)*C(31)*C(21));

% % mLUX
dC(22) = real(theta(93)*C(35)^(theta(94))*(C(2)+C(4))^(theta(95))*(C(23)+C(33))^(theta(96))*(C(20)+C(21))^(theta(97))*(C(15))^(theta(98))...
    - theta(99)*C(22));

% pLUX
dC(23) = real(theta(100)*C(22) - theta(101)*C(23));

% pcCOP1
dC(24) = real(theta(102) - theta(103)*C(24) + theta(104)*C(24)*EL);

% pnCOP1
dC(25) = real(theta(105)*C(24)^(theta(106)) - theta(107)*C(25) + theta(108)*C(5)*C(25)*EL + theta(109)*C(25)*EL);

% pdCOP1
dC(26) = real(theta(110)*C(25) - theta(111)*C(26) + theta(112)*C(25)*C(5)*EL + theta(113)*C(26)*(1-EL));

% pZTL
dC(27) = real(theta(114) - theta(115)*C(27) - theta(116)*C(27)*C(30) + theta(117)*C(28)*EL + theta(118)*C(28)*(1-EL));

% pZG
dC(28) = real(theta(119)*C(27)*C(30) - theta(120)*C(28) + theta(121)*C(28)*EL + theta(122)*C(28)*(1-EL));

% mGI
dC(29) = real(theta(123)*C(35)^(theta(124))*(C(2)+C(4))^(theta(125))*(C(23)+C(33))^(theta(126))*(C(20)+C(21))^(theta(127))*(C(15))^(theta(128))...
    - theta(129)*C(29));

% pcGI
dC(30) = real(theta(130)*C(29)^(theta(131)) - theta(132)*C(30) - theta(133)*C(27)*C(30) + theta(134)*C(28)*EL + theta(135)*C(28)*(1-EL));

% pnGI
dC(31) = real(theta(136)*C(30)^(theta(137)) - theta(138)*C(31) - theta(139)*(C(20)+C(21))*C(31) - theta(140)*(C(20)+C(21))*C(25)*C(31)...
    - theta(141)*(C(20)+C(21))*C(26)*C(31));

% mNOX
dC(32) = real((theta(142)*(C(2)+C(4))^(theta(143))*C(9)^(theta(144))) - theta(145)*C(32));

% pNOX
dC(33) = real(theta(146)*C(32) - theta(147)*C(33));

% mRVE8
dC(34) = real(theta(148)*(C(7)+C(9)+C(12))^(theta(149)) - theta(150)*C(34));

% pRVE8
dC(35) = real(theta(151)*C(34) - theta(152)*C(35));
