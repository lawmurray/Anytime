function plot_tau(base, variable)
  f = ncread('data/init.nc', 'F');
  F = [];
  C = [];

  i = 0;
  j = 0;
  file = sprintf('%s.%d.%d', base, i, j);
  while exist(file, 'file')
    while exist(file, 'file')
      F = [F; f(j + 1)];
      C = [C; double(ncread(file, variable))];
      j = j + 1;
      file = sprintf('%s.%d.%d', base, i, j);
    end
    i = i + 1;
    j = 0;
  end
  if strcmp(variable, 'clock')
    C = C/1e6;  % convert us to s
  end

  % smooth mean
  inffunc = @infExact;
  meanfunc = @meanConst;
  hyp.mean = mean(C);
  covfunc = @covSEiso;
  hyp.cov = log([1.0; 1.0]);
  likfunc = @likGauss;
  hyp.lik = log(var(C));
  hyp = minimize(hyp, @gp, -100, inffunc, meanfunc, covfunc, likfunc, F, C)
  [m s2] = gp(hyp, inffunc, meanfunc, covfunc, likfunc, F, C, f);

  cla;
  plot(F, C, '.', 'color', [0.5 0.5 0.5], 'markersize', 2);
  hold on;
  plot(f, m, '', 'linewidth', 3, 'color', [0; 94; 184]/255);
  %plot(f, m + 1.96*sqrt(s2), 'k', 'linewidth', 1);
  %plot(f, m - 1.96*sqrt(s2), 'k', 'linewidth', 1);
  hold off;

  xlabel('F');
  if strcmp(variable, 'clock')
    ylabel('c (s)');
    ax = axis();
    axis([0 ax(2) 0 ax(4)]);
  else
    ylabel('log p(y|F)');
  end
  grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
