%Função Complementar ao Exercicio H, criado por: Jorge Barbosa Pereira

function [IM_IL] = JorgePereira_TP2_H_Iluminacao(IM_O, Imin_fundo, Imax_fundo, Imin_seg, Imax_seg)

if Imin_fundo < 0 || Imax_fundo < 0 || Imin_fundo > 1 || Imax_fundo > 1
    error('Os Inputs "Imin_fundo" e "Imax_fundo" devem estar entre 0 e 1')
elseif Imin_fundo > Imax_fundo
    error('O Input "Imin_fundo" deve ser menor ou igual ao Input "Imax_fundo"')
elseif Imin_seg < 0 || Imax_seg < 0 || Imin_seg > 1 || Imax_seg > 1
    error('Os Inputs "Imin_seg" e "Imax_seg" devem estar entre 0 e 1')
elseif Imin_seg > Imax_seg
    error('O Input "Imin_seg" deve ser menor ou igual ao Input "Imax_seg"')
end

IM_O = double(IM_O/255);
[N_L_O, N_C_O] = size(IM_O);

%Defenição da Região do Segmento (Adaptada para a imagem seg1.jpg)
N_L_SEG = 270;
N_C_SEG = 270;

%Formação da Matriz de Iluminação Do Fundo
vl_O = 1:N_L_O;
vc_O = ones(N_C_O, 1);
M_I_O = mat2gray(vc_O * vl_O);

%Formação da Matriz de Iluminação Da Segmentação
vl_SEG = 1:N_L_SEG;
vc_SEG = ones(N_C_SEG, 1);
M_I_SEG = mat2gray(vc_SEG * vl_SEG);

%Adaptação das Iluminações às intensidades pretendidas
M_I_O = Imin_fundo-(Imin_fundo-Imax_fundo)*M_I_O;
M_I_SEG = Imin_seg-(Imin_seg-Imax_seg)*M_I_SEG;

%Aplicação da Matriz de Iluminação ao Fundo
IM_FUNDO = imcomplement(IM_O);
IM_FUNDO = IM_FUNDO .* M_I_O;

%Aplicação da Matriz de Iluminação ao Segmento
IM_SEG = IM_O;
IM_SEG(120:389,120:389) = IM_O(120:389,120:389) .* M_I_SEG;

%Formação da Imagem com duas iluminações (Fundo + Segmento)
IM_IL = IM_FUNDO + IM_SEG;
IM_IL = uint8(IM_IL*255);
end