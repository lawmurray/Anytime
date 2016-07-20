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
      %'p = 0, \rho = 0';
      %'p = 1, \rho = 0';
      %'p = 2, \rho = 0';
      %'p = 3, \rho = 0';
      'p = 0, \rho = 0.5';
      'p = 1, \rho = 0.5';
      'p = 2, \rho = 0.5';
      'p = 3, \rho = 0.5';
  };
  
  clf;
  order = [2 4 6 8];
  for i = 1:4;
    h = subplot(1, 4, i);
    pos = get(h, 'pos');
    pos(1) = pos(1) - 0.01;
    %pos(2) = pos(2) - 0.01;
    pos(3) = pos(3) + 0.02;
    %pos(4) = pos(4) + 0.02;
    set(h, 'pos', pos);
    
    R = dlmread(sprintf('results/toy%d.csv', order(i)));
    t = 0:(size(R,2) - 1);

    hold on;
    c = [0.4; 0.4; 0.4];
    area_between(t, R(5,:), R(7,:), c, 0.5, 1);
    h4 = plot(t, R(7,:), ...
        'linestyle', '-', ...
        'color', c, ...
        'linewidth', 2);
    h3 = plot(t, R(5,:), ...
        'linestyle', ':', ...
        'color', c, ...
        'linewidth', 2);
    c = [0.7; 0.7; 0.7];
    area_between(t, R(1,:), R(3,:), c, 1, 0.5);
    h2 = plot(t, R(3,:), ...
        'linestyle', '-', ...
        'color', c, ...
        'linewidth', 1);
    h1 = plot(t, R(1,:), ...
        'linestyle', ':', ...
        'color', c, ...
        'linewidth', 1);

    hold off;
    grid on;
    axis([0 100 0.75 1.0]);
    set(gca, 'ticklength', [0,0]);
    title(titles{i}, 'FontWeight', 'Normal');

    if i == 1 || i == 5
      ylabel('R');
    else
      set(gca, 'YTickLabel', {});
    end
    xlabel('t');
    if i == 1
      legend([h4 h3 h2 h1], ...
          '1. K = 2, X(0) ~ \alpha(dx)', ...
          '2. K = 2, X(0) ~ \pi(dx)', ...
          '3. K = 1, X(0) ~ \alpha(dx)', ...
          '4. K = 1, X(0) ~ \pi(dx)', ...
          'location', 'southwest');
          legend('boxoff');
    end
  end
end
