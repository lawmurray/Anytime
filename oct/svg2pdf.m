function svg2pdf(file)
  [dir, name, ext] = fileparts(file);
  svg = file;
  pdf = sprintf('%s/%s.pdf', dir, name);
  system(sprintf('/usr/local/bin/inkscape --without-gui --export-pdf=%s %s', pdf, svg));
  system(sprintf('/usr/texbin/pdfcrop %s %s', pdf, pdf));
end
