%Função Complementar ao Exercicio H, criado por: Jorge Barbosa Pereira

function [IM_IL] = JorgePereira_TP2_H_Iluminacao_Inc(IM_O, Imin_fundo, Imax_fundo, Imin_seg, Imax_seg, ang)

IM_O = double(IM_O/255);
[N_L_O, N_C_O] = size(IM_O);
N_L_SEG = 270;
N_C_SEG = 270;

%Formação das Quatro Matrizes de Iluminação Basicas (Horizontais e Verticais)
vl_O_1 = 1:N_L_O;
vc_O_1 = ones(N_C_O, 1);
M_O_0 = mat2gray(vc_O_1 * vl_O_1); %Matriz de Iluminação com 0º de Inclinação
M_O_180 = 1 - M_O_0;             %Matriz de Iluminação com 180º de Inclinação
vl_O_2 = vc_O_1';
vc_O_2 = vl_O_1';
M_O_90 = mat2gray(vc_O_2 * vl_O_2);%Matriz de Iluminação com 90º de Inclinação
M_O_270 = 1 - M_O_90;            %Matriz de Iluminação com 270º de Inclinação

vl_SEG_1 = 1:N_L_SEG;
vc_SEG_1 = ones(N_C_SEG, 1);
M_SEG_0 = mat2gray(vc_SEG_1 * vl_SEG_1); %Matriz de Iluminação com 0º de Inclinação
M_SEG_180 = 1 - M_SEG_0;             %Matriz de Iluminação com 180º de Inclinação
vl_SEG_2 = vc_SEG_1';
vc_SEG_2 = vl_SEG_1';
M_SEG_90 = mat2gray(vc_SEG_2 * vl_SEG_2);%Matriz de Iluminação com 90º de Inclinação
M_SEG_270 = 1 - M_SEG_90;            %Matriz de Iluminação com 270º de Inclinação


%Formação da Matriz de Iluminação através das Funções Trignométricas
if ang >= 0 && ang < 90
    M_I_O = sqrt( (cosd(ang)*M_O_0).^2 + (sind(ang)*M_O_90).^2);
    M_I_SEG = sqrt( (cosd(ang)*M_SEG_0).^2 + (sind(ang)*M_SEG_90).^2);
elseif ang >= 90 && ang <180
    M_I_O = sqrt( (cosd(ang)*M_O_180).^2 + (sind(ang)*M_O_90).^2);
    M_I_SEG = sqrt( (cosd(ang)*M_SEG_180).^2 + (sind(ang)*M_SEG_90).^2);    
elseif ang >= 180 && ang <270    
    M_I_O = sqrt( (cosd(ang)*M_O_180).^2 + (sind(ang)*M_O_270).^2);
    M_I_SEG = sqrt( (cosd(ang)*M_SEG_180).^2 + (sind(ang)*M_SEG_270).^2); 
elseif ang >= 270 && ang <=360   
    M_I_O = sqrt( (cosd(ang)*M_O_0).^2 + (sind(ang)*M_O_270).^2);
    M_I_SEG = sqrt( (cosd(ang)*M_SEG_0).^2 + (sind(ang)*M_SEG_270).^2); 
end

%Ajuste das Intensidades da Matriz de Iluminação
M_I_O = histeq(M_I_O);
M_I_O = Imax_fundo-(Imax_fundo-Imin_fundo)*M_I_O;
M_I_SEG = histeq(M_I_SEG);
M_I_SEG = Imax_seg-(Imax_seg-Imin_seg)*M_I_SEG;

IM_FUNDO = imcomplement(IM_O);
IM_FUNDO = IM_FUNDO .* M_I_O;

IM_SEG = IM_O;
IM_SEG(120:389,120:389) = IM_O(120:389,120:389) .* M_I_SEG;

IM_IL = IM_FUNDO + IM_SEG;
IM_IL = uint8(IM_IL*255);
end