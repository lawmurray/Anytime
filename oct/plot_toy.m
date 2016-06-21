function plot_toy(i)
  R = dlmread(sprintf('results/toy%d.csv', i));
  t = 0:(columns(R) - 1);
  linestyles = {
       '-'; ':'; '-'; ':';
  };
  linewidths = {
       2; 2; 4; 4;
  };
  
  clf;
  for (j = 1:4)
    plot(t, R(2*j - 1,:),
        'linestyle', linestyles{j},
        'color', 'k',
        'linewidth', linewidths{j});
    hold on;
  end
  hold off;
  grid on;
  ylabel('R');
  xlabel('t');
  legend(
      'K = 1, initialise from target',
      'K = 1, initialise from anytime',
      'K = 2, initialise from target',
      'K = 2, initialise from anytime',
      'location', 'southeast');
      legend('boxoff');
      legend('left');
  axis([0 250 0.9 1.0]);
end
