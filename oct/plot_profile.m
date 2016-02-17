function plot_profile()
  clf;
  t = 0;
  rank = 0;
  file = sprintf("results/n/sir.log.%d", rank);
  while (exist(file, "file"))
    X = dlmread(file);
    X(:,2:3) = X(:,2:3)/1e6;
    t = max(t, max(X(:)));

    for i = 200:rows(X)
      x = [ X(i,2), X(i,3), X(i,3), X(i,2) ];
      y = [ rank + 0.75, rank + 0.75, rank + 1.25, rank + 1.25 ];
      if (X(i,1) == 2)
        c = watercolour(X(i,1));
      else
        c = 0.5 + 0.1*X(i,1)*ones(3,1);
      end
      patch(x, y, c, 'linewidth', 0);
    end

    rank = rank + 1;
    file = sprintf("results/n/sir.log.%d", rank);
  end
  axis('tight');
  ax = axis();
  axis([ax(1) ax(2) 0.5 rank + 0.5]);
end