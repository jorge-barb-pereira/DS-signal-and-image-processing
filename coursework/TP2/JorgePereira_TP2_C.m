%Exercicio C, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP2_C('Robot_RGB.tif')
%JorgePereira_TP2_C('ArTe.jpg')
%JorgePereira_TP2_C('Kandinsky.jpg')

function [] = JorgePereira_TP2_C(IM_path)

IM_TYPE = imfinfo(IM_path).ColorType;
if not(strcmp(IM_TYPE, 'truecolor'))
    error('O Input "IM_path" deve levar a uma Imagem no modelo RGB')
end

%Leitura da Imagem no modelo RGB
IM_RGB = imread(IM_path);

%Formação da Imagem Equalizada no modelo RGB
IM_RGB_EQ = histeq(IM_RGB);

%Conversão da Imagem para o modelo HSV
IM_HSV = rgb2hsv(IM_RGB);

%Formação da Imagem Equalizada no modelo HSV
IM_HSV_EQ = IM_HSV;
IM_HSV_EQ(:,:,3) = histeq(IM_HSV(:,:,3));
IM_HSV_EQ = uint8(hsv2rgb(IM_HSV_EQ)*255);

%Plot das Imagens
figure(1)
subplot(1,3,1), imshow(IM_RGB), title('Imagem Original de Três Bandas')
subplot(1,3,2), imshow(IM_RGB_EQ), title('Imagem Equalizada no Modelo RGB')
subplot(1,3,3), imshow(IM_HSV_EQ), title('Imagem Equalizada no Modelo HSV')
end

