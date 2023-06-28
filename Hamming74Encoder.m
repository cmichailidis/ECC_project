% Error correction with a Hamming (7,4) code
% Every codeword contains 4 data bits and 3
% parity bits. The minimum hamming distance
% is 3. Therefore this technique can successfully
% correct up to 1 flipped bit.

classdef Hamming74Encoder
  properties (Access = private)
    GeneratorMatrix = [
      1 0 0 0  1 1 0;
      0 1 0 0  0 1 1;
      0 0 1 0  1 0 1;
      0 0 0 1  1 1 1; ];

    LookUpTableBin = [  % Symbol -> Codeword
      0 0 0 0 0 0 0;    % 0b0000 -> 0b0000000
      0 0 0 1 1 1 1;    % 0b0001 -> 0b0001111
      0 0 1 0 1 0 1;    % 0b0010 -> 0b0010101
      0 0 1 1 0 1 0;    % 0b0011 -> 0b0011010
      0 1 0 0 0 1 1;    % 0b0100 -> 0b0100011
      0 1 0 1 1 0 0;    % 0b0101 -> 0b0101100
      0 1 1 0 1 1 0;    % 0b0110 -> 0b0110110
      0 1 1 1 0 0 1;    % 0b0111 -> 0b0111001
      1 0 0 0 1 1 0;    % 0b1000 -> 0b1000110
      1 0 0 1 0 0 1;    % 0b1001 -> 0b1001001
      1 0 1 0 0 1 1;    % 0b1010 -> 0b1010011
      1 0 1 1 1 0 0;    % 0b1011 -> 0b1011100
      1 1 0 0 1 0 1;    % 0b1100 -> 0b1100101
      1 1 0 1 0 1 0;    % 0b1101 -> 0b1101010
      1 1 1 0 0 0 0;    % 0b1110 -> 0b1110000
      1 1 1 1 1 1 1; ]; % 0b1111 -> 0b1111111
  end

  methods (Access = public)
    function codewords = encodeSymbols(obj, symbols)
      idx = symbols(:) + 1;
      codewords = obj.LookUpTableBin(idx,:);
    end
  end
end

