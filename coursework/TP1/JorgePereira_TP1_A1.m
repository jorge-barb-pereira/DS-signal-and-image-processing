%Exercicio A1, criado por: Jorge Barbosa Pereira

B = ones(64)*255 ;    %Matriz 64x64 preenchida com 255 (braco), ou seja B -> 1 quadrado branco
P = zeros (64);       %Matriz 64x64 preenchida com 0 (preto), ou seja P -> 1 quadrado preto
PB = [P, B; B, P];    %Matriz 128x128 constituida por 4 matrizes P & B alternadas, ou seja PB -> 4 quadrados (2 pretos e 2 brancos)
M = [PB, PB; PB, PB]; %Matriz 256x256 constituida por 4 matrizes PB, ou seja M -> 16 quadrados (8 pretos e 8 brancos)
Tab1 = [M, M; M, M];  %Matriz 512x512 constituida por 4 matrizes M, ou seja Tab1 -> 64 quadrados (32 pretos e 32 brancos) -> tabuleiro de xadrez
Tab1_8b = uint8(Tab1);%Matriz na class inteiro de 8 bits -> [0:255]

Tab2 = [M*0.9, M*0.2; M*0.9, M*0.2]; %Matriz 512x512 constituida po 4 matrizes M, sendo que nas 2 matrizes da direita, os quadrados brancos possuem intensidade de 90% e nas duas matrizes da esquerda, os quadros brancos possuem intensidade de 10%
Tab2_8b = uint8(Tab2);

vl = 1:512;            %Vetor Linha com 512 elementos que aumentam de 1 até 512
vc = ones(512,1);      %Vetor Coluna com 512 elementos unitários
M_I = mat2gray(vc*vl); %Matriz 512x512 que possui as colunas com valores iguais e as linhas crescestes de 0 até 1
M_I = 0.9-0.7*M_I;     %Matriz 512x512 que possui as colunas com valores iguais e as linhas decrescentes de 0.9 até 0.2
Tab3 = Tab1.*M_I;      %Matriz 512x512 em que cada elemento de Tab1 é multiplicado pelo elemento análogo de M_I originando um Tabuleiro de Xadrez com iluminação gradual decrescente de 0.9% até 0.2%
Tab3_8b = uint8(Tab3);

figure(1) %Plot da figura com os 3 Tabuleiros
subplot(1,3,1),imshow(Tab1_8b),title('Tabuleiro de Xadrez Simples')
subplot(1,3,2),imshow(Tab2_8b),title('Tabuleiro de Xadrez com Iluminação Abrupta')
subplot(1,3,3),imshow(Tab3_8b),title('Tabuleiro de Xadrez com Iluminação Gradual')