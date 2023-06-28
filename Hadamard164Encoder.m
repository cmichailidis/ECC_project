% Error correction with a Hadamard (16,4) code
% Every 4-bit symbol is transformed into a 16-bit
% codeword. The minimum hamming distance between
% the codewords is 8. Therefore this technique
% can successfully correct up to 3 flipped bits.

classdef Hadamard164Encoder
  properties (Access = private)
    GeneratorMatrix = [
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
    function codewords = encodeSymbols(obj, symbols)
      idx = symbols(:) + 1;
      codewords = obj.LookUpTableBin(idx,:);
    end
  end
end
