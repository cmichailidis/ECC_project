classdef Hadamard164Decoder
  properties (Access = private)
    ParityCheckMatrix = [
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
    function symbols = decodeCodeWords(obj, codewordsDec)
      codewordsDec = codewordsDec(:);
      codewordsBin = uint16(de2bi(codewordsDec, 16, 'left-msb'));
      numOfMessages = numel(codewordsDec);

      codewordsBin = repmat(codewordsBin, 1, 1, 16);
      codewordsBin = permute(codewordsBin, [1 3 2]);

      LUT = repmat(uint16(obj.LookUpTableBin), 1, 1, numOfMessages);
      LUT = permute(LUT, [3 1 2]);

      hammingDist = xor(codewordsBin, LUT);
      hammingDist = sum(hammingDist, 3);

     [~, idx] = min(hammingDist, [], 2);
     symbols = idx - 1;
    end
  end
end
