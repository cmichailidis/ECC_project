%
%
classdef BinarySymmetricChannel
  properties
    CrossOverProbability        % Probability of flipping a single bit
    BitWidth                    % Bits per transmitted codeword
  end

  methods (Access = public)
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

    % Setter method for BitWidth
    function obj = set.BitWidth(obj, width)
      if width <= 0
        error("Channel width must be a positive integer");
      end
      obj.BitWidth = width;
    end

    % Getter method for BitWidth
    function width = get.BitWidth(obj)
      width = obj.BitWidth;
    end

    % A method which simulates the "noisy"
    % properties of a binary symmetric channel
    function output = contaminateBitStream(obj, input)
      if obj.CrossOverProbability == 0
        output = input;
      else
        inputBits = de2bi(input, obj.BitWidth, 'left-msb');
        noiseMask = rand(size(inputBits)) <= obj.CrossOverProbability;
        outputBits = inputBits;
        outputBits(noiseMask) = ~inputBits(noiseMask);
        output = bi2de(outputBits, 'left-msb');
      end
    end
  end
end

