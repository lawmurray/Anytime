function plot_profile(image_file)
  timelines = imread(image_file);
  cla;
  image(timelines);
  axis('tight');
  xlabel ('time');
  ylabel ('rank');
  %grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
