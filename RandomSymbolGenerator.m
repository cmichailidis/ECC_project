classdef RandomSymbolGenerator
  properties
    SymbolBitLength
  end

  methods
    function obj = set.SymbolBitLength(obj, length)
      if length <= 0
        error("Symbol Length must be a positive integer");
      end
      obj.SymbolBitLength = length;
    end

    function length = get.SymbolBitLength(obj)
      length = obj.SymbolBitLength;
    end

    function symbols = generateSymbols(obj, num)
      if num <= 0
        error("The number of symbols must be a positive integer");
      end

      symbols = randi([0, 2 ^ obj.SymbolBitLength - 1], [num, 1]);
    end
  end
end

