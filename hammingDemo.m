clear all; close all; clc;

encoder = Hamming74Encoder;
decoder = Hamming74Decoder;
channel = BinarySymmetricChannel;
channel.CrossOverProbability = 0.1;

transmitted_symbols = [0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15;];
transmitted_data = encoder.encodeSymbols(transmitted_symbols)
received_data = channel.contaminateBitStream(transmitted_data)
received_symbols = decoder.decodeCodeWords(received_data);
