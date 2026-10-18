%Exercicio E, criado por: Jorge Barbosa Pereira

%Alguns Exemplos:
%JorgePereira_TP2_E('Robot_RGB.tif')
%JorgePereira_TP2_E('Kandinsky.jpg')
%JorgePereira_TP2_E('Kandinsky_99_99.jpg')

function [] = JorgePereira_TP2_E(IM_path)

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

%Formação dos Filtros de Contornos Sobel
FIL_SOBEL_H1 = fspecial('sobel');
FIL_SOBEL_H2 = -fspecial('sobel');
FIL_SOBEL_V1 = fspecial('sobel')';
FIL_SOBEL_V2 = -fspecial('sobel')';

%Contronos Horizontais das Componentes RGB
R_H = imfilter(R,FIL_SOBEL_H1,'symmetric') + imfilter(R,FIL_SOBEL_H2,'symmetric');
G_H = imfilter(G,FIL_SOBEL_H1,'symmetric') + imfilter(G,FIL_SOBEL_H2,'symmetric');
B_H = imfilter(B,FIL_SOBEL_H1,'symmetric') + imfilter(B,FIL_SOBEL_H2,'symmetric');

%Formação da Imagem com Contornos Horizontais no modelo RGB
IM_H = IM_RGB;
IM_H(:,:,1) = R_H;
IM_H(:,:,2) = G_H;
IM_H(:,:,3) = B_H;

%Contronos Verticais das Componentes RGB
R_V = imfilter(R,FIL_SOBEL_V1,'symmetric') + imfilter(R,FIL_SOBEL_V2,'symmetric');
G_V = imfilter(G,FIL_SOBEL_V1,'symmetric') + imfilter(G,FIL_SOBEL_V2,'symmetric');
B_V = imfilter(B,FIL_SOBEL_V1,'symmetric') + imfilter(B,FIL_SOBEL_V2,'symmetric');

%Formação da Imagem com Contornos Verticais no modelo RGB
IM_V = IM_RGB;
IM_V(:,:,1) = R_V;
IM_V(:,:,2) = G_V;
IM_V(:,:,3) = B_V;

%Formação da Imagem dos Cortornos Totais (Maximo dos Contronos Horizontais e dos Contornos Verticais)
IM_Cont(:,:,1) = max(R_H, R_V);
IM_Cont(:,:,2) = max(G_H, G_V);
IM_Cont(:,:,3) = max(B_H, B_V);


%Calculo dos Indices da Linha e Coluna Mediana
[N_L,N_C,~] = size(IM_RGB);
I_L_MED = (N_L + 1) / 2;
I_C_MED = (N_C + 1) / 2;

%Verifica se a Linha Mediana é Bem Defenida
if mod(I_L_MED,1) == 0
    
    L_MED_R = R(I_L_MED,:);
    L_MED_G = G(I_L_MED,:);
    L_MED_B = B(I_L_MED,:);
    
    L_MED_R_H = R_H(I_L_MED,:);
    L_MED_G_H = G_H(I_L_MED,:);
    L_MED_B_H = B_H(I_L_MED,:);
    
    L_MED_R_V = R_V(I_L_MED,:);
    L_MED_G_V = G_V(I_L_MED,:);
    L_MED_B_V = B_V(I_L_MED,:);
    
else
%Caso a Linha Mediana Não Seja Bem Defenida Calcula a Média das Linhas Adjacentes       
    L_MED_R = R(floor(I_L_MED),:)/2 + R(ceil(I_L_MED),:)/2;
    L_MED_G = G(floor(I_L_MED),:)/2 + G(ceil(I_L_MED),:)/2;
    L_MED_B = B(floor(I_L_MED),:)/2 + B(ceil(I_L_MED),:)/2;
    
    L_MED_R_H = R_H(floor(I_L_MED),:)/2 + R_H(ceil(I_L_MED),:)/2;
    L_MED_G_H = G_H(floor(I_L_MED),:)/2 + G_H(ceil(I_L_MED),:)/2;
    L_MED_B_H = B_H(floor(I_L_MED),:)/2 + B_H(ceil(I_L_MED),:)/2;
    
    L_MED_R_V = R_V(floor(I_L_MED),:)/2 + R_V(ceil(I_L_MED),:)/2;
    L_MED_G_V = G_V(floor(I_L_MED),:)/2 + G_V(ceil(I_L_MED),:)/2;
    L_MED_B_V = B_V(floor(I_L_MED),:)/2 + B_V(ceil(I_L_MED),:)/2;
end   

%Verifica se a Linha Coluna Mediana é Bem Defenida
if mod(I_C_MED,1) == 0
    
    C_MED_R = R(:,I_C_MED);
    C_MED_G = G(:,I_C_MED);
    C_MED_B = B(:,I_C_MED);
        
    C_MED_R_H = R_H(:,I_C_MED);
    C_MED_G_H = G_H(:,I_C_MED);
    C_MED_B_H = B_H(:,I_C_MED);
    
    C_MED_R_V = R_V(:,I_C_MED);
    C_MED_G_V = G_V(:,I_C_MED);
    C_MED_B_V = B_V(:,I_C_MED);
    
