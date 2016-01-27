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

  subplot(3, 1, 1);
  plot_paths;
  subplot(3, 1, 2);
  plot_bifurc;
  subplot(3, 1, 3);
  plot_tau;
  saveas(h, sprintf('%s/lorenz96.svg', figDir));
end
