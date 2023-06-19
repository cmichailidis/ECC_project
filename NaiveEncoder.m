% Naive encoding algorithm.
% No parity bits are used.
% Every symbol is transmitted as it is
classdef NaiveEncoder
  methods (Access = public)
    function codewords = encodeSymbols(obj, messages)
      codewords = messages(:);
    end
  end
end
