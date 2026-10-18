%Exercicio D, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP2_D('Robot_RGB.tif')
%JorgePereira_TP2_D('ArTe.jpg')
%JorgePereira_TP2_D('Kandinsky.jpg')

function [] = JorgePereira_TP2_D(IM_path)

IM_TYPE = imfinfo(IM_path).ColorType;
if not(strcmp(IM_TYPE, 'truecolor'))
    error('O Input "IM_path" deve levar a uma Imagem no modelo RGB')
end

%Leitura da Imagem no modelo RGB
IM_O_RGB = imread(IM_path);

%Calculo do Indice da Linha e Coluna Mediana
[N_L, N_C, ~] = size(IM_O_RGB);
I_L_med = (N_L + 1) / 2;
I_C_med = (N_C + 1) / 2;

%Calculo dos Indices da Secção Central
N_L_20 = N_L/20;
N_C_20 = N_C/20;
I_L_inf = 9 * N_L_20;
I_L_sup = 11 * N_L_20;
I_C_inf = 9 * N_C_20;
I_C_sup = 11 * N_C_20;

%Verifica se a Linha Mediana é Bem Defenida
if mod(N_L_20,1) == 0
    I_L_inf = I_L_inf + 1;
else
    I_L_inf = ceil(I_L_inf);
    I_L_sup = ceil(I_L_sup);
end

%Verifica se a Coluna Mediana é Bem Defenida
if mod(N_C_20,1) == 0
    I_C_inf = I_C_inf + 1;
else
    I_C_inf = ceil(I_C_inf);
    I_C_sup = ceil(I_C_sup);
end

IM_SUB_RGB = IM_O_RGB(I_L_inf : I_L_sup, I_C_inf : I_C_sup, : );

[N_L_SUB, N_C_SUB, ~]= size(IM_SUB_RGB);

perc = (N_L_SUB*N_C_SUB)/(N_L*N_C) * 100;

%Calulo dos Valores Caracteristicos da Componentes R da Secção Central
IM_SUB_R = IM_SUB_RGB(:,:,1);
R_med = mean2(IM_SUB_R);
R_dp = std2(IM_SUB_R);
R_min = min(min(IM_SUB_R));
R_max = max(max(IM_SUB_R));

%Calulo dos Valores Caracteristicos da Componentes G da Secção Central
IM_SUB_G = IM_SUB_RGB(:,:,2);
G_med = mean2(IM_SUB_G);
G_dp = std2(IM_SUB_G);
G_min = min(min(IM_SUB_R));
G_max = max(max(IM_SUB_R));

%Calulo dos Valores Caracteristicos da Componentes B da Secção Central
IM_SUB_B = IM_SUB_RGB(:,:,3);
B_med = mean2(IM_SUB_B);
B_dp = std2(IM_SUB_B);
B_min = min(min(IM_SUB_B));
B_max = max(max(IM_SUB_B));

%Conversão da Imagem para o modelo HSV
IM_SUB_HSV = uint8(rgb2hsv(IM_SUB_RGB)*255);

%Calulo dos Valores Caracteristicos da Componentes H da Secção Central
IM_SUB_H = IM_SUB_HSV(:,:,1);
H_med = mean2(IM_SUB_H);
H_dp = std2(IM_SUB_H);
H_min = min(min(IM_SUB_H));
H_max = max(max(IM_SUB_H));

%Calulo dos Valores Caracteristicos da Componentes S da Secção Central
IM_SUB_S = IM_SUB_HSV(:,:,2);
S_med = mean2(IM_SUB_S);
S_dp = std2(IM_SUB_S);
S_min = min(min(IM_SUB_S));
S_max = max(max(IM_SUB_S));

%Calulo dos Valores Caracteristicos da Componentes V da Secção Central
IM_SUB_V = IM_SUB_HSV(:,:,3);
V_med = mean2(IM_SUB_V);
V_dp = std2(IM_SUB_V);
V_min = min(min(IM_SUB_V));
V_max = max(max(IM_SUB_V));

%Plot das Imagens
subplot(2,4,1), imshow(IM_O_RGB), title(sprintf('Imagem Original de Três Bandas \n Tamanho = %d x %d | Ponto Mediano = (%0.1f , %0.1f)', N_L, N_C, I_L_med, I_C_med),'FontSize', 8)
subplot(2,4,2), imshow(IM_SUB_R),title(sprintf('Componente Red da Sub-imagem no Modelo RGB \n méd. = %0.1f | desv. padr. = %0.1f | mín. = %d | máx. = %d', R_med, R_dp, R_min, R_max),'FontSize', 8) 
subplot(2,4,3), imshow(IM_SUB_G),title(sprintf('Componente Green da Sub-imagem no Modelo RGB \n méd. = %0.1f | desv. padr. = %0.1f | mín. = %d | máx. = %d', G_med, G_dp, G_min, G_max),'FontSize', 8)
subplot(2,4,4), imshow(IM_SUB_B),title(sprintf('Componente Blue da Sub-imagem no Modelo RGB\n méd. = %0.1f | desv. padr. = %0.1f | mín. = %d | máx. = %d', B_med, B_dp, B_min, B_max),'FontSize', 8)
subplot(2,4,5), imshow(IM_SUB_RGB),title(sprintf('Sub-Imagem centrada no Ponto Mediano da Imagem Original \n Tamanho = %d x %d | Percentagem da Imagem Original = %0.1f%%', N_L_SUB, N_C_SUB, perc),'FontSize', 8)
subplot(2,4,6), imshow(IM_SUB_H),title(sprintf('Componente Hue da Sub-imagem no Modelo HSV \n méd. = %0.1f | desv. padr. = %0.1f | mín. = %d | máx. = %d', H_med, H_dp, H_min, H_max),'FontSize', 8)
subplot(2,4,7), imshow(IM_SUB_S),title(sprintf('Componente Saturation da Sub-imagem no Modelo HSV \n méd. = %0.1f | desv. padr. = %0.1f | mín. = %d | máx. = %d', S_med, S_dp, S_min, S_max),'FontSize', 8)
subplot(2,4,8), imshow(IM_SUB_V),title(sprintf('Componente Value da Sub-imagem no Modelo HSV \n méd. = %0.1f | desv. padr. = %0.1f | mín. = %d | máx. = %d', V_med, V_dp, V_min, V_max),'FontSize', 8)
end