function plot_tau(base)
  f = ncread('data/init_tau.nc', 'F');
  X = [];
  F = [];

  i = 0;
  file = sprintf('%s.%d', base, i);
  while exist(file, 'file')
    X = [X; dlmread(file)];
    F = [F; f];
    i = i + 1;
    file = sprintf('%s.%d', base, i);
  end
  X = X/1e6;  % convert us to s

  % smooth mean
  inffunc = @infExact;
  meanfunc = @meanConst;
  hyp.mean = [0.1];
  covfunc = @covSEiso;
  hyp.cov = [0.9; -3.33];
  likfunc = @likGauss;
  hyp.lik = -5.0;
  hyp = minimize(hyp, @gp, -100, inffunc, meanfunc, covfunc, likfunc, F, X)
  [m s2] = gp(hyp, inffunc, meanfunc, covfunc, likfunc, F, X, f);

  cla;
  plot(F, X, '.', 'color', [0.7 0.7 0.7], 'markersize', 2);
  hold on;
  plot(f, m, 'k', 'linewidth', 2);
  plot(f, m + 1.96*sqrt(s2), 'k', 'linewidth', 1);
  plot(f, m - 1.96*sqrt(s2), 'k', 'linewidth', 1);
  hold off;

  xlabel('F');
  ylabel('c (s)');
  ax = axis();
  axis([0 ax(2) 0 ax(4)]);
  grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
