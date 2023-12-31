function X_hat = BPDecoder(Y,H, num_iter)
%BPDecoder Implementetion of the Belief Propagation  Decoder for BEC
%channel
%   Detailed explanation DOES NOT go here

[m, n] = size(H);
X = Y;

for iter = 1 : num_iter
    for i = 1 : n
        messages = X(i, :);
        for j = 1 : m
            % Find where var node i empleketai ston check node j
            % and it's equal to ?
            bool = H(j,i)*isnan(X(i,:));
            if any(bool)
                idx = (1:n ~= i) & logical(H(j,:));
                msg = mod(sum(X(idx,:)), 2);
                if ~isnan(msg)
                    message = msg;
                end
                messages(~isnan(msg)) = msg(~isnan(msg));
            end
        end
        X(i,:) = messages;
    end
end
X_hat = X;
end