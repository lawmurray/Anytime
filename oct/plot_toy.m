function plot_toy(i)
  R = dlmread(sprintf('results/toy%d.csv', i));
  t = 0:(size(R,2) - 1);
  linestyles = {
       ':'; '-'; ':'; '-';
  };
  linewidths = {
       2; 2; 3; 3;
  };
  titles = {
      'p = 0, \rho = 0';
      'p = 0, \rho = 0.5';
      'p = 1, \rho = 0';
      'p = 1, \rho = 0.5';
      'p = 2, \rho = 0';
      'p = 2, \rho = 0.5';
      'p = 3, \rho = 0';
      'p = 3, \rho = 0.5';
  };
  
  clf;
  for (j = 1:4)
    plot(t, R(2*j - 1,:), ...
        'linestyle', linestyles{j}, ...
        'color', 'k', ...
        'linewidth', linewidths{j});
    hold on;
  end
  hold off;
  grid on;
  axis([0 100 0.94 1.0]);
  title(titles{i});
  
  if mod(i, 2) == 1
    ylabel('R');
  end
  if i == 7 || i == 8
    xlabel('t');
  end
  if i == 8
    legend( ...
        'K = 1, initialise from target', ...
        'K = 1, initialise from anytime', ...
        'K = 2, initialise from target', ...
        'K = 2, initialise from anytime', ...
        'location', 'southeast');
        legend('boxoff');
  end
end
