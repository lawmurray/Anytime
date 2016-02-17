function image_bifurc(output_file, image_file)
  % data extents
  fs = ncread(output_file, 'F')(:);
  xs = linspace(-6, 8, 4096);

  % bin
  x = ncread(output_file, 'x', [1,1,25001], [Inf,Inf,Inf]);
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
  imwrite(P, image_file);
end
