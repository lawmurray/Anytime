function plot_bifurc(init_file, image_file)
  % data extents
  fs = ncread(init_file, 'F');
  xs = linspace(-6, 8, 4096);
  P = imread(image_file);

  cla;
  imagesc(fs, xs, P);
  colormap(flipud(gray));
  axis('tight');
  xlabel ('F');
  ylabel ('x');
  %grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
  set(gca,'ydir','normal');
end
