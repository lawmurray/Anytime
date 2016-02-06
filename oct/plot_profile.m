function plot_profile()
  clf;
  t = 0;
  rank = 0;
  file = sprintf("results/sir.log.%d", rank);
  while (exist(file, "file"))
    X = dlmread(file);
    X(:,2:3) = X(:,2:3)/1e6;
    t = max(t, max(X(:)));

    for i = 1:rows(X)
      x = [ X(i,2), X(i,3), X(i,3), X(i,2) ];
      y = [ rank + 0.75, rank + 0.75, rank + 1.25, rank + 1.25 ];
      if X(i,1) == 0 || X(i,1) == 6
        c = [0.7 0.7 0.7];
      else
        c = watercolour(X(i,1));
      end
      patch(x, y, c);
    end

    rank = rank + 1;
    file = sprintf("results/sir.log.%d", rank);
  end
  axis([0 t 0.5 rank + 0.5]);
end