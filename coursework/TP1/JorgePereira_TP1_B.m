%Exercicio B, criado por: Jorge Barbosa Pereira

%Leitura da Imagem Original
IM_O = imread('Robot_BW.tif');

%Formação de Imagens com diferentes Transformações de Contraste
IM_C1 = IM_O * (1/3);
IM_C2 = IM_O * (2/3);
IM_C3 = IM_O * (4/3);
IM_C4 = IM_O * (5/3);
IM_C5 = IM_O * (6/3);

figure(1)
subplot(2,3,1),imshow(IM_C1),title('Imagem com Transf. de Contraste de ~ *0.33')
subplot(2,3,2),imshow(IM_C2),title('Imagem com Transf. de Contraste de ~ *0.66')
subplot(2,3,3),imshow(IM_O),title('Imagem Original')
subplot(2,3,4),imshow(IM_C3),title('Imagem com Transf. de Contraste de ~ *1.33')
subplot(2,3,5),imshow(IM_C4),title('Imagem com Transf. de Contraste de ~ *1.66')
subplot(2,3,6),imshow(IM_C5),title('Imagem com Transf. de Contraste de ~ *2.00')

%Formação de Imagens com diferentes Transformações de Luminosidade
IM_L1 = IM_O - (256*2/6);
IM_L2 = IM_O - (256/6);
IM_L3 = IM_O + (256/6);
IM_L4 = IM_O + (256*2/6);
IM_L5 = IM_O + (256*3/6);

figure(2)
subplot(2,3,1),imshow(IM_L1),title('Imagem com Transf. de Luminosidade de ~ -85')
subplot(2,3,2),imshow(IM_L2),title('Imagem com Transf. de Luminosidade de ~ -43')
subplot(2,3,3),imshow(IM_O),title('Imagem Original')
subplot(2,3,4),imshow(IM_L3),title('Imagem com Transf. de Luminosidade de ~ +43')
subplot(2,3,5),imshow(IM_L4),title('Imagem com Transf. de Luminosidade de ~ +85')
subplot(2,3,6),imshow(IM_L5),title('Imagem com Transf. de Luminosidade de ~ +128')

%Formação de Imagens com diferentes Transformações Gamma
IM_G1 = (double(IM_O)/255) .^ (0.33);
IM_G1 = uint8(IM_G1*255);
IM_G2 = (double(IM_O)/255) .^ (2/3);
IM_G2 = uint8(IM_G2*255);
IM_G3 = (double(IM_O)/255) .^ (4/3);
IM_G3 = uint8(IM_G3*255);
IM_G4 = (double(IM_O)/255) .^ (5/3);
IM_G4 = uint8(IM_G4*255);
IM_G5 = (double(IM_O)/255) .^ (5/3);
IM_G5 = uint8(IM_G5*255);

figure(3)
subplot(2,3,1),imshow(IM_G1),title('Imagem com Transf. Gamma de ~ 0.33')
subplot(2,3,2),imshow(IM_G2),title('Imagem com Transf. Gamma de ~ 0.66')
subplot(2,3,3),imshow(IM_O),title('Imagem Original')
subplot(2,3,4),imshow(IM_G3),title('Imagem com Transf. Gamma de ~ 1.33')
subplot(2,3,5),imshow(IM_G4),title('Imagem com Transf. Gamma de ~ 1.66')
subplot(2,3,6),imshow(IM_G5),title('Imagem com Transf. Gamma de ~ 2.00')

%Formação das Imagens Equalizada e Negativa (Invertida)
IM_E = histeq(IM_O);
IM_I = imcomplement(IM_O);

figure(4)
subplot(2,3,1),imshow(IM_O),title('Imagem Original - IM_O')
subplot(2,3,2),imshow(IM_E),title('Imagem Equalizada - IM_E')
subplot(2,3,3),imshow(IM_I),title('Imagem Negativa (Invertida) - IM_I')
subplot(2,3,4),imhist(IM_O),title('Histograma de Cinzentos de - IM_O')
subplot(2,3,5),imhist(IM_E),title('Histograma de Cinzentos de IM_E')
subplot(2,3,6),imhist(IM_I),title('Histograma de Cinzentos de IM_I')
