function image_bifurc(output_file, image_file)
  fs = ncread(output_file, 'F');
  xs = linspace(-5, 7, 4096);
  nF = length(fs);

  % bin
  buf = 1024;
  P = zeros(length(xs), length(fs));
  for i = 1:length(fs)
    i1 = mod(i - 1, buf) + 1;
    if i1 == 1
      len = min(buf, nF - i + 1);
      x = ncread(output_file, 'x', [i,1,25001], [len,Inf,Inf]);
    end
    printf("%d ", i);
    fflush(stdout);
    n = histc(x(i1,:,:)(:), xs);
    mn = min(n);
    mx = max(n);
    p = (n - mn)/(mx - mn);
    P(:,i) = p;
  end
  imwrite(P, image_file);
end
