function dC = JL2005S_ODE(t,C)


global theta EL 

dC = zeros(7,1);

% mLHY
dC(1) = theta(1)*C(6)^(theta(2)) - theta(3)*C(1) + theta(4)*C(7)*EL;

% pcLHY
dC(2) = theta(5)*C(1)^(theta(6)) - theta(7)*C(2);

% pnLHY
dC(3) = theta(8)*C(2)^(theta(9)) - theta(10)*C(3);

% mTOC1
dC(4) = theta(11)*C(3)^(theta(12)) - theta(13)*C(4);

% pcTOC1
dC(5) = theta(14)*C(4)^(theta(15)) - theta(16)*C(5);

% pnTOC1
dC(6) = theta(17)*C(5)^(theta(18)) - theta(19)*C(6);

% pP
dC(7) = -theta(20)*C(7) + theta(21)*(1-EL) + theta(22)*C(7)*EL;

