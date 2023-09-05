function H = iLDPC(Lambda, Rho)
% iLDPC Sample from the Standard LDPC Ensembles.
%
%   H = iLDPC(Lambda, Rho) where Lambda (Rho) is a vector containing the
% coefficents of the Variable (cehck) Node degree Distribution. H is the
% parity check matrix.
% 
N = sum(Lambda);
C = sum(Rho);
H = zeros(C,N);
nsockets = sum((1:numel(Lambda)).*Lambda);
sockets = zeros(nsockets, 2);
degv = 1;
degc = 1;
cvn = 1;
ccn = 1;
for k = 1 : nsockets
    if Lambda(degv) == 0
        degv = degv + 1;
    end
    if Rho(degc) == 0
        degc = degc + 1;
    end
    if sum(sockets(:,1) == cvn) == degv
        cvn = cvn + 1;
        Lambda(degv) = Lambda(degv) - 1;
    end
    if sum(sockets(:,2) == ccn) == degc
        ccn = ccn + 1;
        Rho(degc) = Rho(degc) - 1;
    end
    sockets(k, 1) = cvn;
    sockets(k, 2) = ccn;
end
sigma = randperm(nsockets);
for k = 1 : nsockets
    j = sockets(k,1);
    i = sockets(sigma(k),2);
    H(i,j) = H(i,j) + 1;
end
H = mod(H,2);
end