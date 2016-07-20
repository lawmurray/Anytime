function plot_and_print()
  figDir = 'figs';
  mkdir(figDir);

  % Lorenz '96 bifurcation, likelihood and timings
  sz = [ 10 10 ];
  %figure(1, 'visible', 'off');
  h = figure(1);
  set (h, 'papersize', sz);
  set (h, 'paperposition', [0,0,sz]);
  orient('landscape');

  clf;
  
  subplot(3, 2, 1);
  plot_bifurc('data/init.nc', 'figs/bifurc.png');
  ax = axis();
  axis([0 7 -5 8]);

  subplot(3, 2, 2);
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom.png');
  ax = axis();
  axis([4.82 4.96 -5 8]);

  subplot(3, 2, 3);
  plot_tau('results/tau.csv', 2);
  ax = axis();
  axis([0 7 ax(3) ax(4)]);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'k');

  subplot(3, 2, 4);
  plot_tau('results/tau_zoom.csv', 2);
  axis([4.82 4.96 -90 -84]);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'k');

  subplot(3, 2, 5);
  plot_tau('results/tau.csv', 3);
  ax = axis();
  axis([0 7 ax(3) ax(4)]);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'k');

  subplot(3, 2, 6);
  plot_tau('results/tau_zoom.csv', 3);
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'k');

  file = sprintf('%s/bifurc_likelihood_time.pdf', figDir);
  saveas(h, file);

  % compute profiles
  sz = [ 10 8 ];
  h = figure(1);
  set (h, 'papersize', sz);
  set (h, 'paperposition', [0,0,sz]);
  orient('landscape');

  clf;
  subplot(125, 2, [1:2:23]);
  plot_profile('results/gpu8/sir_samples', 'figs/profile_samples_gpu8.png');
  subplot(125, 2, [2:2:24]);
  plot_profile('results/gpu8/sir_time', 'figs/profile_time_gpu8.png');
  subplot(125, 2, [45:2:250]);
  plot_profile('results/gpu128/sir_samples', 'figs/profile_samples_gpu128.png');
  subplot(125, 2, [46:2:250]);
  plot_profile('results/gpu128/sir_time', 'figs/profile_time_gpu128.png');

  file = sprintf('%s/profile.pdf', figDir);
  saveas(h, file);

  % posterior
  sz = [ 10 3 ];
  h = figure(1);
  set (h, 'papersize', sz);
  set (h, 'paperposition', [0,0,sz]);
  orient('landscape');

  clf;
  subplot(1, 2, 1);
  bi_hist('results/gpu128/posterior_samples.nc', 'F', [], [], [], 20, [], 0);
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'k');
  xlabel('F');
  ylabel('posterior density');
  grid on;
  
  subplot(1, 2, 2);  
  bi_hist('results/gpu128/posterior_time.nc', 'F', [], [], [], 20, [], 0);
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'k');
  xlabel('F');
  ylabel('posterior density');
  grid on;
  
  file = sprintf('%s/posterior.pdf', figDir);
  saveas(h, file);

  % toy experiments
  sz = [ 10 3 ];
  h = figure(1);
  set (h, 'papersize', sz);
  set (h, 'paperposition', [0,0,sz]);
  orient('landscape');
  
  clf;
  plot_toy;
  file = sprintf('%s/toy.pdf', figDir);
  saveas(h, file);

  clf;
  plot_toy_anytime;
  file = sprintf('%s/toy_anytime.pdf', figDir);
  saveas(h, file);
end
