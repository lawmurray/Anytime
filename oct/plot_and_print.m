function plot_and_print()
  figDir = 'figs';
  mkdir(figDir);

  % output setup
  sz = [ 10 8.5 ];
  figure(1, 'visible', 'off');
  h = figure(1);
  set (h, 'papersize', sz);
  %set (h, 'paperposition', [0,0,sz]);
  orient('tall');

  subplot(3, 2, 1);
  plot_paths('results/deterministic/bifurc.nc');
  subplot(3, 2, 3);
  plot_bifurc('results/deterministic/bifurc.nc');
  subplot(3, 2, 5);
  plot_bifurc('results/deterministic/bifurc_zoom.nc');
  subplot(3, 2, 2);
  plot_paths('results/stochastic/bifurc.nc');
  subplot(3, 2, 4);
  plot_bifurc('results/stochastic/bifurc.nc');
  subplot(3, 2, 6);
  plot_bifurc('results/stochastic/bifurc_zoom.nc');

  saveas(h, sprintf('%s/lorenz96.svg', figDir));
end
