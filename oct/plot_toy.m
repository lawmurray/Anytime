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
    %for lgK = 1:size(R,1)
    %  c = ones(3,1) - lgK/size(R,1);
    %  area_between(t', R(lgK,:)', zeros(1,size(R,2))', c, 0.5, 1.0);
    %end
    for lgK = 1:size(R,1)
      c = ones(3,1) - lgK/size(R,1);
      h = plot(t, R(lgK,:), ...
        'linestyle', '-', ...
        'color', c, ...
        'linewidth', 1);
    end
    grid on;
    box on;
    ax = axis();
    axis([0 200 0.0 0.8]);
    %axis([0 20 0.0 0.3]);
    set(gca, 'ticklength', [0,0]);
    title(sprintf('p = %d', p), 'FontWeight', 'Normal');
    if p == 0
      if strcmp(name, 'anytime')
        ylabel('d_1(F_n, F_\alpha)');
      elseif strcmp(name, 'uncorrected')
        ylabel('d_1(F_n, F_\pi)');
      elseif strcmp(name, 'corrected')
        ylabel('d_1(F_{nK/(K+1)}, F_\pi)');
      elseif strcmp(name, 'marginal')
        ylabel('d_1(F_n}, F_\alpha)');
      end
    else
      set(gca, 'YTickLabel', {});
    end
    xlabel('t');
  end
end
