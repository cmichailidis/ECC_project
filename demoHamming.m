% Reset workspace environment
clear all; close all; clc;

% Generator matrix for Hamming 7,4
G = [1 0 0 0   1 1 0;
     0 1 0 0   1 0 1;
     0 0 1 0   0 1 1;
     0 0 0 1   1 1 1];

% Parity check matrix for Hamming 7,4
H = [1 1 0 1   1 0 0;
     1 0 1 1   0 1 0;
     0 1 1 1   0 0 1;];

% Number of binary symbols
num = 10;

% Generate random binary symbols
m = rand(num, 4);
m(m <= 0.5) = 0;
m(m >= 0.5) = 1;

% Encoding
c = encoder(G, m);

% error rate of binary symmetric channel
err = 0.2;

% Contaminate with additive noise
x = bsc(c, err);

% Debugging info
printf("Original messages:\n");
disp(m);
printf("\n");

printf("Encoded codewords:\n");
disp(c);
printf("\n");

printf("Contaminated codewords:\n");
disp(x);
printf("\n");



