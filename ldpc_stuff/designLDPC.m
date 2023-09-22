function [Lambda, Rho] = designLDPC(lmax, rmax, ravg, n, epsilon)
% Define the polynomial ρ(x)
[rhovec, rho] = makeRho(ravg, rmax);

% Define discretization for x
N = 100;
xrange = linspace(0,1,N);

% Define Matrices for linprog
f = -1./(2:lmax)';
A = epsilon*((1-rho(1-xrange')).^((1:lmax-1)));
b = xrange';
Aeq = ones(1,lmax-1);
beq = 1;
lb = zeros(lmax-1,1);
ub = ones(lmax-1,1);

% Solve the optimization problem
lambda = linprog(f,A,b,Aeq,beq,lb,ub);
lambda = lambda(:)';

num_edges = n / (-lambda * f);
Lambda = round(num_edges * (lambda ./ (2:lmax)));
Lambda = [0 Lambda];
Rho = intlinprog(ones(rmax,1), ...
     1:rmax, ...
     zeros(1,rmax), 0, ...
     1:rmax, sum((1:lmax).*Lambda), ...
     zeros(rmax,1), n*ones(rmax,1));
Rho = Rho(:)';

% Functions
function [rhovec, f] = makeRho(ravg, rmax)
    r = floor(ravg);
    rhovec = zeros(1, rmax);
    rhovec(r) = r*(r+1-ravg)/ravg;
    rhovec(r+1) = (ravg - r*(r+1-ravg))/ravg;
    function val = rho(x)
        x = x(:);
        X = x.^(0:rmax-1);
        val = X * rhovec';
    end
    f = @(x)(rho(x));
end
end