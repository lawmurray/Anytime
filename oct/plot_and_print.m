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

  %clf;
  %plot_paths();
  %file = sprintf('%s/paths.svg', figDir);
  %saveas(h, file);
  %svg2pdf(file);

  clf;
  plot_bifurc('data/init.nc', 'figs/bifurc_blue.png');
  file = sprintf('%s/bifurc.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  ax = axis();
  patch([4.7 5.4 5.4 4.7 4.7], [ax(3) ax(3) ax(4) ax(4) ax(3)], 'edgecolor', 'red', 'facecolor', 'red', 'facealpha', 0.5);
  file = sprintf('%s/bifurc_next.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom_blue.png');
  file = sprintf('%s/bifurc_zoom.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  ax = axis();
  patch([4.82 4.96 4.96 4.82 4.82], [ax(3) ax(3) ax(4) ax(4) ax(3)], 'edgecolor', 'red', 'facecolor', 'red', 'facealpha', 0.5);
  file = sprintf('%s/bifurc_zoom_next.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom_blue.png');
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  file = sprintf('%s/bifurc_superzoom.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'red');
  file = sprintf('%s/bifurc_superzoom_next.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_bifurc('data/init.nc', 'figs/bifurc1_blue.png');
  file = sprintf('%s/bifurc1.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  ax = axis();
  patch([4.7 5.4 5.4 4.7 4.7], [ax(3) ax(3) ax(4) ax(4) ax(3)], 'edgecolor', 'red', 'facecolor', 'red', 'facealpha', 0.5);
  file = sprintf('%s/bifurc1_next.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom1_blue.png');
  file = sprintf('%s/bifurc_zoom1.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  ax = axis();
  patch([4.82 4.96 4.96 4.82 4.82], [ax(3) ax(3) ax(4) ax(4) ax(3)], 'edgecolor', 'red', 'facecolor', 'red', 'facealpha', 0.5);
  file = sprintf('%s/bifurc_zoom1_next.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_bifurc('data/init_zoom.nc', 'figs/bifurc_zoom1_blue.png');
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  file = sprintf('%s/bifurc_superzoom1.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', 'red');
  file = sprintf('%s/bifurc_superzoom1_next.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_tau('results/tau.csv', 2);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  file = sprintf('%s/likelihood.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_tau('results/tau_zoom.csv', 2);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  file = sprintf('%s/likelihood_zoom.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_tau('results/tau_zoom.csv', 2);
  ax = axis();
  axis([4.82 4.96 -350 -300]);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  file = sprintf('%s/likelihood_superzoom.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_tau('results/tau.csv', 3);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  file = sprintf('%s/time.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_tau('results/tau_zoom.csv', 3);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  file = sprintf('%s/time_zoom.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_tau('results/tau_zoom.csv', 3);
  ax = axis();
  axis([4.82 4.96 ax(3) ax(4)]);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  file = sprintf('%s/time_superzoom.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  #clf;
  #plot_profile('gpu4/sir_time', 'figs/profile_time_gpu4.png');
  #file = sprintf('%s/profile_time_gpu4.svg', figDir);
  #saveas(h, file);
  #svg2pdf(file);

  #clf;
  #plot_profile('gpu4/sir_samples', 'figs/profile_samples_gpu4.png');
  #file = sprintf('%s/profile_samples_gpu4.svg', figDir);
  #saveas(h, file);
  #svg2pdf(file);

  clf;
  plot_profile('gpu6/sir_time', 'figs/profile_time_gpu6.png');
  file = sprintf('%s/profile_time_gpu6.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_profile('gpu6/sir_samples', 'figs/profile_samples_gpu6.png');
  file = sprintf('%s/profile_samples_gpu6.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_profile('gpu32/sir_time', 'figs/profile_time_gpu32.png');
  file = sprintf('%s/profile_time_gpu32.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_profile('gpu32/sir_samples', 'figs/profile_samples_gpu32.png');
  file = sprintf('%s/profile_samples_gpu32.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_profile('gpu128/sir_time', 'figs/profile_time_gpu128.png');
  file = sprintf('%s/profile_time_gpu128.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  plot_profile('gpu128/sir_samples', 'figs/profile_samples_gpu128.png');
  file = sprintf('%s/profile_samples_gpu128.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  bi_hist('gpu6/posterior_samples.nc', 'F', [], [], [], 15);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  xlabel('F');
  file = sprintf('%s/posterior_samples_gpu6.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  bi_hist('gpu6/posterior_time.nc', 'F', [], [], [], 15);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  xlabel('F');
  file = sprintf('%s/posterior_time_gpu6.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  bi_hist('gpu128/posterior_samples.nc', 'F', [], [], [], 15);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  xlabel('F');
  file = sprintf('%s/posterior_samples_gpu128.svg', figDir);
  saveas(h, file);
  svg2pdf(file);

  clf;
  bi_hist('gpu128/posterior_time.nc', 'F', [], [], [], 15);
  ax = axis();
  line([4.8801 4.8801], [ax(3) ax(4)], 'color', watercolour(2)');
  xlabel('F');
  file = sprintf('%s/posterior_time_gpu128.svg', figDir);
  saveas(h, file);
  svg2pdf(file);
end
