function prepare_init()
  n = 3584;

  % across prior
  nccreate('data/init.nc', 'F', 'Dimensions', {'np', n});
  F = [1:n]/n*7;
  ncwrite('data/init.nc', 'F', F');

  % across posterior
  nccreate('data/init_zoom.nc', 'F', 'Dimensions', {'np', n});
  F = 4.7 + [1:n]/n*0.7;
  ncwrite('data/init_zoom.nc', 'F', F');

  % permuted for tau experiments
  nccreate('data/init_tau.nc', 'F', 'Dimensions', {'np', n});
  F = [1:n]/n*7;
  is = randperm(n);
  F = F(is);
  ncwrite('data/init_tau.nc', 'F', F');

  nccreate('data/init_tau_zoom.nc', 'F', 'Dimensions', {'np', n});
  F = 4.7 + [1:n]/n*0.7;
  is = randperm(n);
  F = F(is);
  ncwrite('data/init_tau_zoom.nc', 'F', F');
end
