clear all
close all

letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; % Lista de letras

resultados = []; % Matriz de resultados
indice = 1; % Variable para realizar el seguimiento del �ndice en resultados

% Recorrer cada letra
for letra_idx = 1:length(letras)
    letra = letras(letra_idx);
    
    % Recorrer cada archivo de la letra
    for i = 1:55
        filename = sprintf('letrasFinal/%c/tipo%d_%d.png', letra, letra_idx+12, i);
        img = imread(filename);
        c = caracteristicas(img);
        
        % Almacenar los resultados
        resultados = [resultados; c letra_idx];
        
        indice = indice + 1; % Incrementar el �ndice
    end
end

%%%%%%%%%%%%%%%%%%%%%Resultados%%%%%%%%%%%%%%%%%%%%%
disp('Resultados:');
disp(resultados);

%%%%%%%%%%%%%%%%%%%%%Comparar%%%%%%%%%%%%%%%%%%%%%
num_imagenes = 4; % N�mero de im�genes a comparar% <-------------------------------IMPORTANTE
distancias = zeros(size(resultados, 1), num_imagenes); % Matriz para almacenar las distancias

for j = 1:num_imagenes
    % Leer la imagen a comparar
    imagen = imread(sprintf('letras/letra_%d.png', j));
    
    % Obtener las caracter�sticas de la imagen
    c_imagen = caracteristicas(imagen);
    
    % Calcular las distancias con todas las im�genes de referencia
    distancias(:, j) = sqrt(sum((resultados(:, 1:2) - c_imagen).^2, 2));
end

[~, indices] = min(distancias, [], 1); % Encontrar los �ndices de las distancias m�nimas

numeros = resultados(indices, 3); % Obtener los n�meros correspondientes

disp(indices);
disp(letras(numeros));

% Definir la funci�n caracteristicas
function f = caracteristicas(img)
    x = double(img(:));
    media = mean(x);
    desv_estandar = std(x);

    f = [media desv_estandar];
end
