%
% Simulates K-chains for the toy model example, returns the probability
% plot correlation coefficients against the target and anytime
% distriutions.
%
function r = toyK(K, T, N, rho, alpha, theta, p, correct, anytime)
  if (correct)
    X = zeros(K - 1, T, N);
  else
    X = zeros(K, T, N);
  end
  
  for n = 1:N
    % initialise K chains 
    x = gamrnd(alpha, theta, K, 1);

    % simulate chains one by one
    k = 1;
    t = 1;
    h = 0;
    while t <= T
      u = gamcdf(x(k), alpha, theta);
      z = norminv(u);
      z = normrnd(rho*z, sqrt(1.0 - rho^2));
      u = normcdf(z);
      x(k) = gaminv(u, alpha, theta);
      h = h + gamrnd(x(k)^p/theta, theta);
      while h > 1 && t <= T
        if (correct)
          X(:,t,n) = x([1:(k-1) (k+1):K]);
        else
          X(:,t,n) = x;
        end
        t = t + 1;
        h = h - 1;
      end
      
      % next chain
      k = k + 1;
      if (k > K) 
        k = 1;
      end
    end
  end
  
  % probability plot correlation coefficients
  r = zeros(T,1);
  for t = 1:T
    x = X(:,t,:);
    [q1,x] = ecdf(x(:));
    if anytime
      q2 = gamcdf(x, alpha + p, theta);
    else
      q2 = gamcdf(x, alpha, theta);
    end
    r(t) = corr(q1, q2);
  end
end
