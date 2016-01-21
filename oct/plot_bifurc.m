% Copyright (C) 2015
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_bifurc ()
%
% Produce bifurcation plots for Lorenz '96 model.
%
% @end deftypefn
%
function plot_bifurc ()
    colormap(flipud(gray));
	 
    bi_image_bifurc('results/bifurc.nc', 'F', [], 'x', 1, [], [40:801]);
    axis('tight');
    xlabel ('F');
    ylabel ('x');
    axis('tight');
end
