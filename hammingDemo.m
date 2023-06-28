% Reset Matlab environment
clear all; close all; clc; warning('off');

% Load dependencies
pkg load communications;

% ========================================================
% Benchmark Parameters (Experiment with your own values)
% ========================================================

% Number of messages/symbols to send through the noisy channel
numOfMessages = 100000;

% Range of noise-levels over the transmission channel
loExp = -5;
hiExp = -1;
num = 20;
epsilon = 5 * logspace(loExp, hiExp, num);

% =========================================================
% Setup a 4-bit random symbol generator and
% generate random messages/symbols
% =========================================================
rsg = RandomSymbolGenerator;
rsg.SymbolBitLength = 4;
messages = rsg.generateSymbols(numOfMessages);

% =========================================================
% 1st Benchmark: No error-correction is used
% =========================================================
encoder = NaiveEncoder;
channel = BinarySymmetricChannel;
channel.BitWidth = 4;
decoder = NaiveDecoder;

% Convert symbols to codewords (encoding)
codewords = encoder.encodeSymbols(messages);

naive_error_rate = zeros(num, 1);

% Progress status
disp("\n\nBenchmark: 1 out of 3, No error correction");
disp("--------------------------------------------");

tic;

for i = 1:num
  % Progress bar
  disp(sprintf("Test case: %d out of %d.", i, num));
  disp(sprintf("Bit Error Rate: %.3f%%\n", epsilon(i) * 100));

  % Update the cross-over-probability of the channel
  channel.CrossOverProbability = epsilon(i);

  % Contaminate input with additive noise
  channelOutput = channel.contaminateBitStream(codewords);

  % Decode the received data and try to correct any errors
  decoderOutput = decoder.decodeCodeWords(channelOutput);

  % Compare the output of the decoder with the initial data
  numOfErrors = sum(decoderOutput ~= messages);
  naive_error_rate(i) = numOfErrors / numOfMessages;
end

toc;

% ========================================================
% 2nd Benchmark: Error correction with Hamming (7,4) code
% ========================================================
encoder = Hamming74Encoder;
channel = BinarySymmetricChannel;
channel.BitWidth = 7;
decoder = Hamming74Decoder;

% Convert symbols to codewords (encoding)
codewords = encoder.encodeSymbols(messages);

hamming_error_rate = zeros(num, 1);

% Progress status
disp("\n\nBenchmark: 2 out of 3, Hamming (7,4)");
disp("--------------------------------------");

tic;

for i = 1:num
  % Progress bar
  disp(sprintf("Test case: %d out of %d.", i, num));
  disp(sprintf("Bit Error Rate: %.3f%%\n", epsilon(i) * 100));

  % Update the cross-over-probability of the channel
  channel.CrossOverProbability = epsilon(i);

  % Contaminate input with additive noise
  channelOutput = channel.contaminateBitStream(codewords);

  % Decode the received data and try to correct any errors
  decoderOutput = decoder.decodeCodeWords(channelOutput);

  % Compare the output of the decoder with the initial data
  numOfErrors = sum(decoderOutput ~= messages);
  hamming_error_rate(i) = numOfErrors / numOfMessages;
end

toc;

% =========================================================
% 3nd Benchmark: Error correction with Hadamard (16,4) code
% =========================================================
encoder = Hadamard164Encoder;
channel = BinarySymmetricChannel;
channel.BitWidth = 16;
decoder = Hadamard164Decoder;

% Convert symbols to codewords (encoding)
codewords = encoder.encodeSymbols(messages);

hadamard_error_rate = zeros(num, 1);

% Progress status
disp("\n\nBenchmark: 3 out of 3, Hadamard (16,4)");
disp("----------------------------------------");

tic;

for i = 1:num
  % Progress bar
  disp(sprintf("Test case: %d out of %d.", i, num));
  disp(sprintf("Bit Error Rate: %.3f%%\n", epsilon(i) * 100));

  % Update the cross-over-probability of the channel
  channel.CrossOverProbability = epsilon(i);

  % Contaminate input with additive noise
  channelOutput = channel.contaminateBitStream(codewords);

  % Decode the received data and try to correct any errors
  decoderOutput = decoder.decodeCodeWords(channelOutput);

  % Compare the output of the decoder with the initial data
  numOfErrors = sum(decoderOutput ~= messages);
  hadamard_error_rate(i) = numOfErrors / numOfMessages;
end

toc;

% ==========================================================
% Plot the results of the benchmarks
% ==========================================================

% Theoretical error rates for naive and hamming encoding
naive_error_rate_theoretical     = 1-(1-epsilon).^4;
hamming_error_rate_theoretical   = 1-(1-epsilon).^6 .* (1+6*epsilon);

% Upper and lower bound for hadamard encoding error rate
hadamard_error_rate_theoretical  = 1-(1-epsilon).^16;
hadamard_error_rate_theoretical -=   16 .* (epsilon .^ 1) .* (1-epsilon).^15;
hadamard_error_rate_theoretical -=  120 .* (epsilon .^ 2) .* (1-epsilon).^14;
hadamard_error_rate_theoretical -=  560 .* (epsilon .^ 3) .* (1-epsilon).^13;

hadamard_error_rate_lower_bound = hadamard_error_rate_theoretical;
hadamard_error_rate_upper_bound = hadamard_error_rate_theoretical - 1820 .* (epsilon .^ 4) .* (1-epsilon).^12;

% Error-rates in logarithmic scale
figure(1); hold on;

loglog(epsilon, naive_error_rate,
  'o', 'color', 'red',
  'MarkerFaceColor', 'red');

loglog(epsilon, naive_error_rate_theoretical,
  '--', 'color', 'red',
  'LineWidth', 1.5);

loglog(epsilon, hamming_error_rate,
  'o', 'color', 'blue',
  'MarkerFaceColor', 'blue');

loglog(epsilon, hamming_error_rate_theoretical,
  '--', 'color', 'blue',
  'LineWidth', 1.5);

loglog(epsilon, hadamard_error_rate,
  'o', 'color', 'black',
  'MarkerFaceColor', 'black');

loglog(epsilon, hadamard_error_rate_upper_bound,
  ':', 'color', 'black',
  'LineWidth', 1.5);

loglog(epsilon, hadamard_error_rate_lower_bound,
  ':', 'color', 'black',
  'LineWidth', 1.5);

% Axes limits
xlim([5 * 10 ^ loExp 5 * 10 ^ hiExp]);
ylim([5e-7 1]);

xlabel('Cross-Over-Probability');
ylabel('Decoder error-rate');
title('Error-Rate vs Cross-Over-Probability');

legend(
  'No error-correction, benchmark results',
  'No error-correction, theoretical error rate',
  'Hamming (7,4), benchmark results',
  'Hamming (7,4), theoretical error rate',
  'Hadamard (16,4), benchmark results',
  'Hadamard (16,4), theoretical error rate (upper bound)',
  'Hadamard (16,4), theoretical error rate (lower bound)',
  'Location', 'northwest');

grid on;
