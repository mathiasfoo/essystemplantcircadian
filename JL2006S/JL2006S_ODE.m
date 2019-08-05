function dC = Jl2006S_ODE(t,C)

global theta EL 

dC = zeros(16,1);

% pP
dC(1) = real(-theta(1)*C(1) + theta(2)*(1 - EL) + theta(3)*C(1)*EL);

% mLHY
dC(2) = real(theta(4)*C(10)^(theta(5))*C(16)^(theta(6)) - theta(7)*C(2) + theta(8)*C(1)*EL*C(16)^(theta(9))); 

% pcLHY
dC(3) = real(theta(10)*C(2)^(theta(11)) - theta(12)*C(3));

% pnLHY
dC(4) = real(theta(13)*C(3)^(theta(14)) - theta(15)*C(4));

% mTOC1 
dC(5) = real(theta(16)*C(4)^(theta(17))*C(13)^(theta(18)) - theta(19)*C(5));
 
% pcTOC1 
dC(6) = real(theta(20)*C(5)^(theta(21)) - theta(22)*C(6) + theta(23)*C(6)*(1 - EL)); 

% pnTOC1 
dC(7) = real(theta(24)*C(6)^(theta(25)) - theta(26)*C(7) + theta(27)*C(7)*(1 - EL)); 

% mX 
dC(8) = real(theta(28)*C(7)^(theta(29)) - theta(30)*C(8));

% pcX 
dC(9) = real(theta(31)*C(8)^(theta(32)) - theta(33)*C(9));

% pnX 
dC(10) = real(theta(34)*C(9)^(theta(35)) - theta(36)*C(10));

% mY
dC(11) = real(theta(37)*C(4)^(theta(38))*C(7)^(theta(39)) - theta(40)*C(11) + theta(41)*EL*C(1)*C(4)^(theta(42)) + theta(43)*EL*C(4)^(theta(44))*C(7)^(theta(45)));

% pcY
dC(12) = real(theta(46)*C(11)^(theta(47)) - theta(48)*C(12)); 

% pnY
dC(13) = real(theta(49)*C(12)^(theta(50)) - theta(51)*C(13)); 

% mP7P9
dC(14) = real(theta(52)*C(4)^(theta(53)) - theta(54)*C(14) + theta(55)*C(1)*EL); 

% pcP7P9
dC(15) = real(theta(56)*C(14)^(theta(57)) - theta(58)*C(15)); 

% pnP7P9
dC(16) = real(theta(59)*C(15)^(theta(60)) - theta(61)*C(16)); 

