function plot_toy_anytime()
  titles = {
      'p = 0, \rho = 0.5';
      'p = 1, \rho = 0.5';
      'p = 2, \rho = 0.5';
      'p = 3, \rho = 0.5';
  };
  
  clf;
  for i = 1:4
    h = subplot(1, 4, i);
    pos = get(h, 'pos');
    pos(1) = pos(1) - 0.01;
    %pos(2) = pos(2) - 0.01;
    pos(3) = pos(3) + 0.02;
    %pos(4) = pos(4) + 0.02;
    set(h, 'pos', pos);

    R = dlmread(sprintf('results/toy%d.csv', i*2));
    t = 0:(size(R,2) - 1);

    c = [0.7; 0.7; 0.7];
    area_between(t, R(2,:), R(4,:), c, 1, 0.5);
    hold on;
    h2 = plot(t, R(4,:), ...
      'linestyle', '-', ...
      'color', c, ...
      'linewidth', 1);
    h1 = plot(t, R(2,:), ...
      'linestyle', ':', ...
      'color', c, ...
      'linewidth', 1);
    hold off;
    grid on;
    axis([0 100 0.75 1.0]);
    set(gca, 'ticklength', [0,0]);
    title(titles{i}, 'FontWeight', 'Normal');

    if i == 1
      ylabel('R');
    else
      set(gca, 'YTickLabel', {});
    end
    xlabel('t');
    if i == 1
      legend([h2 h1], ...
          '3. K = 1, X(0) ~ \alpha(dx)', ...
          '4. K = 1, X(0) ~ \pi(dx)', ...
          'location', 'southwest');
          legend('boxoff');
    end
  end
end
