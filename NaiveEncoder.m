classdef NaiveEncoder
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

    function codewords = encodeSymbols(obj, messages)
      codewords = de2bi(messages, obj.BlockBitLength, 'left-msb');
    end
  end
end
