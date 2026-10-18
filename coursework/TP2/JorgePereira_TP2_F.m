%Exercicio F, criado por: Jorge Barbosa Pereira

%Alguns Exemplos Satisfatórios:
%JorgePereira_TP2_F('Robot_RGB.tif')
%JorgePereira_TP2_F('Kandinsky.jpg')

function [] = JorgePereira_TP2_F(IM_path)

IM_TYPE = imfinfo(IM_path).ColorType;
if strcmp(IM_TYPE, 'grayscale')
    IM_O = imread(IM_path);
elseif strcmp(IM_TYPE, 'truecolor')
    IM_O = rgb2gray(imread(IM_path));
else
    error('O Input "IM_path" deve levar a uma Imagem no modelo RGB ou a uma Imagem na Escala de Cinzentos')
end

%Realiza a Segmentação da Imagem pelo metodo de OTSU
T_OTSU_d = graythresh(IM_O);
IM_BIN_OTSU = imbinarize(IM_O, T_OTSU_d);
T_OTSU = uint8(T_OTSU_d * 255);

%Realiza a Segmentação da Imagem pelo Thresholding Mediano
T_MED = median(IM_O(:));
T_MED_d = double(T_MED)/255;
IM_BIN_MED = imbinarize(IM_O, T_MED_d);


%Plot das imagens
subplot(2,2,1),imshow(IM_O), title('Imagem Original na Escala de Cinzentos')
subplot(2,2,2),imhist(IM_O), title('Histograma de Cinzentos da Imagem Original')
subplot(2,2,3),imshow(IM_BIN_OTSU), title(sprintf('Imagem Binária por Tresholding Global de Otsu \n T_{Otsu} = %d',T_OTSU))
subplot(2,2,4),imshow(IM_BIN_MED), title(sprintf('Imagem Binária por Tresholding Global de Mediana \n T_{Med} = %d',T_MED))
end