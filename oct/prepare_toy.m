function prepare_toy()
  N = 10000;
  T = 100;
  k = 2.0;
  theta = 1.0;

  A = [ 0 0;
	0 0.5;
	1 0;
	1 0.5;
	2 0;
	2 0.5;
	3 0;
	3 0.5 ];

  % reference
  %X = gamrnd(k, theta, N, T);
  NR = normrnd(0.0, 1.0, N, T);
  UR = normcdf(NR, 0.0, 1.0);
  XR = gaminv(UR, k, theta);
  r = zeros(T,1);
  for t = 1:T
    [q1,x] = ecdf(XR(:,t));
    q2 = gamcdf(x, k, theta);
    r(t) = corr(q1, q2);
  end
  dlmwrite('results/ref.csv', r');

  parfor i = 1:8
    p = A(i,1);
    rho = A(i,2);

    [r1,r2] = toy(N, T, rho, k, theta, p, 0);
    [r3,r4] = toy(N, T, rho, k, theta, p, 1);
    [r5,r6] = toy2(N, T, rho, k, theta, p, 0);
    [r7,r8] = toy2(N, T, rho, k, theta, p, 1);

    file = sprintf('results/toy%d.csv', i);
    dlmwrite(file, [ r1 r2 r3 r4 r5 r6 r7 r8 ]');
  end
end
