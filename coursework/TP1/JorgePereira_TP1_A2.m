%Exercicio A2, criado por: Jorge Barbosa Pereira

%JorgePereira_TP1_A2(800,0.10,0.90); -> Exemplo de execução para gerar uma imagem de um Tabuleiro de Xadrez 8000x8000 com Iluminação Gradual Decrescente de 0.9% até 0.1%

function [Tab] = JorgePereira_TP1_A2(N,Imin,Imax) %Função que retorna um Tabuleiro de Xadrez NxN com Iluminação Gradual Decrescente de 0.9% até 0.1%

%Verificação de alguns requesitos dos Inputs 
if mod(N,8) ~= 0
    N = N-mod(N,8);
    warning('O Input "N" deve ser divisível por 8 e foi automaticamente redefenido para N=%d',N)
elseif Imin < 0 || Imax < 0 || Imin > 1 || Imax > 1
    error('Os Inputs "Imin" e "Imax" devem estar entre 0 e 1')
elseif Imin > Imax
    error('O Input "Imin" deve ser menor ou igual ao Input "Imax"')
end

%Formação de um Tabuleiro de Xadrez Simples
B = ones(N/8)*255 ; 
P = zeros (N/8);
PB = [P, B; B, P];
M = [PB, PB; PB, PB];
Tab = [M, M; M, M];

%Formação da Matriz de Iluminação com ajuste das Intensidades
vl = 1:N;
vc = ones(N,1);
M_I = mat2gray(vc*vl);
M_I = Imax-(Imax-Imin)*M_I;

%Formação do Tabuleiro de Xadrez com Iluminação Gradual
Tab = Tab .* M_I;
Tab = uint8(Tab);

%Plot da figura com o Tabuleiro de Xadrez com Iluminação Gradual e o seu Histograma de Cinzentos
subplot(1,2,1)
imshow(Tab), title('Tabuleiro de Xadrez com Iluminação Gradual')
subplot(1,2,2)
imhist(Tab), title('Histograma de Cinzentos do Tabuleiro de Xadrez')
end