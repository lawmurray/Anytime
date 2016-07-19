function [r1, r2] = toy(N, T, rho, k, theta, p, anytime)
  % sample
  X = zeros(T,N);
  for (n = 1:N)
    t = 1;
    h = 0;

    if (anytime)
      x = gamrnd(k + p, theta);
      u = gamcdf(x, k, theta);
      z = norminv(u);
      h = gamrnd(x^p/theta, theta);
      h = unifrnd(0, h); % part way through computation
      X(t, n) = x;
      t = t + 1;
      while h > 1 && t <= T
        X(t, n) = x;
        t = t + 1;
        h = h - 1;
      end
    else
      x = gamrnd(k, theta);
      u = gamcdf(x, k, theta);
      z = norminv(u);
    end

    while (t <= T)
      z = normrnd(rho*z, sqrt(1.0 - rho^2));
      u = normcdf(z);
      x = gaminv(u, k, theta);
      h = h + gamrnd(x^p/theta, theta);
      while h > 1 && t <= T
        X(t, n) = x;
        t = t + 1;
        h = h - 1;
      end
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
