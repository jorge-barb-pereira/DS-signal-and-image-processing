%Exercicio A, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP2_A('Robot_RGB.tif')
%JorgePereira_TP2_A('ArTe.jpg')
%JorgePereira_TP2_A('Kandinsky.jpg')

function [] = JorgePereira_TP2_A(IM_path)

IM_TYPE = imfinfo(IM_path).ColorType;
if not(strcmp(IM_TYPE, 'truecolor'))
    error('O Input "IM_path" deve levar a uma Imagem no modelo RGB')
end

%Leitura da Imagem no modelo RGB
IM_RGB = imread(IM_path);

%Formação das Imagens com Cor Indexada com e sem Dither
[IM_I8_0, TC_I8_0] = rgb2ind(IM_RGB,8,'nodither');
[IM_I8_1, TC_I8_1] = rgb2ind(IM_RGB,8,'dither');

%Formação da Imagem na Escala de Cinzentos
IM_G = rgb2gray(IM_RGB);

%Plot das Imagens
figure(1), imshow(IM_RGB), title('Imagem Original de Três Bandas')
figure(2), imshow(IM_I8_0, TC_I8_0), title('Imagem de Cor Indexada com 8 Cores e sem Dither')
figure(3), imshow(IM_I8_1, TC_I8_1), title('Imagem de Cor Indexada com 8 Cores e com Dither')
figure(4), imshow(IM_G), title('Imagem de uma Banda na Escala de Cinzentos')
figure(5), imshow(IM_G, jet(256)), title('Imagem de uma Banda na Tabela de Cores Jet')
figure(6), imshow(IM_G, spring(256)), title('Imagem de uma Banda na Tabela de Cores Spring')
end

