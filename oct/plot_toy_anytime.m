function plot_toy_anytime()
  linestyles = {
       ':'; '-';
  };
  linewidths = {
       2; 2;
  };
  colours = {
       2; 2;
  };
  titles = {
      'p = 1, \rho = 0.5';
      'p = 2, \rho = 0.5';
      'p = 3, \rho = 0.5';
  };
  
  clf;
  for i = 1:3
    subplot(1, 3, i);
    
    R = dlmread(sprintf('results/toy%d.csv', i*2 + 2));
    t = 0:(size(R,2) - 1);

    %plot(t, ref, ...
    %    'linestyle', '-', ...
    %    'color', watercolour(2), ...
    %    'linewidth', 2);
    for (j = 1:2)
      plot(t, R(2*j,:), ...
          'linestyle', linestyles{j}, ...
          'color', watercolour(colours{j}), ...
          'linewidth', linewidths{j});
      hold on;
    end
    hold off;
    grid on;
    axis([0 100 0.6 1.0]);
    title(titles{i}, 'FontWeight', 'Normal');

    if i == 1
      ylabel('R');
    end
    xlabel('t');
    if i == 1
      legend( ...
          'K = 1, initialise from target', ...
          'K = 1, initialise from anytime', ...
          'location', 'southwest');
          legend('boxoff');
    end
  end
end
