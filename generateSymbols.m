function m = generateSymbols (n, k)
  m = rand(n,k);
  m(m>=0.5) = 1;
  m(m<=0.5) = 0;
end
