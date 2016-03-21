function postprocess_tau(name)
  X = [];
  for i = 0:3583
    printf("%d ", i);
    file = sprintf('results/%s.nc.%d', name, i);

    % use low-level NetCDF interface, otherwise have too many files open
    ncid = netcdf_open(file, 'share');
    F = double(netcdf_getVar(ncid, netcdf_inqVarID(ncid, 'F')));
    ll = double(netcdf_getVar(ncid, netcdf_inqVarID(ncid, 'loglikelihood')));
    clock = double(netcdf_getVar(ncid, netcdf_inqVarID(ncid, 'clock')));
    netcdf_close(ncid);

    X = [X; F ll clock];
  end
  dlmwrite(sprintf('results/%s.csv', name), X);
end
