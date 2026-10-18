%Exercicio D1, criado por: Jorge Barbosa Pereira

%Alguns Exemplos
%JorgePereira_TP3_D1('Aguia.jpg',200,0.1,3);
%JorgePereira_TP3_D1('Fringe.jpg',200,0.1,3);

function [] = JorgePereira_TP3_D1(IM_path,N_Frames, G_min, G_max)

if N_Frames < 10
    warning('O Input "N_Frames" deve ser superior a 10 para se visualizar o efeito pretendido e um video com duração superior a 1 segundo')
end

%Leitura da Imagem
IM_O = imread(IM_path);

%Formação do Video
VID = VideoWriter('TGama.avi');
VID.FrameRate = 10;
open(VID)

%Aplicação de Diversas Interpolações Linerares para Formação das Várias Imagens
for i = 1:N_Frames
    
    %Variavel correspondente à percentagem do frame no video
    j = i/N_Frames;
    
    if j < 1/4  
        G = JorgePereira_TP3_D_Interpolacao(j,0,1/4,1,G_min);   
    elseif j >= 1/4 && j < 3/4   
        G = JorgePereira_TP3_D_Interpolacao(j,1/4,3/4,G_min,G_max);    
    elseif j >= 3/4  
        G = JorgePereira_TP3_D_Interpolacao(j,3/4,1,G_max,1);  
    end
    writeVideo(VID, imadjust(IM_O,[],[],G))
end

%Encerramento do Video
close(VID)

end

