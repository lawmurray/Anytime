function postprocess_tau()
  X = [];
  for i = 0:75263
    printf("%d ", i);
    file = sprintf('results/tau.nc.%d', i);

    % use low-level NetCDF interface, otherwise have too many files open
    ncid = netcdf_open(file, 'share');
    F = double(netcdf_getVar(ncid, netcdf_inqVarID(ncid, 'F')));
    sigma = double(netcdf_getVar(ncid, netcdf_inqVarID(ncid, 'sigma')));
    ll = double(netcdf_getVar(ncid, netcdf_inqVarID(ncid, 'loglikelihood')));
    clock = double(netcdf_getVar(ncid, netcdf_inqVarID(ncid, 'clock')));
    netcdf_close(ncid);

    X = [X; F sigma ll clock];
  end
  dlmwrite('results/tau.csv', X);
end
