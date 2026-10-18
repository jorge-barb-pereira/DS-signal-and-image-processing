%Exercicio B2, criado por: Jorge Barbosa Pereira

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

%Aplicação de Filtro Média de Tamanho 3 ao Sinal com Ruído
P3 = ones(1,3)/3;
Y3 = filter(P3,1,X);

%Aplicação de Filtro Média de Tamanho 5 ao Sinal com Ruído
P5 = ones(1,5)/5;
Y5 = filter(P5,1,X);

%Plot das Imagens
figure(1)
title(sprintf('Performance de Filtros Média num Sinal com Ruído \n ER_{(Sinal com Ruído, Sinal Original)} = %0.3f   |   ER_{(Sinal com Filtro Média 3, Sinal Original)} = %0.3f   |   ER_{(Sinal com Filtro Média 5, Sinal Original)} = %0.3f ',JorgePereira_TP4_A3(S,X),JorgePereira_TP4_A3(S,Y3),JorgePereira_TP4_A3(S,Y5)))
hold on
plot(N,S,':k')
plot(N,X,'k');
plot(N,Y3,'y');
plot(N,Y5,'r');
hold off
legend('Sinal Original','Sinal com Ruído', 'Sinal com Filtro de Média 3', 'Sinal com Filtro de Média 5'),xlabel('n'),ylabel('x [n]');