classdef Hamming74Decoder
  properties
    ParityCheckMatrix = [
      1 0 1 1   1 0 0;
      1 1 0 1   0 1 0;
      0 1 1 1   0 0 1;  ];
  end

  methods
    function symbols = decodeCodeWords(obj, codewords)
      syndrome = mod(codewords * obj.ParityCheckMatrix', 2)
      symbols = syndrome;
    end
  end
end

