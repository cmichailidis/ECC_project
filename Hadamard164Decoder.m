% Error correction with a Hadamard (16,4) code
% Every 4-bit symbol is transformed into a 16-bit
% codeword. The minimum hamming distance between
% the codewords is 8. Therefore this technique
% can successfully correct up to 3 flipped bits.

classdef Hadamard164Decoder
  properties (Access = private)
    ParityCheckMatrix = [
    0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;
    0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1;
    0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1;
    0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1; ];

    LookUpTableBin = [                      % Symbol -> Codeword
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;      % 0b0000 -> 0b0000000000000000
      0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1;      % 0b0001 -> 0b0101010101010101
      0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1;      % 0b0010 -> 0b0011001100110011
      0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0;      % 0b0011 -> 0b0110011001100110
      0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1;      % 0b0100 -> 0b0000111100001111
      0 1 0 1 1 0 1 0 0 1 0 1 1 0 1 0;      % 0b0101 -> 0b0101101001011010
      0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0;      % 0b0110 -> 0b0011110000111100
      0 1 1 0 1 0 0 1 0 1 1 0 1 0 0 1;      % 0b0111 -> 0b0110100101101001
      0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;      % 0b1000 -> 0b0000000011111111
      0 1 0 1 0 1 0 1 1 0 1 0 1 0 1 0;      % 0b1001 -> 0b0101010110101010
      0 0 1 1 0 0 1 1 1 1 0 0 1 1 0 0;      % 0b1010 -> 0b0011001111001100
      0 1 1 0 0 1 1 0 1 0 0 1 1 0 0 1;      % 0b1011 -> 0b0110011010011001
      0 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0;      % 0b1100 -> 0b0000111111110000
      0 1 0 1 1 0 1 0 1 0 1 0 0 1 0 1;      % 0b1101 -> 0b0101101010100101
      0 0 1 1 1 1 0 0 1 1 0 0 0 0 1 1;      % 0b1110 -> 0b0011110011000011
      0 1 1 0 1 0 0 1 1 0 0 1 0 1 1 0; ];   % 0b1111 -> 0b0110100110010110
  end

  methods (Access = public)
    function symbols = decodeCodeWords(obj, codewords)
      % Total number of received messages
      numOfMessages = size(codewords, 1);

      % Nasty broadcasting
      codewords = repmat(codewords, 1, 1, 16);
      codewords = permute(codewords, [1 3 2]);
      LUT = repmat(uint16(obj.LookUpTableBin), 1, 1, numOfMessages);
      LUT = permute(LUT, [3 1 2]);

      % Hamming distance between every received message and valid codeword
      hammingDist = xor(codewords, LUT);
      hammingDist = sum(hammingDist, 3);

      % Minimum-Hamming-Distance decoding
     [~, idx] = min(hammingDist, [], 2);
     symbols = idx - 1;
    end
  end
end
