%Exercicio B3, criado por: Jorge Barbosa Pereira

%Construção dos Sinais
S = [];
R = [];
N = [];

for n=0:80
    s = 2*n*(0.9^n);
    S = [S,s];
    r = rand(1) - 0.5;
    R = [R,r];
    N = [N,n];
end
X = S + R;

%Aplicação de Filtro Média de Tamanho 3 ao Sinal com Ruído e correção do atraso
P3 = ones(1,3)/3;
k3 = (3-1)/2;
Y3_pad = filter(P3,1,[X, zeros(1,k3)]);
Y3 = Y3_pad(k3+1:length(X)+k3);

%Aplicação de Filtro Média de Tamanho 5 ao Sinal com Ruído e correção do atraso
P3 = ones(1,3)/3;
P5 = ones(1,5)/5;
k5 = (5-1)/2;
Y5_pad = filter(P5,1,[X, zeros(1,k5)]);
Y5 = Y5_pad(k5+1:length(X)+k5);

%Plot das Imagens
figure(1)
title(sprintf('Performance de Filtros Média num Sinal com Ruído \n ER_{(Sinal com Ruído, Sinal Puro)} = %0.3f   |   ER_{(Sinal com Filtro Média 3, Sinal Puro)} = %0.3f   |   ER_{(Sinal com Filtro Média 5, Sinal Puro)} = %0.3f ',JorgePereira_TP4_A3(S,X),JorgePereira_TP4_A3(S,Y3),JorgePereira_TP4_A3(S,Y5)))
hold on
plot(N,S,':k');
plot(N,X,'k');
plot(N,Y3,'y');
plot(N,Y5,'r');
hold off
legend('Sinal Puro','Sinal com Ruído', 'Sinal com Filtro de Média 3', 'Sinal com Filtro de Média 5'),xlabel('n'),ylabel('x [n]');