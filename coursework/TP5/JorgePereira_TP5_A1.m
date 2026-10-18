%Exercicio A1, criado por: Jorge Barbosa Pereira

%Construção dos Sinais
X1 = [];
X2 = [];
X3 = [];
N = [];
L = 500;

for n=0:(L-1)
    
    x1 = 2*n*(0.95)^n;
    X1 = [X1,x1];
    x2 = cos(15*pi*n/L);
    X2 = [X2,x2];
    x3 = cos(35*pi*n/L);
    X3 = [X3,x3];
    
    N = [N,n];
end

%Transformada de Fourier dos Sinais
F1 = fft(X1);
F2 = fft(X2);
F3 = fft(X3);

%Modulo
mod_F1 = abs(F1);
mod_F2 = abs(F2);
mod_F3 = abs(F3);

%Fase
ang_F1 = angle(F1);
ang_F2 = angle(F2);
ang_F3 = angle(F3);

%Vetor de Frequencias
W = N./L*2;

%Plot das Figuras
figure(1)
subplot(3,3,1),plot(N,X1),title('Sinal 1'),xlabel('n'),ylabel('x_1 [n]')
subplot(3,3,4),plot(N,X2),title('Sinal 2'),xlabel('n'),ylabel('x_2 [n]')
subplot(3,3,7),plot(N,X3),title('Sinal 3'),xlabel('n'),ylabel('x_3 [n]')
subplot(3,3,2),plot(W,mod_F1),title('Módulo da Transformada de Fourier do Sinal 1'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_1 [\omega]|')
subplot(3,3,5),plot(W,mod_F2),title('Módulo da Transformada de Fourier do Sinal 2'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_2 [\omega]|')
subplot(3,3,8),plot(W,mod_F3),title('Módulo da Transformada de Fourier do Sinal 3'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_3 [\omega]|')
subplot(3,3,3),plot(W,ang_F1),title('Fase da Transformada de Fourier do Sinal 1'),xlabel('\omega (\pi^{-1})'),ylabel('θ(TFD_1 [\omega])')
subplot(3,3,6),plot(W,ang_F2),title('Fase da Transformada de Fourier do Sinal 2'),xlabel('\omega (\pi^{-1})'),ylabel('θ(TFD_2 [\omega])')
subplot(3,3,9),plot(W,ang_F3),title('Fase da Transformada de Fourier do Sinal 3'),xlabel('\omega (\pi^{-1})'),ylabel('θ(TFD_3 [\omega])')
    