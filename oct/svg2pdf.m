function svg2pdf(file)
  [dir, name, ext] = fileparts(file);
  svg = file;
  pdf = sprintf("%s/%s.pdf", dir, name);
  system(sprintf("inkscape --without-gui --export-pdf=%s %s", pdf, svg));
  system(sprintf("pdfcrop %s %s", pdf, pdf));
end
