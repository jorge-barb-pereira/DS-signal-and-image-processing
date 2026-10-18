%Função Complementar ao Exercicio H, criado por: Jorge Barbosa Pereira

function [IM_LOC] = JorgePereira_TP2_H_Local(IM_O, S, dp_factor, t_factor)

[N_L, N_C, N_B] = size(IM_O);

if N_B ~= 1
    error('O Input "IM_O" ser uma Imagem na Escala de Cinzentos')
elseif S<1 || S>20
    error('O Input "S" deve estar entre 1 e 20')
elseif mod(S,1) ~= 0
    S=round(S);
    warning('O Input "S" deve ser um inteiro e foi automáticamente redefenido para S=%d',S)
end

%Calculo do Thresholding Global e Limiar
T_GLO_d = graythresh(IM_O);
T_GLO = uint8(T_GLO_d * 255);
T_LIMIAR = T_GLO * t_factor;

%Calculo do Desvio Padrão Global e Limiar
DP_IM_O = std2(IM_O);
DP_LIMIAR = DP_IM_O * (dp_factor/sqrt(2*S));

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
%Se não, considera a Subdivisão Segmento               
            else
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
end

