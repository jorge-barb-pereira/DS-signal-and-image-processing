%Exercicio E, criado por: Jorge Barbosa Pereira

%JorgePereira_TP1_E('Robot_BW.tif', 0.1) -> Exemplo de execução para gerar duas figuras com várias imagens depois de aplicação de filtros média e mediana com padding simétrico e zero respetivamente

function [] = JorgePereira_TP1_E(im_path,noise)

%Leitura da Imagem Original
IM_O = imread(im_path);
IM_O_d = double(IM_O);

%Formação da Imagem com Ruído Sal & Pimenta
IM_N = imnoise(IM_O, 'salt & pepper', noise);
IM_N_d = double(IM_N);

%Aplicação de filtros Média e Mediana à Imagem com Ruído com Padding Simétrico
AVE_3X3 = fspecial('average', 3);
AVE_5X5 = fspecial('average', 5);
IM_AVE_3X3 = imfilter(IM_N, AVE_3X3, 'symmetric');
IM_AVE_3X3_d = double(IM_AVE_3X3);
IM_AVE_5X5 = imfilter(IM_N, AVE_5X5, 'symmetric');
IM_AVE_5X5_d = double(IM_AVE_5X5);
IM_MED_3X3 = medfilt2(IM_N, [3 3], 'symmetric');
IM_MED_3X3_d = double(IM_MED_3X3);
IM_MED_5X5 = medfilt2(IM_N, [5 5], 'symmetric');
IM_MED_5X5_d = double(IM_MED_5X5);

%Calculo do erro absoluto médio inicial devido unicamente ao ruído
E_N = mean2(abs(IM_O_d - IM_N_d));

%Calculo dos erros absolutos médios das imagens com filtro com padding simétrico
E_AVE_3X3 = mean2(abs(IM_O_d - IM_AVE_3X3_d));
E_AVE_5X5 = mean2(abs(IM_O_d - IM_AVE_5X5_d));
E_MED_3X3 = mean2(abs(IM_O_d - IM_MED_3X3_d));
E_MED_5X5 = mean2(abs(IM_O_d - IM_MED_5X5_d));

figure(1)
subplot(2,3,1),imshow(IM_O),title('Imagem Original')
subplot(2,3,2),imshow(IM_AVE_3X3),title(sprintf('  Padding Simétrico \n \n Imagem com Ruído e Filtro de Média 3x3 | <Erro>=%0.2f',E_AVE_3X3))
subplot(2,3,3),imshow(IM_AVE_5X5),title(sprintf('Imagem com Ruído e Filtro de Média 5x5 | <Erro>=%0.2f',E_AVE_5X5))
subplot(2,3,4),imshow(IM_N),title(sprintf('Imagem com Ruído | <Erro>=%0.2f',E_N))
subplot(2,3,5),imshow(IM_MED_3X3),title(sprintf('Imagem com Ruído e Filtro de Mediana 3x3 | <Erro>=%0.2f',E_MED_3X3))
subplot(2,3,6),imshow(IM_MED_5X5),title(sprintf('Imagem com Ruído e Filtro de Mediana 5x5 | <Erro>=%0.2f',E_MED_5X5))

%Aplicação de filtros Média e Mediana à Imagem com Ruído com Padding Zeros
IM_AVE_3X3 = imfilter(IM_N, AVE_3X3, 0);
IM_AVE_3X3_d = double(IM_AVE_3X3);
IM_AVE_5X5 = imfilter(IM_N, AVE_5X5, 0);
IM_AVE_5X5_d = double(IM_AVE_5X5);
IM_MED_3X3 = medfilt2(IM_N, [3 3], 'zero');
IM_MED_3X3_d = double(IM_MED_3X3);
IM_MED_5X5 = medfilt2(IM_N, [5 5], 'zero');
IM_MED_5X5_d = double(IM_MED_5X5);

%Calculo dos erros absolutos médios das imagens com filtro com padding zeros
E_AVE_3X3 = mean2(abs(IM_O_d - IM_AVE_3X3_d));
E_AVE_5X5 = mean2(abs(IM_O_d - IM_AVE_5X5_d));
E_MED_3X3 = mean2(abs(IM_O_d - IM_MED_3X3_d));
E_MED_5X5 = mean2(abs(IM_O_d - IM_MED_5X5_d));

figure(2)
subplot(2,3,1),imshow(IM_O),title('Imagem Original')
subplot(2,3,2),imshow(IM_AVE_3X3),title(sprintf('  Padding 0 \n \n Imagem com Ruído e Filtro de Média 3x3 | <Erro>=%0.2f',E_AVE_3X3))
subplot(2,3,3),imshow(IM_AVE_5X5),title(sprintf('Imagem com Ruído e Filtro de Média 5x5 | <Erro>=%0.2f',E_AVE_5X5))
subplot(2,3,4),imshow(IM_N),title(sprintf('Imagem com Ruído | <Erro>=%0.2f',E_N))
subplot(2,3,5),imshow(IM_MED_3X3),title(sprintf('Imagem com Ruído e Filtro de Mediana 3x3 | <Erro>=%0.2f',E_MED_3X3))
subplot(2,3,6),imshow(IM_MED_5X5),title(sprintf('Imagem com Ruído e Filtro de Mediana 5x5 | <Erro>=%0.2f',E_MED_5X5))
end

