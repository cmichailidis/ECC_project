clear; clc;
% Number of Code words to transmit over the BEC
N = 10000;

% Specify Degree Distribution Polynomials
% Note: The following means
%   We have 3 variable nodes with degree 1
%   ---//-- 3 ---------- // -----------  2
%   We have 3 variable nodes with degree 1
%   ---//-- 4 ---------- // -----------  3
%                    and
%   We have 0 check nodes with degree 1
%   ---//-- 7 --------- // ---------  2
%   ---//-- 14 --------- // ---------  2
Lambda = [3 3 1 0 0 0 0 0];
Rho = [0 0 0 3 0 0];

% Number of Varialbe nodes Lambda'(1)
n = sum((1:numel(Lambda)).*Lambda);

% Sample from the LDPC(Lambda, Rho) ensamble
H = iLDPC(Lambda, Rho);

% Range for the BEP (Bit Erasure Probs.)
M = 100;
epsilon = logspace(-5,0, M);

% Create Matrix with the zero codewords
X = zeros(n,N);

% Create Matrix for the recoverd codewords
X_hat = zeros(size(X));

% Empty Vector for storing the BEPs
bep = zeros(M,2);

% Iterate. For every `epsilon`:
for i = 1 : M
    fprintf("ε =  %f\n", epsilon(i));
    Y = BEC(X,epsilon(i));
    bep(i,1) = mean2(isnan(Y));
    for j = 1 : size(X,2)
        X_hat(:,j) = BPDecoder(Y(:,j),H,10);
    end
    bep(i,2) = mean2(isnan(X_hat));
end

% Plot the result
plot(epsilon, log10(bep+1e-7));
