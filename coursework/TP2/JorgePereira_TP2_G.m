%Exercicio G, criado por: Jorge Barbosa Pereira

%Alguns Exemplos de Segmentação Satisfatória:

%JorgePereira_TP2_G('seg1.jpg',2,1);
%JorgePereira_TP2_G('seg2.jpg',2,1);
%JorgePereira_TP2_G('seg3.jpg',2,1);
%JorgePereira_TP2_G('TextoDig.jpg',3,1);
%JorgePereira_TP2_G('Robot_RGB.tif',3,1);

function [IM_LOC] = JorgePereira_TP2_G(IM_path, S, Graph)

IM_TYPE = imfinfo(IM_path).ColorType;
if strcmp(IM_TYPE, 'grayscale')
    IM_O = imread(IM_path);
elseif strcmp(IM_TYPE, 'truecolor')
    IM_O = rgb2gray(imread(IM_path));
else
    error('O Input "IM_path" deve levar a uma Imagem no modelo RGB ou a uma Imagem na Escala de Cinzentos')
end

if S<1 || S>20
    error('O Input "S" deve estar entre 1 e 20')
elseif ~ismember(Graph, [0 ,1])
    error('Input "graf" deve ser 0 ou 1')
elseif mod(S,1) ~= 0
    S=round(S);
    warning('O Input "S" deve ser um inteiro e foi automáticamente redefenido para S=%d',S)
end

%Calculo do Thresholding Global e Limiar
T_GLO_d = graythresh(IM_O);
IM_GLO = imbinarize(IM_O, T_GLO_d);
T_GLO = uint8(T_GLO_d * 255);
T_LIMIAR = T_GLO;


%Calculo do Desvio Padrão Global e Limiar
DP_IM_O = std2(IM_O);
DP_LIMIAR = DP_IM_O * (1/sqrt(2*S));

[N_L, N_C, ~] = size(IM_O);
I_L_PRE = 1;
I_C_PRE = 1;
N_L_SUB = floor(N_L/S);
N_C_SUB = floor(N_C/S);

%Percorre as Várias Subdivisões
for C = 1:S
    
    I_C_POS = I_C_PRE + N_C_SUB;
    if I_C_POS > N_C
        I_C_POS = N_C;
    end
    
    for L = 1:S
        
        I_L_POS = I_L_PRE + N_L_SUB;
        if I_L_POS > N_L
            I_L_POS = N_L;
        end
        
        IM_SUB = IM_O(I_L_PRE:I_L_POS,I_C_PRE:I_C_POS);
        DP_IM_SUB = std2(IM_SUB);
        
%Verifica se o Desvio Padrão da Subdivisão é inferior ao Desvio Padrão Limiar        
        if DP_IM_SUB < DP_LIMIAR
%Se sim, considera a Subdivisão Homogénea
%Verifica se a Média da Subdivisão é inferior ao Thresholding Limiar
            if mean2(IM_SUB) < T_LIMIAR
%Se sim, considera a Subdivisão Fundo
                IM_BIN_SUB = false(I_L_POS-I_L_PRE+1,I_C_POS-I_C_PRE+1);              
            else
%Se não, considera a Subdivisão Segmento 
                IM_BIN_SUB = true(I_L_POS-I_L_PRE+1,I_C_POS-I_C_PRE+1);
            end
%Caso a Subdivisão não seja Homogénea realiza a Segmentação por OTSU
        else
            IM_BIN_SUB = imbinarize(IM_SUB, graythresh(IM_SUB));        
        end
        
%Substitui a Subdivisão Processada na Imagem Final      
        IM_LOC(I_L_PRE:I_L_POS,I_C_PRE:I_C_POS) =  IM_BIN_SUB;

        I_L_PRE = I_L_POS + 1;
    end
    
    I_L_PRE = 1;
    I_C_PRE = I_C_POS + 1;
end

%Verifica se é pretendido fazer o Plot das Imagens
if Graph == 1
    subplot(1,3,1),imshow(IM_O), title('Imagem Original na Escala de Cinzentos')
    subplot(1,3,2),imshow(IM_GLO), title(sprintf('Imagem Binária por Tresholding Global de Otsu | T_{Otsu} = %d',T_GLO))
    subplot(1,3,3),imshow(IM_LOC), title(sprintf('Imagem Binária por Tresholding Local | %d x %d',S,S))
end
end