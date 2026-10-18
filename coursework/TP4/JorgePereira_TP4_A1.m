%Exercicio A1, criado por: Jorge Barbosa Pereira

%Construção do Sinal
N = [];
X = [];
A = 1.8;
C = -0.1+0.2*pi*1i;

for n=0:40
    x = A * exp(C*n);
    X = [X,x];
    N = [N,n];
end

%Obtenção da Componente Real, Componente Imaginária, Modulo, Fase e Energia do Sinal
R = real(X);
I = imag(X);
M = abs(X);
F = angle(X);
E = sum(M.^2);

%Plot das imagens
figure(1),sgtitle(sprintf('Energia do Sinal = %0.2f',E),'FontSize', 11) 
subplot(2,2,1),stem(N,R),title('Componente Real do Sinal'),xlabel('n'),ylabel('Re(x [n])')
subplot(2,2,2),stem(N,I),title('Componente Imaginária do Sinal'),xlabel('n'),ylabel('Im(x [n])')
subplot(2,2,3),stem(N,M),title('Módulo do Sinal'),xlabel('n'),ylabel('|x [n]|')
subplot(2,2,4),stem(N,F),title('Fase do Sinal'),xlabel('n'),ylabel(sprintf('θ(x [n])'))