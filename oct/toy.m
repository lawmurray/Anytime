function [r1, r2] = toy(N, T, rho, k, theta, p, anytime)
  % sample
  X = zeros(T,N);
  for (n = 1:N)
    t = 1;

    if (anytime)
      x1 = gamrnd(k + p, theta);
      u1 = gamcdf(x1, k, theta);
      n1 = norminv(u1);
      n0 = normrnd(rho*n1, 1.0 - rho^2);
      u0 = normcdf(n0);
      x0 = gaminv(u0, k, theta);
      h = poissrnd(x1^p);
      h = h - (randi(h + 1) - 1); % part way through computation
      if h > 0
        X(t:min(T, t + h - 1), n) = x0;
        t = t + h;
      end
      x0 = x1;
      n0 = n1;
    else
      x0 = gamrnd(k, theta);
      u0 = gamcdf(x0, k, theta);
      n0 = norminv(u0);
    end

    while (t <= T)
      n1 = normrnd(rho*n0, 1.0 - rho^2);
      u1 = normcdf(n1);
      x1 = gaminv(u1, k, theta);
      h = poissrnd(x1^p);
      if (h > 0)
        X(t:(t + h - 1),n) = x0;
      end
      t = t + h;
      x0 = x1;
      n0 = n1;
    end
  end
  
  % probability plot correlation coefficients
  X = X';
  r1 = zeros(T,1);
  r2 = zeros(T,1);
  for (t = 1:T)
    [q1,x] = ecdf(X(:,t));
    q2 = gamcdf(x, k, theta);
    q3 = gamcdf(x, k + p, theta);
    r1(t) = corr(q1, q2);
    r2(t) = corr(q1, q3);
  end
end
