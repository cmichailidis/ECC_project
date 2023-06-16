function y = bsc (x, epsilon)
  noise_mask = rand(size(x));
  noise_mask = noise_mask <= epsilon;

  y = zeros(size(x));
  y(noise_mask == 1) = ~x(noise_mask == 1);
  y(noise_mask == 0) =  x(noise_mask == 0);
end
