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

[Lambda, Rho] = designLDPC(30,30, 11.7, 32, 0.45);

% Range for the BEP (Bit Erasure Probs.)
M = 25;
epsilon = linspace(0.3,0.5, M);

% Empty Vector for storing the BEPs
bep = zeros(M,8);

for j = 1:5
    
    H = iLDPC(Lambda, Rho);

    % number of varialbe nodes
    n = size(H,2);

    % Create Matrix with the zero codewords
    X = zeros(n,N);

    % Create Matrix for the recoverd codewords
    X_hat = zeros(size(X));

    % Iterate. For every `epsilon`:
    for i = 1 : M
        fprintf("j = %d | ε =  %f\n", j, epsilon(i));
        Y = BEC(X,epsilon(i));
        X_hat = BPDecoder(Y,H,10);
        bep(i,j) = mean2(isnan(X_hat));
    end
end

%% Test regular LDPC
n = sum(Lambda);
m = sum(Rho);

avnd = floor(sum((1:size(Lambda,2)).*Lambda  ) / n);
acnd = ceil(sum((1:size(Rho,2)).*Rho  ) / m);

rLambda = zeros(size(Lambda));
rRho = zeros(size(Rho));

rLambda(avnd) = n;
rRho(acnd) = m;

for j = 6:8
    H = iLDPC(rLambda, rRho);

    % number of varialbe nodes
    n = size(H,2);

    % Create Matrix with the zero codewords
    X = zeros(n,N);

    % Create Matrix for the recoverd codewords
    X_hat = zeros(size(X));

    % Iterate. For every `epsilon`:
    for i = 1 : M
        fprintf("j = %d | ε =  %f\n", j, epsilon(i));
        Y = BEC(X,epsilon(i));
        X_hat = BPDecoder(Y,H,10);
        bep(i,j) = mean2(isnan(X_hat));
    end
end

%% Plot the result
figure;
hold on;
plot(epsilon, epsilon, '--', 'LineWidth', 1.2, 'Color', 'red')
plot(epsilon, bep(:,1:5), 'Color','black');
legend(["No Decoding","BP Decoding"]);
grid on;
xlabel("\epsilon")
ylabel("P^{BP}")
title("Performance of 5 samples from the LDPC Standard Ensamble.");

figure; hold on; grid on;
plot(epsilon, mean(bep(:,1:5), 2));
plot(epsilon, mean(bep(:,6:end), 2));
plot(epsilon, bep(:,1:5), '--', 'Color','blue')
plot(epsilon, bep(:,6:end), '--', 'Color','red')
legend(["ireagular LDPC", "regular LDPC"]);
xlabel("\epsilon")
ylabel("P^{BP}")
title("Mean bit erasure prob. after decding");
