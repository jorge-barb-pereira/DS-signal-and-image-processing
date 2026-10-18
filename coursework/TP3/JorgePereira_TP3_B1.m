%Exercicio B1, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_B1('Aguia.jpg');
%JorgePereira_TP3_B1('Fringe.jpg');

function [] = JorgePereira_TP3_B1(IM_path)

%Leitura da Imagem
IM_O = imread(IM_path);

%Criação dos Elementos Estruturnates Circulares com Diferentes Raios
E_3 = strel('disk',3);
E_5 = strel('disk',5);
E_10 = strel('disk',10);

%Formação das Imagem com Erosão
IM_E_3 = imerode(IM_O,E_3);
IM_E_5 = imerode(IM_O,E_5);
IM_E_10 = imerode(IM_O,E_10);

%Formação das Imagem com Dilatação
IM_D_3 = imdilate(IM_O,E_3);
IM_D_5 = imdilate(IM_O,E_5);
IM_D_10 = imdilate(IM_O,E_10);

%Formação das Imagem com Abertura
IM_A_3 = imopen(IM_O,E_3);
IM_A_5 = imopen(IM_O,E_5);
IM_A_10 = imopen(IM_O,E_10);

%Formação das Imagem com Fecho
IM_F_3 = imclose(IM_O,E_3);
IM_F_5 = imclose(IM_O,E_5);
IM_F_10 = imclose(IM_O,E_10);

%Plot das Imagens
subplot(3,4,1),imshow(IM_E_3),title(sprintf('Imagem com Erosão por \n Elemento Estruturante de Raio 3'))
subplot(3,4,5),imshow(IM_E_5),title(sprintf('Imagem com Erosão por \n Elemento Estruturante de Raio 5'))
subplot(3,4,9),imshow(IM_E_10),title(sprintf('Imagem com Erosão por \n Elemento Estruturante de Raio 10'))
subplot(3,4,2),imshow(IM_D_3),title(sprintf('Imagem com Dilatação por \n Elemento Estruturante de Raio 3'))
subplot(3,4,6),imshow(IM_D_5),title(sprintf('Imagem com Dilatação por \n Elemento Estruturante de Raio 5'))
subplot(3,4,10),imshow(IM_D_10),title(sprintf('Imagem com Dilatação por \n Elemento Estruturante de Raio 10'))
subplot(3,4,3),imshow(IM_A_3),title(sprintf('Imagem com Abertura por \n Elemento Estruturante de Raio 3'))
subplot(3,4,7),imshow(IM_A_5),title(sprintf('Imagem com Abertura por \n Elemento Estruturante de Raio 5'))
subplot(3,4,11),imshow(IM_A_10),title(sprintf('Imagem com Abertura por \n Elemento Estruturante de Raio 10'))
subplot(3,4,4),imshow(IM_F_3),title(sprintf('Imagem com Fecho por \n Elemento Estruturante de Raio 3'))
subplot(3,4,8),imshow(IM_F_5),title(sprintf('Imagem com Fecho por \n Elemento Estruturante de Raio 5'))
subplot(3,4,12),imshow(IM_F_10),title(sprintf('Imagem com Fecho por \n Elemento Estruturante de Raio 10'))
end

