function [eff, out] = GetSingleAdditiveEfficiency(x, y, k)

    K = size(x,2);
    m = size(x,1);
    n = size(y,1);

    f = zeros(n+m+1,1);
    for i=1:n
        f(i) = -y(i,k);
    end
    for j=1:m
        f(n+j) = x(j,k);
    end
    f(n+m+1) = 1;
    
    A = [y' -x' -ones(K,1)];
    b = zeros(K,1);

    lb = ones(n+m+1,1);
    lb(n+m+1) = -inf;

    options = optimoptions('linprog');
    options.Display = 'off';
    sol = linprog(f,A,b,[],[],lb,[],[],options);
    
    u = sol(1:n);
    v = sol(n+(1:m));
    v0 = sol(n+m+1);
    
    Y = u'*y(:,k);
    X = v'*x(:,k);
    eff = Y/(X+v0);
    eff = round(eff*10000)/10000;
    
    out.u = u;
    out.v = v;
    out.v0 = v0;
    out.eff = eff;

end