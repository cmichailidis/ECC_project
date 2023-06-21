% Naive encoding algorithm. No parity bits are used.
% There is no distinction between symbols and codewords
% Symbols can be retrieved successfully, if no errors
% occur in the corresponding codeword
classdef NaiveEncoder
  methods
    function codewords = encodeSymbols(obj, messages)
      codewords = messages(:);
    end
  end
end
