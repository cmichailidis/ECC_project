classdef NaiveDecoder
  properties
    BlockBitLength
  end

  methods
    function obj = set.BlockBitLength(obj, length)
      if length <= 0
        error("Block Bit Length must be a positive integer");
      end
      obj.BlockBitLength = length;
    end

    function length = get.BlockBitLength(obj)
      length = obj.BlockBitLength;
    end

    function symbols = decodeCodeWords(obj, codewords)
      if size(codewords, 2) ~= obj.BlockBitLength
        error("Invalid input dimensions");
      end
      symbols = bi2de(codewords, 'left-msb');
    end
  end
end

