function x_hat = BPDecoder(y,H)
%BPDecoder Implementetion of the Belief Propagation  Decoder for BEC
%channel
%   Detailed explanation DOES NOT go here

[~, n] = size(H);

num_iter = 10;

x_hat = y;

for iter = 2 : num_iter+1
    for i = 1 : n
        msg = checkNodesMsg(x_hat, i, H);
        if ~isnan(msg)
            x_hat(i) = msg;
        end
    end
end
end