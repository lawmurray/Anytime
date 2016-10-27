function plot_toy(name)
  clf;
  for p = 0:3;
    h = subplot(1, 4, p + 1);
    pos = get(h, 'pos');
    pos(1) = pos(1) - 0.01;
    pos(3) = pos(3) + 0.02;
    set(h, 'pos', pos);
    
    R = dlmread(sprintf('results/toy_%s_%d.csv', name, p));
    t = 0:(size(R,2) - 1);

    hold on;
    for lgK = 1:size(R,1)
      c = ones(3,1) - lgK/size(R,1);
      area_between(t', R(lgK,:)', ones(1,size(R,2))', c, 1.0, 0.5);
      h = plot(t, R(lgK,:), ...
        'linestyle', '-', ...
        'color', c, ...
        'linewidth', 1);
    end
    grid on;
    box on;
    axis([0 100 0.95 1.0]);
    set(gca, 'ticklength', [0,0]);
    title(sprintf('p = %d', p), 'FontWeight', 'Normal');
    if p == 0
      ylabel('R');
    else
      set(gca, 'YTickLabel', {});
    end
    xlabel('t');
  end
end
