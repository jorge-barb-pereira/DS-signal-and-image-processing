%Exercicio C, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_C('Aguia.jpg');
%JorgePereira_TP3_C('Fringe.jpg');

function [] = JorgePereira_TP3_C(IM_path)

%Formação da Imagem Binária
IM_B = JorgePereira_TP3_A1(IM_path,0);

%Formação do Video de Erosão
VID_E = VideoWriter('Erosao.avi');
VID_E.FrameRate = 5;
open(VID_E)
writeVideo(VID_E, double(IM_B))

%Formação do Video de Dilatação
VID_D = VideoWriter('Dilatacao.avi');
VID_D.FrameRate = 5;
open(VID_D)
writeVideo(VID_D, double(IM_B))

%Formação do Video de Abertura
VID_A = VideoWriter('Abertura.avi');
VID_A.FrameRate = 5;
open(VID_A)
writeVideo(VID_A, double(IM_B))

%Formação do Video de Fecho
VID_F = VideoWriter('Fecho.avi');
VID_F.FrameRate = 5;
open(VID_F)
writeVideo(VID_F, double(IM_B))

%Colocação das Várias Imagens nos Vários Videos
for i = 1:50
    E = strel('disk',i,0);
    writeVideo(VID_E, double(imerode(IM_B,E)))
    writeVideo(VID_D, double(imdilate(IM_B,E)))
    writeVideo(VID_A, double(imopen(IM_B,E)))
    writeVideo(VID_F, double(imclose(IM_B,E)))
end

%Encerramento dos Videos
close(VID_E)
close(VID_D)
close(VID_A)
close(VID_F)

end

