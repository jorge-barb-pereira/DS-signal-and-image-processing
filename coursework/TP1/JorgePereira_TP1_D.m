%Exercicio D, criado por: Jorge Barbosa Pereira

%JorgePereira_TP1_D('Robot_BW.tif', 'CretaGRAY_BaixoContraste1.jpg'); -> Exemplo de execução para gerar uma figura com as várias Imagens e os seus Histogramas de Cinzentos

function [IM_E] = JorgePereira_TP1_D(im_path,ref_path)

%Leitura da Imagem Original
IM_O = imread(im_path);

%Leitura da Imagem de Referência
IM_R = imread(ref_path);
%Formação da Imagem Especificada
IM_E = histeq(IM_O, imhist(IM_R) ./ numel(IM_R));

subplot(2,3,1), imshow(IM_O), title('Imagem Original - IM_O')
subplot(2,3,2), imshow(IM_R), title('Imagem de Referência - IM_R')
subplot(2,3,3), imshow(IM_E), title('Imagem Especificada - IM_E')
subplot(2,3,4), imhist(IM_O), title('Histograma de Cinzentos de IM_O')
subplot(2,3,5), imhist(IM_R), title('Histograma de Cinzentos de IM_R')
subplot(2,3,6), imhist(IM_E), title('Histograma de Cinzentos de IM_E')

end

