%Exercicio A2, criado por: Jorge Barbosa Pereira

%Exemplo de Execução: JorgePereira_TP4_A2([1,2,3,4,5,6,5,4,3,2,1])
function [E,L1,L2,L3,LI] = JorgePereira_TP4_A2(X)

%Obtenção da Componente Real e da Componente Imaginária do Sinal
N = 0:length(X)-1;
R = real(X);
I = imag(X);

%Obtenção das Normal e Energia do Sinal
L1 = norm(X,1);
L2 = norm(X,2);
L3 = norm(X,3);
LI = norm(X,Inf);
E = L2^2;

%Plot das imagens
figure(1)
hold on
stem(N,R,'blue');
stem(N,I,'red');
title(sprintf('Sinal dividido em Componentes \n E = %0.2f  |  L_{1} = %0.2f  |  L_{2} = %0.2f  |  L_{3} = %0.2f  |  L_{inf} = %0.2f',E,L1,L2,L3,LI)),xlabel('n'),ylabel('x [n]');
legend('Componente Real','Componente Imaginária')
hold off
end

