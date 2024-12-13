function [eff, out] = GetSingleOOBCCEfficiency(x, y, k)

    K = size(x,2);
    m = size(x,1);
    n = size(y,1);

    f = zeros(n+m+1,1);
    for j=1:m
        f(n+j) = x(j,k);
    end
    f(n+m+1) = 1;
    
    Aeq = zeros(1,n+m+1);
    for i=1:n
        Aeq(i) = y(i,k);
    end
    beq = 1;

    A = [y' -x' -ones(K,1)];
    b = zeros(K,1);

    lb = zeros(n+m+1,1);
    lb(n+m+1) = -inf;

    options = optimoptions('linprog');
    options.Display = 'off';
    [sol, eff] = linprog(f,A,b,Aeq,beq,lb,[],[],options);
    
    eff = 1/eff;
    eff = round(eff*10000)/10000;
    
    u = sol(1:n);
    v = sol(n+(1:m));
    v0 = sol(n+m+1);
    
    out.u = u;
    out.v = v;
    out.v0 = v0;
    out.eff = eff;

end