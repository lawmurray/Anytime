function [r1, r2] = toy(N, T, rho, k, theta, p, anytime)
  % sample
  X = zeros(T,N);
  for (n = 1:N)
    t = 1;
    h = 0;

    if (anytime)
      x1 = gamrnd(k + p, theta);
      u1 = gamcdf(x1, k, theta);
      n1 = norminv(u1);
      n0 = normrnd(rho*n1, sqrt(1.0 - rho^2));
      u0 = normcdf(n0);
      x0 = gaminv(u0, k, theta);
      h = gamrnd(x1^p/theta, theta);
      h = unifrnd(0, h); % part way through computation
      X(t, n) = x0;
      t = t + 1;
      while h > 1 && t <= T
        X(t, n) = x0;
        t = t + 1;
        h = h - 1;
      end
      x0 = x1;
      n0 = n1;
    else
      x0 = gamrnd(k, theta);
      u0 = gamcdf(x0, k, theta);
      n0 = norminv(u0);
    end

    while (t <= T)
      n1 = normrnd(rho*n0, sqrt(1.0 - rho^2));
      u1 = normcdf(n1);
      x1 = gaminv(u1, k, theta);
      h = h + gamrnd(x1^p/theta, theta);
      while h > 1 && t <= T
        X(t, n) = x0;
        t = t + 1;
        h = h - 1;
      end
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
