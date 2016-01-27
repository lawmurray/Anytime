function plot_bifurc(dir)
  % data extents
  fs = linspace(0, 7, 1792);
  xs = linspace(-6, 8, 4096);

  % bin
  file = sprintf('%s/bifurc.nc', dir);
  x = ncread(file, 'x')(:,:,25001:end);
  P = zeros(length(xs), length(fs));
  for i = 1:length(fs)
    printf("%d ", i);
    fflush(stdout);
    n = histc(x(i,:,:)(:), xs);
    mn = min(n);
    mx = max(n);
    p = (n - mn)/(mx - mn);
    P(:,i) = p;
  end

  cla;
  imagesc (fs, xs, P);
  colormap(flipud(gray));
  axis('tight');
  xlabel ('F');
  ylabel ('x');
  grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
