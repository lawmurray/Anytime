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
  plot_bifurc('data/init.nc', 'figs/bifurc.png');
  subplot(3, 2, 3);
  plot_tau('results/tau.csv', 2);
  subplot(3, 2, 5);
  plot_tau('results/tau.csv', 3);

  subplot(3, 2, 2);
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom.png');
  subplot(3, 2, 4);
  plot_tau('results/tau_zoom.csv', 2);
  subplot(3, 2, 6);
  plot_tau('results/tau_zoom.csv', 3);

  saveas(h, sprintf('%s/lorenz96.svg', figDir));
end
