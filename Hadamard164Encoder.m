classdef Hadamard164Encoder
  properties (Access = private)
    GeneratorMatrix = [
    0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;
    0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1;
    0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1;
    0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1; ];

    LookUpTableBin = [
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1;
      0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1;
      0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0;
      0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1;
      0 1 0 1 1 0 1 0 0 1 0 1 1 0 1 0;
      0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0;
      0 1 1 0 1 0 0 1 0 1 1 0 1 0 0 1;
      0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;
      0 1 0 1 0 1 0 1 1 0 1 0 1 0 1 0;
      0 0 1 1 0 0 1 1 1 1 0 0 1 1 0 0;
      0 1 1 0 0 1 1 0 1 0 0 1 1 0 0 1;
      0 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0;
      0 1 0 1 1 0 1 0 1 0 1 0 0 1 0 1;
      0 0 1 1 1 1 0 0 1 1 0 0 0 0 1 1;
      0 1 1 0 1 0 0 1 1 0 0 1 0 1 1 0; ];

    LookUpTableDec = [
            0;
        21845;
        13107;
        26214;
         3855;
        23130;
        15420;
        26985;
          255;
        21930;
        13260;
        26265;
         4080;
        23205;
        15555;
        27030; ];
  end

  methods (Access = public)
    function codewords = encodeSymbols(obj, messages)
      codewords = obj.LookUpTableDec(messages(:)+1);
    end
  end
end
