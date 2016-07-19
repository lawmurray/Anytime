function [r1, r2] = toy2(N, T, rho, k, theta, p, anytime)
  % sample
  X = zeros(T,N);
  for (n = 1:N)
    t = 1;
    h = 0;
    x0 = gamrnd(k, theta);
    u0 = gamcdf(x0, k, theta);
    z0 = norminv(u0);
    if (anytime)
      x1 = gamrnd(k + p, theta);
      h = gamrnd(x1^p/theta, theta);
      h = unifrnd(0, h); % part way through computation
      X(t, n) = x0;
      t = t + 1;
      while h > 1 && t <= T
        X(t, n) = x0;
        t = t + 1;
        h = h - 1;
      end
    else
      x1 = gamrnd(k, theta);
      X(t, n) = x1;
      t = t + 1;
      h = 0;
    end
    u1 = gamcdf(x1, k, theta);
    z1 = norminv(u1);

    while (t <= T)
      z2 = normrnd(rho*z0, sqrt(1.0 - rho^2));
      u2 = normcdf(z2);
      x2 = gaminv(u2, k, theta);
      h = h + gamrnd(x2^p/theta, theta);
      while h > 1 && t <= T
        X(t, n) = x1;
        t = t + 1;
        h = h - 1;
      end
      x0 = x1;
      z0 = z1;
      x1 = x2;
      z1 = z2;
    end
  end
  
  % probability plot correlation coefficients
  X = X';
  r1 = zeros(T,1);
  r2 = zeros(T,1);
  for (t = 1:T)
    [q1, x] = ecdf(X(:,t));
    q2 = gamcdf(x, k, theta);
    q3 = gamcdf(x, k + p, theta);
    r1(t) = corr(q1, q2);
    r2(t) = corr(q1, q3);
  end
end
