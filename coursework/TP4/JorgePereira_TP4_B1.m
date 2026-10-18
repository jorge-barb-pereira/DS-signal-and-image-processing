%Exercicio B1, criado por: Jorge Barbosa Pereira

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

%Plot das Imagens
figure(1)
title(sprintf('Componentes de Sinal com Ruído  |  ER_{(Sinal com Ruído, Sinal Original)} = %0.3f',JorgePereira_TP4_A3(S,X)))
hold on
plot(N,S,'--bo')
plot(N,R,'--ro')
plot(N,X,'--ko')
legend('Sinal Original', 'Ruído', 'Sinal com Ruído'),xlabel('n'),ylabel('x [n]');
hold off