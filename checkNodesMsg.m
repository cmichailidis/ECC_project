function msg = checkNodesMsg(x, i, H)
msg = nan;

check_nodes = H(:,i) == 1;

checks = H(check_nodes, :);
checks(:, i) = 0;

msgs = nan(size(checks, 1),1);

for j = 1:size(checks,1)
    c = checks(j, :) == 1;
    if ~ any(isnan(x(c)))
        msgs(j) = mod(sum(x(c)), 2);
    end
end

if ismember(0, msgs)
    msg = 0;
elseif ismember(1, msgs)
    msg = 1;
end
end