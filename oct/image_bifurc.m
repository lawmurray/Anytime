function image_bifurc(output_file, image_file)
  % data extents
  nF = 3584;
  nS = 21;

  fs = ncread(output_file, 'F', 1, nF);
  xs = linspace(-5, 7, 4096);

  % bin
  buf = 1024;
  for j = 1:nS
    P = zeros(length(xs), length(fs));
    for i = 1:length(fs)
      i1 = mod(i - 1, buf) + 1;
      if i1 == 1
	len = min(buf, nF - i + 1);
	x = ncread(output_file, 'x', [(j-1)*nF + i,1,25001], [len,Inf,Inf]);
      end
      printf("%d ", i);
      fflush(stdout);
      n = histc(x(i1,:,:)(:), xs);
      mn = min(n);
      mx = max(n);
      p = (n - mn)/(mx - mn);
      P(:,i) = p;
    end
    imwrite(P, sprintf('%s%d.png', image_file, j));
  end
end
