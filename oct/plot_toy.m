function plot_toy()
  %ref = dlmread('results/ref.csv');
  linestyles = {
       ':'; '-'; ':'; '-';
  };
  linewidths = {
       2; 2; 3; 3;
  };
  colours = {
       2; 2; 1; 1; 
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
  for i = 1:8
    subplot(4, 2, i);
    
    R = dlmread(sprintf('results/toy%d.csv', i));
    t = 0:(size(R,2) - 1);

    %plot(t, ref, ...
    %    'linestyle', '-', ...
    %    'color', watercolour(2), ...
    %    'linewidth', 2);
    for (j = 1:4)
      plot(t, R(2*j - 1,:), ...
          'linestyle', linestyles{j}, ...
          'color', watercolour(colours{j}), ...
          'linewidth', linewidths{j});
      hold on;
    end
    hold off;
    grid on;
    axis([0 50 0.95 1.0]);
    title(titles{i}, 'FontWeight', 'Normal');

    if mod(i, 2) == 1
      ylabel('R');
    end
    if i == 7 || i == 8
      xlabel('t');
    end
    if i == 1
      legend( ...
          'K = 1, initialise from target', ...
          'K = 1, initialise from anytime', ...
          'K = 2, initialise from target', ...
          'K = 2, initialise from anytime', ...
          'location', 'southwest');
          legend('boxoff');
    end
  end
end
