function dC = Kernel2016_ODE(t,C)


global L theta

hc = 2;

dC = zeros(24,1);

% Protein P
dC(1) = 1*theta(1)*L + 1*theta(2)*C(1) + 1*theta(3);

% LHY mRNA
dC(2) = 1*theta(4)./(theta(5).^hc + theta(6).*(1*theta(75).*C(5) + 1*theta(76).*C(7) + 1*theta(77).*C(9)).^hc) + theta(7)*C(2);

% LHY protein
dC(3) = 1*theta(8)*C(2) + 1*theta(9)*C(3);

% PRR9 mRNA
dC(4) = 1*theta(10)*C(1)*L + theta(11) ...
    + 1*theta(12)*C(3).^hc./(theta(13).^hc + C(3).^hc) + 1*theta(14)*C(4);

% PRR9 protein
dC(5) = 1*theta(15)*C(4) + 1*theta(16)*C(5);

% PRR7 mRNA
dC(6) = 1*theta(17)./((theta(18) + 1*C(12)).*(theta(19).^hc + 1*C(11).^hc)) + 1*theta(20)*C(6);

% PRR7 protein
dC(7) = 1*theta(21)*C(6) + 1*theta(22)*C(7);

% PRR5 mRNA
dC(8) = 1*theta(23)./((theta(24).^hc + 1*C(11).^hc).*(theta(25).^hc + 1*C(3).^hc)) + 1*theta(26)*C(8);

% PRR5 protein
dC(9) = 1*theta(27)*C(8) + 1*theta(28)*C(9);

% TOC1 mRNA
dC(10) = 1*theta(29)./((theta(30) + 1*C(12)).*(theta(31).^hc + 1*C(3).^hc)) + 1*theta(32)*C(10);

% TOC1 protein
dC(11) = 1*theta(33)*C(10) + 1*theta(34)*C(11);

% EC protein
dC(12) = 1*theta(35)*(C(16).*C(18).*C(20)) + 1*theta(36)*C(12);

% RVE8 mRNA
dC(13) = 1*theta(37)./(theta(38).^hc + (1*theta(77).*C(9)).^hc) + 1*theta(39)*C(13);

% RVE8 protein
dC(14) = 1*theta(40)*C(13) + 1*theta(41)*C(14);

% ELF3 mRNA
dC(15) = 1*theta(42)./(theta(43).^hc + 1*C(3).^hc) + 1*theta(44)*C(15);

% ELF3 protein
dC(16) = 1*theta(45)*C(15) + 1*theta(46)*C(16);

% ELF4 mRNA
dC(17) = 1*theta(47)./((theta(48) + 1*C(12)).*(theta(49).^hc + 1*C(3).^hc)) + 1*theta(50)*C(17);

% ELF4 protein
dC(18) = 1*theta(51)*C(17) + 1*theta(52)*C(18);

% LUX mRNA
dC(19) = 1*theta(53)./((theta(54) + 1*C(12)).*(theta(55).^hc + 1*C(3).^hc)) + 1*theta(56)*C(19);

% LUX protein
dC(20) = 1*theta(57)*C(19) + 1*theta(58)*C(20);

% GI mRNA
dC(21) = 1*theta(59)./((theta(60).^hc + 1*C(3).^hc).*(theta(61).^hc + 1*C(11).^hc).*(theta(62).^hc + 1*C(16).^hc)) ...
    + 1*theta(63)*C(21);

% GI protein
dC(22) = 1*theta(64)*C(21) + 1*theta(65)*C(16).*C(23).*C(22) + 1*theta(66)*C(22);

% COP1 protein
dC(23) = 1*theta(67)*L + 1*theta(68)*C(23) + 1*theta(69);

% % ZTL protein
dC(24) = (1*theta(70)*C(24)*C(22))./(1 + theta(71).*C(24) + theta(72).*C(22)) ...
    + theta(73)*C(24) + theta(74);

