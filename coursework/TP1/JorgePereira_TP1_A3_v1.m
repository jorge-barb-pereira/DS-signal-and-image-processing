%Exercicio A3, criado por: Jorge Barbosa Pereira (VERSÃO INICIAL)

%JorgePereira_TP1_A3_v1(8000,0.10,0.90,75,1); -> Exemplo de execução para gerar uma imagem de um Tabuleiro de Xadrez 8000x8000 com Iluminação Gradual Decrescente de 0.9% até 0.1% com 75º de Inclinação

function [Tab] = JorgePereira_TP1_A3_v1(N,Imin,Imax,ang,graf)

%Verificação de alguns requesitos dos Inputs 
if mod(N,8) ~= 0
    N = N-mod(N,8);
    warning('O Input "N" deve ser divisível por 8 e foi automaticamente redefenido para N=%d',N)
elseif Imin < 0 || Imax < 0 || Imin > 1 || Imax > 1
    error('Os Inputs "Imin" e "Imax" devem estar entre 0 e 1')
elseif Imin > Imax
    error('O Input "Imin" deve ser menor ou igual ao Input "Imax"')
elseif ang < 0 || ang > 360
    ang = mod(ang, 360);
    warning('O Input "ang" deve estar compreendido entre 0º e 360º e foi automáticamente redefenido para ang=%0.2fº',ang)
elseif ~ismember(graf, [0 ,1])
    error('Input "graf" deve ser 0 ou 1')
end

%Formação de um Tabuleiro de Xadrez Simples
B = ones(N/8) * 255 ;
P = zeros (N/8);
PB = [P, B; B, P];
M = [PB, PB; PB, PB];
Tab = [M, M; M, M];

%Formação das Quatro Matrizes de Iluminação Basicas (Horizontais e Verticais)
vl_1 = 1:N;
vc_1 = ones(N, 1);
M_0 = mat2gray(vc_1 * vl_1); %Matriz de Iluminação com 0º de Inclinação
M_180 = 1 - M_0;             %Matriz de Iluminação com 180º de Inclinação
vl_2 = vc_1';
vc_2 = vl_1';
M_90 = mat2gray(vc_2 * vl_2);%Matriz de Iluminação com 90º de Inclinação
M_270 = 1 - M_90;            %Matriz de Iluminação com 270º de Inclinação

%Lista de Matrizes de Iluminação Básicas
inicial_M = [M_0, M_90, M_180, M_270, M_0];
%Lista dos Angulos de Inclinação Básicos
inicial_ang = [0, 90, 180, 270, 360];

%Verifica se o Angulo de Input pertence à Lista de Angulos de Inclinação Básicos
if ismember(ang, inicial_ang)
    
    ang_diference = abs(inicial_ang - ang);
    [~, i] = min(ang_diference);
    M_I = inicial_M(1:N, 1+N*(i-1):N*i);

else
%Determinação dos Indices correspondestes aos Angulos de Inclinação mais proximos do Angulo de Input
    ang_diference = abs(inicial_ang - ang);
    [~, i_1] = min(ang_diference);
    M_1 = inicial_M(1:N, 1+N*(i_1-1):N*i_1);

    ang_diference(i_1) = 360;
    [~, i_2] = min(ang_diference);
    M_2 = inicial_M(1:N, 1+N*(i_2-1):N*i_2);
    
    ang_1 = inicial_ang(i_1);
    ang_2 = inicial_ang(i_2);
    ang_med = (ang_1 + ang_2)/2;
    M_I = (M_1 + M_2)/2;

%Calculo da Média de Matrizes de Iluminação mais proximas do Angulo de Input de modo a se formar a Matriz de Iluminação pretendida
    while round(ang_med,3) ~= ang
        ang_list = [ang_1, ang_2, ang_med];
        M_list = [M_1, M_2, M_I];
        
        ang_diference = abs(ang_list - ang);
        [~, i_1] = min(ang_diference);
        M_1 = M_list(1:N,1+N*(i_1-1):N*i_1);

        ang_diference(i_1) = 360;
        [~, i_2] = min(ang_diference);
        M_2 = M_list(1:N,1+N*(i_2-1):N*i_2);
        
        ang_1 = ang_list(i_1);
        ang_2 = ang_list(i_2);
        ang_med = (ang_1 + ang_2)/2;
        M_I = (M_1 + M_2)/2; 
    end
end

%Ajuste das Intensidades da Matriz de Iluminação
M_I = histeq(M_I);
M_I = Imax-(Imax-Imin)*M_I;

%Formação do Tabuleiro de Xadrez com Iluminação Gradual
Tab = Tab .* M_I;
Tab = uint8(Tab);

%Plot da figura com o Tabuleiro de Xadrez com Iluminação Gradual e o seu Histograma de Cinzentos
if graf == 1
    subplot(1,2,1)
    imshow(Tab), title(sprintf('Tabuleiro de Xadrez com Iluminação Gradual com Inclinação de %0.2fº',ang))
    subplot(1,2,2)
    imhist(Tab), title('Histograma de Cinzentos do Tabuleiro de Xadrez')
end
end