function prepare_toy()
  N = 2^18;
  T = 201;
  alpha = 2.0;
  theta = 0.5;
  rho = 0.5;

  for p = 0:3
    % anytime runs
    R = zeros(1,T);
    R(1,:) = toyK(1, T, N, rho, alpha, theta, p, 0, 1);
    file = sprintf('results/toy_anytime_%d.csv', p);
    dlmwrite(file, R);

    % K-chain uncorrected runs
    R = zeros(5,T);
    for lgK = 1:size(R,1)
      K = 2^lgK;
      R(lgK,:) = toyK(K, T, N/K, rho, alpha, theta, p, 0, 0);
    end
    file = sprintf('results/toy_uncorrected_%d.csv', p);
    dlmwrite(file, R);

    % K-chain corrected runs
    for lgK = 1:size(R,1)
      K = 2^lgK;
      R(lgK,:) = toyK(K, T, N/K, rho, alpha, theta, p, 1, 0);
    end
    file = sprintf('results/toy_corrected_%d.csv', p);
    dlmwrite(file, R);
  end
end
