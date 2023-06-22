function x_hat = BPDecoder(y,H, num_iter)
%BPDecoder Implementetion of the Belief Propagation  Decoder for BEC
%channel
%   Detailed explanation DOES NOT go here

[m, n] = size(H);
x = y;

for iter = 1 : num_iter
    for i = 1 : n
        message = x(i);
        for j = 1 : m
            if H(j,i) == 1 & isnan(x(i))
                idx = (1:n ~= i) & logical(H(j,:));
                msg = mod(sum(x(idx)), 2);
                if ~isnan(msg)
                    message = msg;
                end
            end
        end
        x(i) = message;
    end
end
x_hat = x;
end