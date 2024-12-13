function [eff, out] = GetSingleIOBCCEfficiency(x, y, k)

    K = size(x,2);
    m = size(x,1);
    n = size(y,1);

    f = zeros(n+m+1,1);
    for i=1:n
        f(i) = -y(i,k);
    end
    f(n+m+1) = -1;
    
    Aeq = zeros(1,n+m+1);
    for j=1:m
        Aeq(n+j) = x(j,k);
    end
    beq = 1;

    A = [y' -x' ones(K,1)];
    b = zeros(K,1);

    lb = zeros(n+m+1,1);
    lb(n+m+1) = -inf;

    options = optimoptions('linprog');
    options.Display = 'off';
    [sol, eff] = linprog(f,A,b,Aeq,beq,lb,[],[],options);
    
    eff = -eff;
    eff = round(eff*10000)/10000;
    
    u = sol(1:n);
    v = sol(n+(1:m));
    u0 = sol(n+m+1);
    
    out.u = u;
    out.v = v;
    out.u0 = u0;
    out.eff = eff;

end