%Exercicio A3, criado por: Jorge Barbosa Pereira (VERSÃO FINAL)

%JorgePereira_TP1_A3_v2(8000,0.10,0.90,75,1); -> Exemplo de execução para gerar uma imagem de um Tabuleiro de Xadrez 8000x8000 com Iluminação Gradual Decrescente de 0.9% até 0.1% com 75º de Inclinação

function [Tab] = JorgePereira_TP1_A3_v2(N,Imin,Imax,ang,graf)

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


%Formação da Matriz de Iluminação através das Funções Trignométricas
if ang >= 0 && ang < 90
    M_I = sqrt( (cosd(ang)*M_0).^2 + (sind(ang)*M_90).^2);
elseif ang >= 90 && ang <180
    M_I = sqrt( (cosd(ang)*M_180).^2 + (sind(ang)*M_90).^2);
elseif ang >= 180 && ang <270    
    M_I = sqrt( (cosd(ang)*M_180).^2 + (sind(ang)*M_270).^2);
elseif ang >= 270 && ang <=360   
    M_I = sqrt( (cosd(ang)*M_0).^2 + (sind(ang)*M_270).^2);
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

