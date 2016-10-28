%
% Simulates K-chains for the toy model example, returns the probability
% plot correlation coefficients against the target and anytime
% distributions.
%
function d = toyK(K, T, N, rho, alpha, theta, p, correct, anytime)
  if (correct)
    L = K - 1;
  else
    L = K;
  end
  X = zeros(L, T, N);
  
  parfor n = 1:N
    X1 = zeros(L, T);
    
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
          X1(:,t) = x([1:(k-1) (k+1):K]);
        else
          X1(:,t) = x;
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
    X(:,:,n) = X1;
  end
  
  % probability plot correlation coefficients
  %r = zeros(T,1);
  %for t = 1:T
  %  x = X(:,t,:);
  %  [q1,x] = ecdf(x(:));
  %  if anytime
  %    q2 = gamcdf(x, alpha + p, theta);
  %  else
  %    q2 = gamcdf(x, alpha, theta);
  %  end
  %  r(t) = corr(q1, q2);
  %end
  
  % KL divergence
  %kl = zeros(T,1);
  %for t = 1:T
  %  x = X(:,t,:);
  %  x = sort(x);
  %  if anytime
  %    q = gamcdf(x, alpha + p, theta);
  %  else
  %    q = gamcdf(x, alpha, theta);
  %  end
  %  q = [0 q 1];
  %  dq = diff(q);
  %  n = length(dq) + 1;
  %  kl(t) = sum(dq.*(log(dq*n)));
  %end
  
  % Wasserstein distance
  d = zeros(T,1);
  if (anytime)
    beta = alpha + p;
  else
    beta = alpha;
  end
  F = @(x) gamcdf(x, beta, theta);
  G = @(x) 1 - F(x);

  parfor t = 1:T
    x = X(:,t,:);
    [q,x] = ecdf(x(:));
    [x,is] = sort(x); % ecdf may sort, but doc doesn't seem to guarantee
    q = q(is);

    % left tail
    d1 = integral(F, -Inf, x(1));
    
    % centre
    for m = 2:length(x)
      if x(m) > x(m - 1)
        y = gaminv(q(m - 1), beta, theta);
        if x(m - 1) < y && y < x(m)
          a1 = (y - x(m - 1))*q(m - 1);
          a2 = integral(F, x(m - 1), y);
          d1 = d1 + abs(a1 - a2);

          a1 = (x(m) - y)*q(m - 1);
          a2 = integral(F, y, x(m));
          d1 = d1 + abs(a1 - a2);
        else
          a1 = (x(m) - x(m - 1))*q(m - 1);
          a2 = integral(F, x(m - 1), x(m));
          d1 = d1 + abs(a1 - a2);
        end
        d(t) = d1;
      end
    end
    
    % right tail
    d(t) = d(t) + integral(G, x(end), Inf);
  end
end
