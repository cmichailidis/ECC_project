%
%

classdef BinarySymmetricChannel
  properties
    CrossOverProbability        % Probability of flipping a single bit
  end

  methods
    % Setter method for CrossOverProbability
    function obj = set.CrossOverProbability(obj, epsilon)
      if epsilon > 0.5 || epsilon < 0
        error("The crossover probability must be a fraction between 0 and 0.5");
      end

      obj.CrossOverProbability = epsilon;
    end

    % Getter method for CrossOverProbability
    function epsilon = get.CrossOverProbability(obj)
      epsilon = obj.CrossOverProbability;
    end

    % A method which simulates the "noisy"
    % properties of a binary symmetric channel
    function output = contaminateBitStream(obj, input)
      if obj.CrossOverProbability == 0
        output = input;
      else
        noiseMask = rand(size(input)) <= obj.CrossOverProbability;
        output = input;
        output(noiseMask) = ~input(noiseMask);
      end
    end
  end
end

