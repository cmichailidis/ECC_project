function Y = BEC(X, epsilon)
R = rand(size(X));
idx = R <= epsilon;
Y = X;
Y(idx) = nan;
end