% Definir las carpetas de donde se seleccionar�n las im�genes
carpetas = {'letrasFinal/H/', 'letrasFinal/O/', 'letrasFinal/L/', 'letrasFinal/A/'};%<------------------IMPORTANTE

% Inicializar la celda de nombres de im�genes
nombresImagenes = {};

% Recorrer cada carpeta
for i = 1:numel(carpetas)
    carpetaActual = carpetas{i};
    
    % Seleccionar las im�genes en la carpeta actual usando el cuadro de di�logo de selecci�n de archivos
    [archivos, carpeta] = uigetfile(fullfile(carpetaActual, '*.png'), ['Seleccionar im�genes en ' carpetaActual], 'MultiSelect', 'on');

    % Verificar si se seleccionaron im�genes
    if isequal(archivos, 0) || isequal(carpeta, 0)
        warning(['No se seleccionaron im�genes en la carpeta ' carpetaActual]);
        continue; % Pasar a la siguiente carpeta
    end

    if ischar(archivos) % Solo se seleccion� una imagen
        nombresImagenes = [nombresImagenes fullfile(carpeta, archivos)];
    else % Se seleccionaron varias im�genes
        nombresImagenes = [nombresImagenes cellfun(@(archivo) fullfile(carpeta, archivo), archivos, 'UniformOutput', false)];
    end
end

numImagenes = numel(nombresImagenes);

% Verificar si se seleccionaron im�genes
if numImagenes == 0
    error('No se seleccionaron im�genes.');
end

imagenCombinada = 'hola.png'; % Cambia esto por la ruta y nombre que desees para la imagen combinada

% Leer las im�genes
numImagenes = length(nombresImagenes);
imagenes = cell(1, numImagenes);

for i = 1:numImagenes
    imagenes{i} = imread(nombresImagenes{i});
end

% Ruta de la carpeta "letras"
carpetaLetras = 'letras/';

% Copiar las im�genes a la carpeta "letras"
for i = 1:numImagenes
    copiaImagen = [carpetaLetras 'letra_' num2str(i) '.png'];
    imwrite(imagenes{i}, copiaImagen);
end

% Obtener los tama�os de las im�genes
tamanos = zeros(numImagenes, 2);

for i = 1:numImagenes
    [alto, ancho, ~] = size(imagenes{i});
    tamanos(i, :) = [alto, ancho];
end

altoMaximo = max(tamanos(:, 1));
anchoTotal = sum(tamanos(:, 2));

% Rellenar los espacios faltantes con negro en las im�genes
imagenesRellenadas = cell(1, numImagenes);

for i = 1:numImagenes
    diferenciaAlto = altoMaximo - tamanos(i, 1);
    diferenciaAncho = anchoTotal - tamanos(i, 2);
    
    imagenesRellenadas{i} = padarray(imagenes{i}, [diferenciaAlto, diferenciaAncho], 0, 'post');
end

% Combinar las im�genes
imgCombinada = horzcat(imagenesRellenadas{:});

% Guardar la imagen combinada
imwrite(imgCombinada, imagenCombinada);

% Mostrar la imagen combinada y las im�genes separadas
figure;
subplot(1, numImagenes+1, 1);
imshow(imgCombinada);
title('Imagen Juntada');

for i = 1:numImagenes
    subplot(1, numImagenes+1, i+1);
    imshow(imagenesRellenadas{i});
    title(['Imagen Separada ' num2str(i)]);
end
