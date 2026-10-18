%Exercicio D3, criado por: Jorge Barbosa Pereira

%O script está escrito de forma a montar um vídeo demonstrativo da
%manipulação da iluminação que pode ser feita com a imagem 'seg1.jpg'

%Tempo total de execução ~ 45 segundos

%Formação do Video
VID = VideoWriter('D3.avi');
VID.FrameRate = 60;
open(VID)

%Aplicação de Diversas Interpolações Linerares para Formação das Várias Imagens
N_Frames = 2000;
for i = 1:N_Frames
    
    %Variavel correspondente à percentagem do frame no video
    j = i/N_Frames;
    
    if j < 2/11
        Imin_fundo = JorgePereira_TP3_D_Interpolacao(j, 0/11, 2/11, 0, 1);
        Imax_fundo = Imin_fundo;
        Imax_seg = JorgePereira_TP3_D_Interpolacao(j, 0/11, 2/11, 1, 0);
        Imin_seg = Imax_seg;
        ang_fundo = 0;
        ang_seg = 0;
    elseif j >= 2/11 && j < 4/11    
        Imin_fundo = JorgePereira_TP3_D_Interpolacao(j, 2/11, 4/11, 1, 0);
        Imax_fundo = 1;
        Imin_seg = 0;        
        Imax_seg = JorgePereira_TP3_D_Interpolacao(j, 2/11, 4/11, 0, 1);
        ang_fundo = 0;
        ang_seg = 0;
    elseif j >= 4/11 && j < 6/11
        Imin_fundo = 0;
        Imax_fundo = 1;
        Imin_seg = 0;
        Imax_seg = 1;
        ang_fundo = JorgePereira_TP3_D_Interpolacao(j, 4/11, 6/11, 0, 360);
        ang_seg = JorgePereira_TP3_D_Interpolacao(j, 4/11, 6/11, 360, 0);
    elseif j >= 6/11 && j < 7/11  
        Imin_fundo = 0;
        Imax_fundo = 1;
        Imin_seg = JorgePereira_TP3_D_Interpolacao(j, 6/11, 7/11, 0, 0.25);
        Imax_seg = JorgePereira_TP3_D_Interpolacao(j, 6/11, 7/11, 1, 0.75);
        ang_fundo = 0;
        ang_seg = 0;
    elseif j >= 7/11 && j < 9/11
        Imin_fundo = 0;
        Imax_fundo = 1;
        Imin_seg = 0.25;
        Imax_seg = 0.75;
        ang_fundo = JorgePereira_TP3_D_Interpolacao(j, 7/11, 9/11, 0, 360);
        ang_seg = ang_fundo;    
     elseif j >= 9/11 
        Imin_fundo = 0;
        Imax_fundo = JorgePereira_TP3_D_Interpolacao(j, 9/11, 11/11, 1, 0);
        Imin_seg = JorgePereira_TP3_D_Interpolacao(j, 9/11, 11/11, 0.25, 1);
        Imax_seg = JorgePereira_TP3_D_Interpolacao(j, 9/11, 11/11, 0.75, 1);
        ang_fundo = 0;
        ang_seg = 0;
    end
    IM = JorgePereira_TP3_D3_Iluminacao_Inc(Imin_fundo, Imax_fundo, Imin_seg, Imax_seg, ang_fundo, ang_seg);
    writeVideo(VID, IM)
end
close(VID)

