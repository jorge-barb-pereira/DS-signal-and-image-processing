%Exercicio B, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP2_B('Robot_RGB.tif')
%JorgePereira_TP2_B('ArTe.jpg')
%JorgePereira_TP2_B('Kandinsky.jpg')

function [] = JorgePereira_TP2_B(IM_path)

IM_TYPE = imfinfo(IM_path).ColorType;
if not(strcmp(IM_TYPE, 'truecolor'))
    error('O Input "IM_path" deve levar a uma Imagem no modelo RGB')
end

%Leitura da Imagem no Modelo RGB
IM_RGB = imread(IM_path);

%Decomposição das Componentes RGB
R = IM_RGB(:,:,1);
G = IM_RGB(:,:,2);
B = IM_RGB(:,:,3);

%Conversão da Imagem para o Modelo HSV
IM_HSV = uint8(rgb2hsv(IM_RGB)*255);

%Decomposição das Componentes HSV
H = IM_HSV(:,:,1);
S = IM_HSV(:,:,2);
V = IM_HSV(:,:,3);

%Plot das Imagens
figure(1), imshow(IM_RGB), title('Imagem Original de Três Bandas')
figure(2)
subplot(2,3,1), imshow(R), title('Componente Red da Imagem no Modelo RGB')
subplot(2,3,2), imshow(G), title('Componente Green da Imagem no Modelo RGB')
subplot(2,3,3), imshow(B), title('Componente Blue da Imagem no Modelo RGB')
subplot(2,3,4), imhist(R), title(sprintf('Histograma da Componente Red \n da Imagem no Modelo RGB'))
subplot(2,3,5), imhist(G), title(sprintf('Histograma da Componente Green \n da Imagem no Modelo RGB'))
subplot(2,3,6), imhist(B), title(sprintf('Histograma da Componente Blue \n da Imagem no Modelo RGB'))
figure(3)
subplot(2,3,1), imshow(H), title('Componente Hue da Imagem no Modelo HSV')
subplot(2,3,2), imshow(S), title('Componente Saturation da Imagem no Modelo HSV')
subplot(2,3,3), imshow(V), title('Componente Value da Imagem no Modelo HSV')
subplot(2,3,4), imhist(H), title(sprintf('Histograma da Componente Hue \n da Imagem no Modelo HSV'))
subplot(2,3,5), imhist(S), title(sprintf('Histograma da Componente Saturation \n da Imagem no Modelo HSV'))
subplot(2,3,6), imhist(V), title(sprintf('Histograma da Componente Value \n da Imagem no Modelo HSV'))

end

