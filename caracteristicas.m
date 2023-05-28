function f = caracteristicas(img)

x = double(img(:));
media = mean(x);
desv_estandar = std(x);

f = [media desv_estandar];
end