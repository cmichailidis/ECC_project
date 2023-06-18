classdef BinarySymmetricChannel
  properties
    CrossOverProbability
  end

  methods
    function obj = set.CrossOverProbability(obj, epsilon)
      if epsilon > 1 || epsilon < 0
        error("The crossover probability must be a fraction between 0 and 1");
      end

      obj.CrossOverProbability = epsilon;
    end

    function epsilon = get.CrossOverProbability(obj)
      epsilon = obj.CrossOverProbability;
    end

    function output = contaminateBitStream(obj, input)
      if obj.CrossOverProbability == 0
        output = input;
      elseif obj.CrossOverProbability == 1
        output = ~input;
      else
        noiseMask = rand(size(input)) < obj.CrossOverProbability;
        output = zeros(size(input));
        output(noiseMask == 0) =  input(noiseMask == 0);
        output(noiseMask == 1) = ~input(noiseMask == 1);
      end
    end
  end
end

