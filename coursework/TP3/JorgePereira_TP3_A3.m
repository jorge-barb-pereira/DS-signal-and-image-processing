%Exercicio A3, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_A3('Aguia.jpg',1);
%JorgePereira_TP3_A3('Fringe.jpg',1);

function [IM_B1,IM_B2] = JorgePereira_TP3_A3(IM_path,graf)

%Leitura da Imagem
IM_O = imread(IM_path);

%Formação da Imagem Binária
IM_B = JorgePereira_TP3_A1(IM_path,0);

%Formação da Imagem de Etiquetas
IM_E = JorgePereira_TP3_A2(IM_path,0);

%Extração do Número de Obejtos
[N_L,N_C] = size(IM_E);
N_O = max(max(IM_E));

SOMA_B1 = 0;
SOMA_B2 = 0;
for i = 1:N_O
    
    %Determinação do Maior Objeto
    IM_OBJ = (IM_E==i);
    SOMA_OBJ = sum(IM_OBJ,'all');
    
    if SOMA_OBJ > SOMA_B1
        IM_B1 = IM_OBJ;
        SOMA_B1 = sum(IM_B1,'all');
    end
    
    %Determinação do Maior Objeto que Não Toca a Margem (2 pixeis)
    IM_OBJ_MARG = IM_OBJ;
    IM_OBJ_MARG(3:N_L-2,3:N_C-2) = false(N_L-4,N_C-4);
    
    if sum(IM_OBJ_MARG,'all') == 0 && SOMA_OBJ > SOMA_B2
        IM_B2 = IM_OBJ;
        SOMA_B2 = sum(IM_B2,'all');
    end   
end

%Plot das imagens
if graf == 1
    subplot(2,2,1),imshow(IM_O), title('Imagem Original')
    subplot(2,2,2),imshow(IM_B), title('Imagem Binária')
    subplot(2,2,3),imshow(IM_B1), title('Imagem Binária do Maior Objeto')
    subplot(2,2,4),imshow(IM_B2), title('Imagem Binária do Maior Objeto que não toca a Margem')
end


