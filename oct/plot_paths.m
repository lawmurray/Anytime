function plot_paths ()
  ps = 1792*[1 3 5 7]/7;
  ts = [2000:2400];
  t = bi_read_var('results/bifurc.nc', 'time', [], [], ts);
  x = bi_read_var('results/bifurc.nc', 'x', 1, ps, ts);
  cla;
  hold on;
  for i = 1:rows(x);
    plot(t, x(i,:), 'k', 'linewidth', 0.5*(5 - i));
  end
  hold off;
  axis([t(1), t(end), -6 10]);
  %grid on;
  xlabel('t');
  ylabel('x');
  grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
