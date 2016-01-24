function plot_tau()
  F = ncread('data/init.nc', 'F');
  X = [];
  for i = 0:9
    X = [X, dlmread(sprintf('results/tau%d.csv', i))];
  end

  mn = quantile(X, 0.1, 2);
  mx = quantile(X, 0.9, 2);
  m = median(X, 2);

  cla;
  area_between(F, mn, mx, [0.6 0.6 0.6], 0.5, 1.0);
  hold on;
  plot(F, m, 'k', 'linewidth', 3);
  hold off;

  %f = F;
  %c = linspace(0, 1e6, 200)';
  %
  %P = zeros(length(c), length(f));
  %for i = 1:length(f)
  %  printf("%d ", i);
  %  fflush(stdout);
  %  D = 1;
  %  N = columns(X);
  %  h = 2.0*(4.0/((D + 2.0)*N))**(1.0/(N + 4.0))*std(X(i,:));
  %  p = kernel_density(c, X(i,:)', h);
  %  P(:,i) = p/max(p);
  %end
  %
  %cla;
  %imagesc(f, c/1e6, P);
  %colormap(flipud(gray));
  %xlabel('F');
  %ylabel('c (s)');
  %%grid on;

  box on;
end
