% Naive decoding algorithm. No parity bits are used.
% There is no distinction between symbols and codewords
% Symbols can be retrieved successfully, if no errors
% occur in the corresponding codeword
classdef NaiveDecoder
  methods
    function symbols = decodeCodeWords(obj, codewords)
      symbolsBin = codewords;
      symbols = bi2de(symbolsBin, 'left-msb');
    end
  end
end

