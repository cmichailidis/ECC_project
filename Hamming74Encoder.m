classdef Hamming74Encoder
  properties (Access = private)
    GeneratorMatrix = [
      1 0 0 0  1 1 0;
      0 1 0 0  0 1 1;
      0 0 1 0  1 0 1;
      0 0 0 1  1 1 1; ];
  end

  methods
    function codewords = encodeSymbols(obj, messages)
      bin = de2bi(messages, 4, 'left-msb');
      codewords = bin * obj.GeneratorMatrix;
      codewords = mod(codewords, 2);
    end
  end
end

