%Exercicio D2, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_D2('Aguia.jpg',31);
%JorgePereira_TP3_D2('Fringe.jpg',31);

function [] = JorgePereira_TP3_D2(IM_path,L)

if rem(L, 2) ~= 1
    error('O Input "L" deve ser um número inteiro ímpar')
end

%Leitura da Imagem
IM_O = imread(IM_path);
[~,~,N_B] = size(IM_O);

%Formação do Video de Média
VID_AVE = VideoWriter('Media.avi');
VID_AVE.FrameRate = 2;
open(VID_AVE)
writeVideo(VID_AVE, IM_O)

%Formação do Video de Mediana
VID_MED = VideoWriter('Mediana.avi');
VID_MED.FrameRate = 2;
open(VID_MED)
writeVideo(VID_MED, IM_O)

%Colocação das Várias Imagens nos Vários Videos
for l = 3:2:L
    IM_AVE = IM_O;
    IM_MED = IM_O;
    
    %Aplicação dos Filtros às Várias Bandas da Imagem
    for i = 1:N_B
        IM_AVE(:,:,i) = imfilter(IM_O(:,:,i), fspecial('average', l), 'symmetric');
        IM_MED(:,:,i) = medfilt2(IM_O(:,:,i), [l l], 'symmetric');
    end
    
    writeVideo(VID_AVE, IM_AVE)
    writeVideo(VID_MED, IM_MED)
end

%Encerramento dos Videos
close(VID_AVE)
close(VID_MED)
end

