% Error correction with a Hamming (7,4) code
% Every codeword contains 4 data bits and 3
% parity bits. The minimum hamming distance
% is 3. Therefore this technique can successfully
% correct up to 1 flipped bit.

classdef Hamming74Decoder
  properties (Access = private)
    ParityCheckMatrix = [
      1 0 1 1   1 0 0;
      1 1 0 1   0 1 0;
      0 1 1 1   0 0 1;  ];

    LookUpTableBin = [   % Symbol -> Codeword
      0 0 0 0 0 0 0;     % 0b0000 -> 0b0000000
      0 0 0 1 1 1 1;     % 0b0001 -> 0b0001111
      0 0 1 0 1 0 1;     % 0b0010 -> 0b0010101
      0 0 1 1 0 1 0;     % 0b0011 -> 0b0011010
      0 1 0 0 0 1 1;     % 0b0100 -> 0b0100011
      0 1 0 1 1 0 0;     % 0b0101 -> 0b0101100
      0 1 1 0 1 1 0;     % 0b0110 -> 0b0110110
      0 1 1 1 0 0 1;     % 0b0111 -> 0b0111001
      1 0 0 0 1 1 0;     % 0b1000 -> 0b1000110
      1 0 0 1 0 0 1;     % 0b1001 -> 0b1001001
      1 0 1 0 0 1 1;     % 0b1010 -> 0b1010011
      1 0 1 1 1 0 0;     % 0b1011 -> 0b1011100
      1 1 0 0 1 0 1;     % 0b1100 -> 0b1100101
      1 1 0 1 0 1 0;     % 0b1101 -> 0b1101010
      1 1 1 0 0 0 0;     % 0b1110 -> 0b1110000
      1 1 1 1 1 1 1; ];  % 0b1111 -> 0b1111111

     ErrorPatternBin = [
      0 0 0 0 0 0 0;                        % syndrome 000
      0 0 0 0 0 0 1;                        % syndrome 001
      0 0 0 0 0 1 0;                        % syndrome 010
      0 1 0 0 0 0 0;                        % syndrome 011
      0 0 0 0 1 0 0;                        % syndrome 100
      0 0 1 0 0 0 0;                        % syndrome 101
      1 0 0 0 0 0 0;                        % syndrome 110
      0 0 0 1 0 0 0;                        % syndrome 111
     ];

     SyndromeTableBin = [
      0 0 0;
      0 0 1;
      0 1 0;
      1 0 0;
      1 1 1;
      1 0 1;
      0 1 1;
      1 1 0;
     ];
  end

  methods (Access = public)
    function symbols = decodeCodeWords(obj, codewords)
      % -----------------------------------------------------
      %     Naive decoding with minimum hamming distance
      % -----------------------------------------------------

      %% Total number of received messages
      numOfMessages = size(codewords, 1);

      %% Nasty broadcasting
      %codewords = repmat(codewords, 1, 1, 16);
      %codewords = permute(codewords, [1 3 2]);
      %LUT = repmat(uint8(obj.LookUpTableBin), 1, 1, numOfMessages);
      %LUT = permute(LUT, [3 1 2]);

      %% Hamming distance between every received message and valid codeword
      %hammingDist = xor(codewords, LUT);
      %hammingDist = sum(hammingDist, 3);

      %% Minimum-Hamming-Distance decoding
      %[~, idx] = min(hammingDist, [], 2);
      %symbols = idx - 1;

      % -----------------------------------------------------
      %             Decoding with Syndrome Tables
      % -----------------------------------------------------
      syndromesBin = mod(codewords * obj.ParityCheckMatrix', 2);
      idx = bi2de(syndromesBin, 'left-msb') + 1;
      errorsBin = obj.ErrorPatternBin(idx,:);
      correctedBin = mod(codewords + errorsBin, 2);
      symbolsBin = correctedBin(:, 1:4);
      symbols = bi2de(symbolsBin, 'left-msb');
    end
  end
end

