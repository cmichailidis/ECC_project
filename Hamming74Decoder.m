classdef Hamming74Decoder
  properties (Access = private)
    ParityCheckMatrix = [
      1 0 1 1   1 0 0;
      1 1 0 1   0 1 0;
      0 1 1 1   0 0 1;  ];

    LookUpTableBin = uint8([
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
      1 1 1 1 1 1 1; ]); % 0b1111 -> 0b1111111

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
    function symbols = decodeCodeWords(obj, codewords)
      % Array of hamming distances
      dist = zeros(numel(codewords), numel(obj.LookUpTableDec));

      for i = 1:numel(codewords)
        for j = 1:numel(obj.LookUpTableDec)
          dist(i,j) = sum(bitget(bitxor(codewords(i),obj.LookUpTableDec(j)),1:8));
        end
      end

      % For every received codeword choose the
      % template which minimizes the hamming distance
      [~, argmin] = min(dist,[],2);
      symbols = argmin - 1;
    end
  end
end

