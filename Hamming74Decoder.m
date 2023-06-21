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

    LookUpTableDec = [
        0;               % 00 ->   0
       15;               % 01 ->  15
       21;               % 02 ->  21
       26;               % 03 ->  26
       35;               % 04 ->  35
       44;               % 05 ->  44
       54;               % 06 ->  54
       57;               % 07 ->  57
       70;               % 08 ->  70
       73;               % 09 ->  73
       83;               % 10 ->  83
       92;               % 11 ->  92
      101;               % 12 -> 101
      106;               % 13 -> 106
      112;               % 14 -> 112
      127;               % 15 -> 127
     ];
  end

  methods (Access = public)
    function symbols = decodeCodeWords(obj, codewordsDec)
      % Convert decimal codewords to binary vectors
      codewordsDec = codewordsDec(:);
      codewordsBin = uint8(de2bi(codewordsDec, 7, 'left-msb'));
      numOfMessages = numel(codewordsDec);

      % Nasty broadcasting
      codewordsBin = repmat(codewordsBin, 1, 1, 16);
      codewordsBin = permute(codewordsBin, [1 3 2]);
      LUT = repmat(uint8(obj.LookUpTableBin), 1, 1, numOfMessages);
      LUT = permute(LUT, [3 1 2]);

      % Hamming distance between every received message and valid codeword
      hammingDist = xor(codewordsBin, LUT);
      hammingDist = sum(hammingDist, 3);

      % Minimum-Hamming-Distance decoding
      [~, idx] = min(hammingDist, [], 2);
      symbols = idx - 1;
    end
  end
end

