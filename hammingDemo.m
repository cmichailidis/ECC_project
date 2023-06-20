clear all; close all; clc;
pkg load communications;

t0 = cputime;

rsg = RandomSymbolGenerator;
encoder = Hamming74Encoder;
channel = BinarySymmetricChannel;
decoder = Hamming74Decoder;

rsg.SymbolBitLength = 4;
channel.BitWidth = 7;

numOfMessages = 100000;
messages = rsg.generateSymbols(numOfMessages);

epsilon = 5 * logspace(-5, -1, 20);
hamming_error_rate = zeros(size(epsilon));
naive_error_rate = zeros(size(epsilon));

for i = 1:numel(epsilon)
  disp(i);
  channel.CrossOverProbability = epsilon(i);
  channel_input = encoder.encodeSymbols(messages);
  channel_output = channel.contaminateBitStream(channel_input);
  received_messages = decoder.decodeCodeWords(channel_output);
  numOfErrors = sum(received_messages ~= messages);
  hamming_error_rate(i) = numOfErrors / numOfMessages;
end

encoder = NaiveEncoder;
decoder = NaiveDecoder;
decoder.BlockBitLength = 4;
channel.BitWidth = 4;

for i = 1:numel(epsilon)
  disp(i);
  channel.CrossOverProbability = epsilon(i);
  channel_input = encoder.encodeSymbols(messages);
  channel_output = channel.contaminateBitStream(channel_input);
  received_messages = decoder.decodeCodeWords(channel_output);
  numOfErrors = sum(received_messages ~= messages);
  naive_error_rate(i) = numOfErrors / numOfMessages;
end

figure(1);
loglog(epsilon, hamming_error_rate, epsilon, naive_error_rate);
xlabel('Cross-over probability');
ylabel('Decoding error rate');
grid on;
legend('Hamming (7,4) encoder', 'Naive encoder');

tf = cputime;

printf("Execution time %f seconds\n", tf - t0);
