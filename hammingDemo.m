clear all; close all; clc;
pkg load communications;

rsg = RandomSymbolGenerator;
encoder = Hamming74Encoder;
channel = BinarySymmetricChannel;
decoder = Hamming74Decoder;

rsg.SymbolBitLength = 4;
channel.BitWidth = 7;

numOfMessages = 2000;
messages = rsg.generateSymbols(numOfMessages);

epsilon = 5 * 0.1 .^ [1:9];
error_rate = zeros(9,1);

for i = 1:9
  disp(i);
  channel.CrossOverProbability = epsilon(i);
  channel_input = encoder.encodeSymbols(messages);
  channel_output = channel.contaminateBitStream(channel_input);
  received_messages = decoder.decodeCodeWords(channel_output);
  numOfErrors = sum(received_messages ~= messages);
  error_rate(i) = numOfErrors / numOfMessages;
end

figure(1);
loglog(epsilon, error_rate);

