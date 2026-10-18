%Exercicio B2, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_B2('Aguia.jpg');
%JorgePereira_TP3_B2('Fringe.jpg');

function [] = JorgePereira_TP3_B2(IM_path)

%Leitura da Imagem
IM_O = imread(IM_path);

%Formação da Imagem Binária
IM_B = JorgePereira_TP3_A1(IM_path,0);

%Criação dos Elementos Estruturnates Circulares com Diferentes Raios
E_3 = strel('disk',3,0);
E_5 = strel('disk',5,0);
E_10 = strel('disk',10,0);

%Formação das Imagens com Erosão
IM_E_3 = imerode(IM_B,E_3);
IM_E_5 = imerode(IM_B,E_5);
IM_E_10 = imerode(IM_B,E_10);

%Formação das Imagens com Dilatação
IM_D_3 = imdilate(IM_B,E_3);
IM_D_5 = imdilate(IM_B,E_5);
IM_D_10 = imdilate(IM_B,E_10);

%Formação das Imagens com Abertura
IM_A_3 = imopen(IM_B,E_3);
IM_A_5 = imopen(IM_B,E_5);
IM_A_10 = imopen(IM_B,E_10);

%Formação das Imagens com Fecho
IM_F_3 = imclose(IM_B,E_3);
IM_F_5 = imclose(IM_B,E_5);
IM_F_10 = imclose(IM_B,E_10);

%Plot das Imagens
figure(1)
subplot(1,2,1),imshow(IM_O),title('Imagem Original')
subplot(1,2,2),imshow(IM_B),title('Imagem Binária')

figure(2)
subplot(3,4,1),imshow(IM_E_3),title(sprintf('Imagem Binária com Erosão por \n Elemento Estruturante de Raio 3'))
subplot(3,4,5),imshow(IM_E_5),title(sprintf('Imagem Binária com Erosão por \n Elemento Estruturante de Raio 5'))
subplot(3,4,9),imshow(IM_E_10),title(sprintf('Imagem Binária com Erosão por \n Elemento Estruturante de Raio 10'))
subplot(3,4,2),imshow(IM_D_3),title(sprintf('Imagem Binária com Dilatação por \n Elemento Estruturante de Raio 3'))
subplot(3,4,6),imshow(IM_D_5),title(sprintf('Imagem Binária com Dilatação por \n Elemento Estruturante de Raio 5'))
subplot(3,4,10),imshow(IM_D_10),title(sprintf('Imagem Binária com Dilatação por \n Elemento Estruturante de Raio 10'))
subplot(3,4,3),imshow(IM_A_3),title(sprintf('Imagem Binária com Abertura por \n Elemento Estruturante de Raio 3'))
subplot(3,4,7),imshow(IM_A_5),title(sprintf('Imagem Binária com Abertura por \n Elemento Estruturante de Raio 5'))
subplot(3,4,11),imshow(IM_A_10),title(sprintf('Imagem Binária com Abertura por \n Elemento Estruturante de Raio 10'))
subplot(3,4,4),imshow(IM_F_3),title(sprintf('Imagem Binária com Fecho por \n Elemento Estruturante de Raio 3'))
subplot(3,4,8),imshow(IM_F_5),title(sprintf('Imagem Binária com Fecho por \n Elemento Estruturante de Raio 5'))
subplot(3,4,12),imshow(IM_F_10),title(sprintf('Imagem Binária com Fecho por \n Elemento Estruturante de Raio 10'))
end

