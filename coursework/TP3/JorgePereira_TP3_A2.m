%Exercicio A2, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_A2('Aguia.jpg',1);
%JorgePereira_TP3_A2('Fringe.jpg',1);

function [IM_E] = JorgePereira_TP3_A2(IM_path,graf)

%Leitura da Imagem
IM_O = imread(IM_path);

%Criação da Imagem Binária
IM_B = JorgePereira_TP3_A1(IM_path,0);

%Criação da Imagem de Etiquetas
[IM_E, N_Obj] = bwlabel(IM_B,8);
IM_E = uint16(IM_E);

%Criação da Tabela de Cores (Fundo Preto)
Tab = prism(N_Obj);
Tab = [[0,0,0];Tab];

%Plot das imagens
if graf == 1
    subplot(1,3,1),imshow(IM_O), title('Imagem Original')
    subplot(1,3,2),imshow(IM_B), title('Imagem Binária')
    subplot(1,3,3),imshow(IM_E,Tab), title(sprintf('Imagem de Etiquetas com %d Objetos',N_Obj))
end
end

