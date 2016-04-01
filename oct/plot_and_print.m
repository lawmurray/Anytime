function plot_and_print()
  figDir = 'figs';
  mkdir(figDir);

  % output setup
  sz = [ 6 4.5 ];
  figure(1, 'visible', 'off');
  h = figure(1);
  set (h, 'papersize', sz);
  set (h, 'paperposition', [0,0,sz]);
  orient('landscape');

  cla;
  plot_bifurc('data/init.nc', 'figs/bifurc.png');
  saveas(h, sprintf('%s/bifurc.svg', figDir));

  cla;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom.png');
  saveas(h, sprintf('%s/bifurc_zoom.svg', figDir));

  cla;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom.png');
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  saveas(h, sprintf('%s/bifurc_superzoom.svg', figDir));

  cla;
  plot_bifurc('data/init.nc', 'figs/bifurc1.png');
  saveas(h, sprintf('%s/bifurc1.svg', figDir));

  cla;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom1.png');
  saveas(h, sprintf('%s/bifurc_zoom1.svg', figDir));

  cla;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom1.png');
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  saveas(h, sprintf('%s/bifurc_superzoom1.svg', figDir));

  cla;
  plot_tau('results/tau.csv', 2);
  saveas(h, sprintf('%s/likelihood.svg', figDir));

  cla;
  plot_tau('results/tau_zoom.csv', 2);
  saveas(h, sprintf('%s/likelihood_zoom.svg', figDir));

  cla;
  plot_tau('results/tau_zoom.csv', 2);
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  saveas(h, sprintf('%s/likelihood_superzoom.svg', figDir));

  cla;
  plot_tau('results/tau.csv', 3);
  saveas(h, sprintf('%s/time.svg', figDir));

  cla;
  plot_tau('results/tau_zoom.csv', 3);
  saveas(h, sprintf('%s/time_zoom.svg', figDir));

  cla;
  plot_tau('results/tau_zoom.csv', 3);
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  saveas(h, sprintf('%s/time_superzoom.svg', figDir));

  cla;
  plot_profile('gpu6/sir_time', 'figs/profile_time_gpu6.png');
  saveas(h, sprintf('%s/profile_time_gpu6.svg', figDir));

  cla;
  plot_profile('gpu6/sir_samples', 'figs/profile_samples_gpu6.png');
  saveas(h, sprintf('%s/profile_samples_gpu6.svg', figDir));

  cla;
  plot_profile('gpu32/sir_time', 'figs/profile_time_gpu32.png');
  saveas(h, sprintf('%s/profile_time_gpu32.svg', figDir));

  cla;
  plot_profile('gpu32/sir_samples', 'figs/profile_samples_gpu32.png');
  saveas(h, sprintf('%s/profile_samples_gpu32.svg', figDir));

  cla;
  plot_profile('gpu128/sir_time', 'figs/profile_time_gpu128.png');
  saveas(h, sprintf('%s/profile_time_gpu128.svg', figDir));

  cla;
  plot_profile('gpu128/sir_samples', 'figs/profile_samples_gpu128.png');
  saveas(h, sprintf('%s/profile_samples_gpu128.svg', figDir));

  cla;
  bi_hist('gpu6/posterior_samples.nc', 'F', [], [], [], 15);
  xlabel('F');
  saveas(h, sprintf('%s/posterior_samples_gpu6.svg', figDir));

  cla;
  bi_hist('gpu6/posterior_time.nc', 'F', [], [], [], 15);
  xlabel('F');
  saveas(h, sprintf('%s/posterior_time_gpu6.svg', figDir));

  cla;
  bi_hist('gpu128/posterior_samples.nc', 'F', [], [], [], 15);
  xlabel('F');
  saveas(h, sprintf('%s/posterior_samples_gpu128.svg', figDir));

  cla;
  bi_hist('gpu128/posterior_time.nc', 'F', [], [], [], 15);
  xlabel('F');
  saveas(h, sprintf('%s/posterior_time_gpu128.svg', figDir));
end
