%Exercicio A1, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_A1('Aguia.jpg',1);
%JorgePereira_TP3_A1('Fringe.jpg',1);

function [IM_BIN_FIN] = JorgePereira_TP3_A1(IM_path,graf)

%Leitura da Imagem
IM_O = imread(IM_path);
IM_TYPE = imfinfo(IM_path).ColorType;

%Distinção dos ColorTypes das Imagens
if strcmp(IM_TYPE, 'grayscale')
    IM_C = IM_O;
elseif strcmp(IM_TYPE, 'truecolor')  
    IM_C = rgb2gray(IM_O);
else
    warning('O Input "IM_path" levou a uma Imagem cujo Colortype não é "gayscale" nem "truecolor" e como tal a classificação da imagem foi feita tendo em conta o número de bandas')
    [~,~,N_B] = size(IM_O);
    if N_B == 1
        IM_C = IM_O;
    elseif N_B == 3
        IM_C = rgb2gray(IM_O);
    end
end

%Realiza a Segmentação da Imagem pelo metodo de OTSU
T_OTSU_d = graythresh(IM_C);
IM_BIN_OTSU = imbinarize(IM_C, T_OTSU_d);

%Calculo do Indice da Linha e Coluna Mediana
[N_L, N_C, ~] = size(IM_BIN_OTSU);
I_L_med = (N_L + 1) / 2;
I_C_med = (N_C + 1) / 2;

%Calculo dos Indices da Secção Central (50%)
I_L_inf = floor(I_L_med - N_L / (2*sqrt(2)));
I_L_sup = ceil(I_L_med + N_L / (2*sqrt(2)));
I_C_inf = floor(I_C_med - N_C / (2*sqrt(2)));
I_C_sup = ceil(I_C_med + N_C / (2*sqrt(2)));

%Criação da sub Imagem com o Centro da Imagem Original
IM_CENT = IM_BIN_OTSU(I_L_inf : I_L_sup, I_C_inf : I_C_sup);
[N_L_CENT,N_C_CENT] = size(IM_CENT);

%Criação da sub Imagem com a Margem da Imagem Original
IM_MARG = IM_BIN_OTSU;
IM_MARG(I_L_inf : I_L_sup, I_C_inf : I_C_sup) = false(N_L_CENT, N_C_CENT);

%Calculo da percentagem de Trues nas sub Imagens
TRUE_PER_CENT = sum(IM_CENT,'all')/(N_L_CENT*N_C_CENT)*100;
TRUE_PER_MARG = sum(IM_MARG,'all')/(N_L*N_C - N_L_CENT*N_C_CENT)*100;

%Verificação da Necessidade de Inverter a Imagem segmentada pelo metodo de OTSU
if TRUE_PER_CENT > TRUE_PER_MARG
    IM_BIN_FIN = IM_BIN_OTSU;
else
    IM_BIN_FIN = imcomplement(IM_BIN_OTSU);
end

%Plot das imagens
if graf == 1
    subplot(2,2,1),imshow(IM_O), title('Imagem Original')
    subplot(2,2,2),imshow(IM_C), title('Imagem Original na Escala de Cinzentos')
    subplot(2,2,3),imshow(IM_BIN_OTSU), title(sprintf('Imagem Binária por Tresholding Global de Otsu \n P_{Margem} (True) = %0.1f%%  |  P_{Centro} (True) = %0.1f%%',TRUE_PER_MARG,TRUE_PER_CENT))
    subplot(2,2,4),imshow(IM_BIN_FIN), title(sprintf('Imagem Binária Final'))
end
end