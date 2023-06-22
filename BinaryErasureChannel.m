classdef BinaryErasureChannel
  properties
    ErasureProbability      % Probability of erasing a single bit
    BitWidth                % Bits per transmitted codeword
  end

  methods
    % A setter method for ErasureProbability
    function obj = set.ErasureProbability(obj, prob)
      if prob > 1 || prob < 0
        error("The erasure probability must be a float between 0 and 1");
      end
      obj.ErasureProbability = prob;
    end

    % A getter method for ErasureProbability
    function prob = get.ErasureProbability(obj)
      prob = obj.ErasureProbability;
    end

    % A setter method for BitWidth
    function obj = set.BitWidth(obj, width)
      if width <= 0
        error("Channel Width must be a positive integer");
      end
      obj.BitWidth = width;
    end

    % A getter method for BitWidth
    function width = get.BitWidth(obj)
      width = obj.BitWidth;
    end

    % A method which simulates the "noisy"
    % properties of the binary erasure channel
    function output = contaminateBitStream(obj, input)
      if obj.ErasureProbability == 0
        output = input;
      else
        noiseMask = rand(size(input)) <= obj.ErasureProbability;
        output = double(input);
        output(noiseMask) = NaN;
      end
    end
  end
end
