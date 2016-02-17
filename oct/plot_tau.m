function plot_tau(dir)
  F = ncread('data/init.nc', 'F');
  X = [];
  for i = 1:2
    X = [X, dlmread(sprintf('%s/tau%d.csv', dir, i))];
  end
  X = X/1e6;  % convert us to s

  % smooth mean
  m = median(X, 2);
  meanfunc = @meanConst;
  hyp.mean = [0.5];
  covfunc = @covSEiso;
  hyp.cov = log([0.25; 1]);
  likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
  gp(hyp, @infExact, meanfunc, covfunc, likfunc, F, m);
  [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, F, m, F);

  cla;
  plot(F, X, '.', 'color', [0.8 0.8 0.8], 'markersize', 2);
  hold on;
  plot(F, m, 'k', 'linewidth', 3);
  hold off;

  xlabel('F');
  ylabel('c (s)');
  axis([0 7 0 1]);
  grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
