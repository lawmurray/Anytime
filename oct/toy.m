function [r1, r2] = toy(N, T, rho, k, theta, p, anytime)
  % sample
  X = zeros(T,N);
  for (n = 1:N)
    t = 1;

    if (anytime)
      x1 = gamrnd(k + p, theta);
      u1 = gamcdf(x1, k, theta);
      n1 = norminv(u1);
      n2 = normrnd(rho*n1, 1.0 - rho**2);
      u2 = normcdf(n2);
      x0 = gaminv(u2, k, theta);
      h = poissrnd(x1**p);
      if (h > 0)
        h = h - randi(h); % part way through computation
        X(t:min(T, t + h - 1), n) = x0;
        t = t + h;
      end
    else
      x0 = gamrnd(k, theta);
    end

    while (t <= T)
      u1 = gamcdf(x0, k, theta);
      n1 = norminv(u1);
      n2 = normrnd(rho*n1, 1.0 - rho**2);
      u2 = normcdf(n2);
      x1 = gaminv(u2, k, theta);
      h = poissrnd(x1**p);
      if (h > 0)
        X(t:(t + h - 1),n) = x0;
      end
      t = t + h;
      x0 = x1;
    end
  end
  
  % probability plot correlation coefficients
  X = X';
  r1 = zeros(T,1);
  r2 = zeros(T,1);
  for (t = 1:T)
    q1 = empirical_cdf(X(:,t), X(:,t));
    q2 = gamcdf(X(:,t), k, theta);
    q3 = gamcdf(X(:,t), k + p, theta);
    r1(t) = corr(q1, q2);
    r2(t) = corr(q1, q3);
  end
end
