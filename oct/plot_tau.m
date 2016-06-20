function plot_tau(file, k)
  X = dlmread(file);
  X(:,3) = X(:,3)/1e6;  % convert us to s

  F = X(:,1);
  Y = X(:,k);

  % smooth mean
  %inffunc = @infExact;
  %meanfunc = @meanConst;
  %hyp.mean = mean(Y);
  %covfunc = @covSEiso;
  %hyp.cov = log([0.1; 0.1]);
  %likfunc = @likGauss;
  %hyp.lik = log(0.01*var(Y));
  %hyp = minimize(hyp, @gp, -50, inffunc, meanfunc, covfunc, likfunc, F, Y);

  %f = sort(F);
  %[m s2] = gp(hyp, inffunc, meanfunc, covfunc, likfunc, F, Y, f);

  %cla;
  plot(F, Y, '.', 'markersize', 2, 'color', [0; 94; 184]/255);
  %hold on;
  %plot(f, m, '', 'linewidth', 3, 'color', [0; 94; 184]/255);
  %hold off;

  xlabel('F');
  if k == 3
    ylabel('c (s)');
    ax = axis();
    axis([ax(1) ax(2) 0 ax(4)]);
  else
    ylabel('log likelihood');
    %ax = axis();
    %axis([ax(1) ax(2) -12000 0]);
  end
  grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
