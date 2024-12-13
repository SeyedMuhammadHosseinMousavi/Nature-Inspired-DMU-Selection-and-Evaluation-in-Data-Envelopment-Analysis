function E = GetCCREfficiency(x, y)

    K = size(x,2);
    E = zeros(K,1);
    for k=1:K
        E(k) = GetSingleCCREfficiency(x, y, k);
    end

end