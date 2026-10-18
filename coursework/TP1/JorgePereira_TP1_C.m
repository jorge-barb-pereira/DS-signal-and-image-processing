%Exercicio C, criado por: Jorge Barbosa Pereira

%JorgePereira_TP1_C('Robot_BW.tif', 0.5);-> Exemplo de execução para gerar uma figura com as várias Imagens Transformadas e os seus Histogramas de Cinzentos

function [IM_T,IM_G,IM_E] = JorgePereira_TP1_C(im_path,gamma)

%Leitura da Imagem Original
IM_O = imread(im_path);

%Formação da Imagem com Transformação Linear Ótima
max_O = double(max(max(IM_O)));
min_O = double(min(min(IM_O)));
alpha = 255 /(max_O - min_O);
beta = - alpha * min_O;
IM_T = double(IM_O) .* alpha + beta;
IM_T = uint8(IM_T);

%Formação da Imagem com Transformação Gamma
IM_G = (double(IM_O)/255) .^ gamma;
IM_G = uint8(IM_G*255);

%Formação da Imagem Equalizada
IM_E = histeq(IM_O);


subplot(2,4,1), imshow(IM_O), title(sprintf('Imagem Original - IM_O \n Cinzentos entre [%d:%d]  ',min_O,max_O))
subplot(2,4,2), imshow(IM_T), title('Imagem com Transf. Linear Óptima - IM_T')
subplot(2,4,3), imshow(IM_G), title(sprintf('Imagem com Transf. Gamma %0.2f - IM_G', gamma))
subplot(2,4,4), imshow(IM_E), title('Imagem Equalizada - IM_E')
subplot(2,4,5), imhist(IM_O), title('Histograma de Cinzentos de IM_O')
subplot(2,4,6), imhist(IM_T), title('Histograma de Cinzentos de IM_T')
subplot(2,4,7), imhist(IM_G), title('Histograma de Cinzentos de IM_G')
subplot(2,4,8), imhist(IM_E), title('Histograma de Cinzentos de IM_E')

end
