function prepare_init()
  nF = 3584;
  nS = 21;
  n = nF*nS;

  % across prior
  nccreate('data/init.nc', 'F', 'Dimensions', {'np', n});
  nccreate('data/init.nc', 'sigma', 'Dimensions', {'np', n});

  F = [1:nF]/nF*7;
  sigma = [0:(nS - 1)]/(nS - 1)*0.02;
  F = repmat(F, 1, nS)(:);
  sigma = repmat(sigma, nF, 1)(:);

  ncwrite('data/init.nc', 'F', F);
  ncwrite('data/init.nc', 'sigma', sigma);

  % across posterior
  nccreate('data/init_zoom.nc', 'F', 'Dimensions', {'np', n});
  nccreate('data/init_zoom.nc', 'sigma', 'Dimensions', {'np', n});

  F = 4.7 + [1:nF]/nF*0.7;
  sigma = [0:(nS - 1)]/nS*0.02;
  F = repmat(F, 1, nS)(:);
  sigma = repmat(sigma, nF, 1)(:);

  ncwrite('data/init_zoom.nc', 'F', F);
  ncwrite('data/init_zoom.nc', 'sigma', sigma);

  % permuted for tau experiments
  nccreate('data/init_tau.nc', 'F', 'Dimensions', {'np', n});
  nccreate('data/init_tau.nc', 'sigma', 'Dimensions', {'np', n});

  F = [1:nF]/nF*7;
  sigma = [0:(nS - 1)]/nS*0.02;
  F = repmat(F, 1, nS)(:);
  sigma = repmat(sigma, nF, 1)(:);
  is = randperm(n);
  F = F(is);
  sigma = sigma(is);

  ncwrite('data/init_tau.nc', 'F', F);
  ncwrite('data/init_tau.nc', 'sigma', sigma);
end
