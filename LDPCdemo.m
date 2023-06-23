% Reset Matlab Environment
clear all; close all; clc; warning('off');

% Load dependencies
% Remove this if you use Matlab instead of Octave
pkg load communications;

% ------------------------------------------------------
% Benchmark parameters (Experiment with your own values
% ------------------------------------------------------

% Number of messages/symbols to send through the noisy channel
numOfMessages = 1000;

% Range of noise-levels over the transmission channel
loExp = -5;
hiExp = -1;
num = 20;
epsilon = 5 * logspace(loExp, hiExp, num);  % 5e-5 ... 5e-1

% Number of Feedforward/Backprop iterations
% for the deep belief decoder
num_iter = 10;

% ------------------------------------------------------
% Generate Random codewords (and a transmission channel)
% ------------------------------------------------------
channel = BinaryErasureChannel;
channel.BitWidth = 7;
codewords = zeros(numOfMessages, channel.BitWidth);

% --------------------------------------------------------
% 1st Benchmark: no error correction (base-line)
% --------------------------------------------------------

symbol_error_rate_baseline = zeros(num,1);

for i = 1:num
  channel.ErasureProbability = epsilon(i);
  bec_output = channel.contaminateBitStream(codewords);
  symbols = zeros(numOfMessages, channel.BitWidth);
  numOfErrors = 0;

  for j = 1:numOfMessages
    msg = bec_output(j,:);
    symbols(j,:) = msg;

    if any(symbols(j,:) ~= codewords(j,:))
      numOfErrors = numOfErrors + 1;
    end

    symbol_error_rate_baseline(i) = numOfErrors / numOfMessages;
  end
end

% --------------------------------------------------------
% 2nd Benchmark: error correction with regular LDPC code
% --------------------------------------------------------
ParityCheckMatrix = [];

symbol_error_rate_regular = zeros(num,1);

for i = 1:num
  channel.ErasureProbability = epsilon(i);
  bec_output = channel.contaiminateBitStream(codewords);
  symbols = zeros(numOfMessages, channel.BitWidth);
  numOfErrors = 0;

  for j = 1:numOfMessages
    msg = bec_output(j,:);
    symbols(j,:) = BPDecoder(msg, ParityCheckMatrix, num_iter);

    if any(symbols(j,:) ~= codewords(j,:))
      numOfErrors = numOfErrors + 1;
    end

    symbol_error_rate_regular(i) = numOfErrors / numOfMessages;
  end
end

% --------------------------------------------------------
% 3rd Benchmark: error correction with irregular LDPC code
% --------------------------------------------------------
ParityCheckMatrix = [];

symbol_error_rate_irregular = zeros(num,1);

for i = 1:num
  channel.ErasureProbability = epsilon(i);
  bec_output = channel.contaminateBitStream(codewords);
  symbols = zeros(numOfMessages, channel.BitWidth);
  numOfErrors = 0;

  for j = 1:numOfMesages
    msg = bec_output(j,:);
    symbols(j,:) = BPDecoder(msg, ParityCheckMatrix, num_iter);

    if any(symbols(j,:) ~= codewords(j,:))
      numOfErrors = numOfErrors + 1;
    end

    symbol_error_rate_irregular(i) = numOfErrors / numOfMessages;
  end
end

% --------------------------------------------------------
% Generate a plot of the results
% --------------------------------------------------------

figure(1); hold on;

% TODO: Add plot settings
