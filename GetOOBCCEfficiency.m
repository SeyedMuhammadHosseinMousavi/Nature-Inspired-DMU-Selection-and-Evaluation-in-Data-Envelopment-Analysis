function E = GetOOBCCEfficiency(x, y)

    K = size(x,2);
    E = zeros(K,1);
    for k=1:K
        E(k) = GetSingleOOBCCEfficiency(x, y, k);
    end

end