else
%Caso a Coluna Mediana Não Seja Bem Defenida Calcula a Média das Colunas Adjacentes

    C_MED_R = R(:,floor(I_C_MED))/2 + R(:,ceil(I_C_MED))/2;
    C_MED_G = G(:,floor(I_C_MED))/2 + G(:,ceil(I_C_MED))/2;
    C_MED_B = B(:,floor(I_C_MED))/2 + B(:,ceil(I_C_MED))/2;
    
    C_MED_R_H = R_H(:,floor(I_C_MED))/2 + R_H(:,ceil(I_C_MED))/2;
    C_MED_G_H = G_H(:,floor(I_C_MED))/2 + G_H(:,ceil(I_C_MED))/2;
    C_MED_B_H = B_H(:,floor(I_C_MED))/2 + B_H(:,ceil(I_C_MED))/2;
    
    C_MED_R_V = R_V(:,floor(I_C_MED))/2 + R_V(:,ceil(I_C_MED))/2;
    C_MED_G_V = G_V(:,floor(I_C_MED))/2 + G_V(:,ceil(I_C_MED))/2;
    C_MED_B_V = B_V(:,floor(I_C_MED))/2 + B_V(:,ceil(I_C_MED))/2;
   
end

%Plot das Imagens
figure (1)
subplot(2,2,1),imshow(IM_RGB),title('Imagem Original com Três Bandas')
subplot(2,2,2),imshow(IM_Cont),title('Contornos Totais (Horizontais e Verticais)')
subplot(2,2,3),imshow(IM_H),title('Contornos Horizontais')
subplot(2,2,4),imshow(IM_V),title('Contornos Verticais')

figure (2)
subplot(2,3,1)
hold on
plot(1:N_C, L_MED_R, 'Color', [0.9 0 0]),plot(1:N_C, L_MED_G, 'Color', [0 0.9 0]),plot(1:N_C, L_MED_B,'Color', [0 0 0.9])
title(sprintf('Intensidades das Componentes RGB \n da Imagem Original na Linha Mediana')),ylabel('Intensidades 8-bits'), xlabel('Indice do Pixel')
hold off

subplot(2,3,2)
hold on
plot(1:N_C, L_MED_R_H, 'Color', [0.9 0 0]),plot(1:N_C, L_MED_G_H, 'Color', [0 0.9 0]),plot(1:N_C, L_MED_B_H,'Color', [0 0 0.9])
title(sprintf('Intensidades das Componentes RGB \n dos Contornos Horizontais na Linha Mediana')),ylabel('Intensidades 8-bits'), xlabel('Indice do Pixel')
hold off

subplot(2,3,3)
hold on
plot(1:N_C, L_MED_R_V, 'Color', [0.9 0 0]),plot(1:N_C, L_MED_G_V, 'Color', [0 0.9 0]),plot(1:N_C, L_MED_B_V,'Color', [0 0 0.9])
title(sprintf('Intensidades das Componentes RGB \n dos Contornos Verticais na Linha Mediana')),ylabel('Intensidades 8-bits'), xlabel('Indice do Pixel')
hold off

subplot(2,3,4)
hold on
plot(1:N_L, C_MED_R, 'Color', [0.9 0 0]),plot(1:N_L, C_MED_G, 'Color', [0 0.9 0]),plot(1:N_L, C_MED_B,'Color', [0 0 0.9])
title(sprintf('Intensidades das Componentes RGB \n da Imagem Original na Coluna Mediana')),ylabel('Intensidades 8-bits'), xlabel('Indice do Pixel')
hold off

subplot(2,3,5)
hold on
plot(1:N_L, C_MED_R_H, 'Color', [0.9 0 0]),plot(1:N_L, C_MED_G_H, 'Color', [0 0.9 0]),plot(1:N_L, C_MED_B_H,'Color', [0 0 0.9])
title(sprintf('Intensidades das Componentes RGB \n dos Contornos Horizontais na Coluna Mediana')),ylabel('Intensidades 8-bits'), xlabel('Indice do Pixel')
hold off

subplot(2,3,6)
hold on
plot(1:N_L, C_MED_R_V, 'Color', [0.9 0 0]),plot(1:N_L, C_MED_G_V, 'Color', [0 0.9 0]),plot(1:N_L, C_MED_B_V,'Color', [0 0 0.9])
title(sprintf('Intensidades das Componentes RGB \n dos Contornos Verticais na Coluna Mediana')),ylabel('Intensidades 8-bits'), xlabel('Indice do Pixel')
hold off
end

