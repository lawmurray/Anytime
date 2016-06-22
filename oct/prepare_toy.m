function prepare_toy(i)
  N = 10000;
  T = 500;
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

  p = A(i,1);
  rho = A(i,2);

  [r1,r2] = toy(N, T, rho, k, theta, p, 0);
  [r3,r4] = toy(N, T, rho, k, theta, p, 1);
  [r5,r6] = toy2(N, T, rho, k, theta, p, 0);
  [r7,r8] = toy2(N, T, rho, k, theta, p, 1);

  file = sprintf("results/toy%d.csv", i);
  dlmwrite(file, [ r1 r2 r3 r4 r5 r6 r7 r8 ]');
end
