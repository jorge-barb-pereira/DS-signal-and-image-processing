%Exercicio A2, criado por: Jorge Barbosa Pereira

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
X1_F = [X1, zeros(1,L-1)];
X2_F = [X2, zeros(1,L-1)];
X3_F = [X3, zeros(1,L-1)];
F1 = fft(X1_F);
F2 = fft(X2_F);
F3 = fft(X3_F);

%Produto das Transformadas
F12 = F1.*F2;
F13 = F1.*F3;
F23 = F2.*F3;

%Convulsão dos Sinais pela Transformada de Fourier Inversa
C_F12 = ifft(F12);
C_F13 = ifft(F13);
C_F23 = ifft(F23);

%Convulsão dos Sinais
C12 = conv(X1,X2);
C13 = conv(X1,X3);
C23 = conv(X2,X3);

%Vetor dos Desvios da Convulsão
NC =(0:2*(L-1)) - (L-1);

%Plot das Figuras
figure(1)
subplot(3,3,1),plot(N,X1),title('Sinal 1'),xlabel('n'),ylabel('x_1 [n]')
subplot(3,3,2),plot(N,X2),title('Sinal 2'),xlabel('n'),ylabel('x_2 [n]')
subplot(3,3,3),plot(N,X3),title('Sinal 3'),xlabel('n'),ylabel('x_3 [n]')
subplot(3,3,4),plot(NC,C12),title('Convolução Temporal do Sinal 1 com o Sinal 2'),xlabel('l'),ylabel('C_1 [l]')
subplot(3,3,5),plot(NC,C13),title('Convolução Temporal do Sinal 1 com o Sinal 3'),xlabel('l'),ylabel('C_2 [l]')
subplot(3,3,6),plot(NC,C23),title('Convolução Temporal do Sinal 2 com o Sinal 3'),xlabel('l'),ylabel('C_3 [l]')
subplot(3,3,7),plot(NC,C_F12),title('Convolução Frequêncial do Sinal 1 com o Sinal 2'),xlabel('l'),ylabel('C_1 [l]')
subplot(3,3,8),plot(NC,C_F13),title('Convolução Frequêncial do Sinal 1 com o Sinal 3'),xlabel('l'),ylabel('C_2 [l]')
subplot(3,3,9),plot(NC,C_F23),title('Convolução Frequêncial do Sinal 2 com o Sinal 3'),xlabel('l'),ylabel('C_3 [l]')