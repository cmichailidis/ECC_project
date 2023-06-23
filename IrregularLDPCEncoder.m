classdef IrregularLDPCEncoder
  properties (Access = private)
    GeneratorMatrix
    SymbolBitWidth
    CodewordBitWidth
  end

  methods (Access = public)
    function obj = IrregularLDPCEncoder(genMatrix)
      obj.GeneratorMatrix = genMatrix;
      obj.SymbolBitWidth = size(genMatrix, 1);
      obj.CodewordBitWidth = size(genMatrix, 2);
    end

    function codewords = encodeSymbols(obj, symbols)
      symbolsBin = de2bi(symbols, obj.SymbolBitWidth, 'left-msb');
      codewords = mod(symbolsBin * obj.GeneratorMatrix, 2);
    end
  end
end
