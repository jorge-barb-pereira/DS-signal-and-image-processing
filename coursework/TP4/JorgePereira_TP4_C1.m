%Exercicio C1, criado por: Jorge Barbosa Pereira

%Construção dos Sinais
X = [1,2,3,4,1,2,3,4,1,2,3,4];
NX = 0:length(X)-1;
Y = [2,1,1,3,-2,-1,1,2];
NY = 0:length(Y)-1;

%Calculo das Auto Correlações
Rxx = xcorr(X,X);
Ryy = xcorr(Y,Y);
rxx0 = max(Rxx);
ryy0 = max(Ryy);

R0xx = Rxx/rxx0;
NXX = (0:length(R0xx)-1) - (length(R0xx)-1)/2;
R0yy = Ryy/ryy0;
NYY = (0:length(R0yy)-1) - (length(R0yy)-1)/2;

%Calculo das Correlações Cruzadas
R0xy = xcorr(X,Y)/sqrt(rxx0*ryy0);
NXY = (0:length(R0xy)-1) - (length(R0xy)-1)/2;
R0yx = xcorr(Y,X)/sqrt(ryy0*rxx0);
NYX = (0:length(R0yx)-1) - (length(R0yx)-1)/2;

%Plot das Imagens
figure(1)
subplot(3,2,1),stem(NX,X),title('Sinal X'),xlabel('n'),ylabel('x [n]')
subplot(3,2,2),stem(NY,Y),title('Sinal Y'),xlabel('n'),ylabel('y [n]')
subplot(3,2,3),stem(NXX,R0xx),title('Auto Correlação do Sinal X'),xlabel('l'),ylabel('r_{xx} [l]'),ylim([-1,1]);
subplot(3,2,4),stem(NYY,R0yy),title('Auto Correlação do Sinal Y'),xlabel('l'),ylabel('r_{yy} [l]'),ylim([-1,1]);
subplot(3,2,5),stem(NXY,R0xy),title('Correlação Cruzada do Sinal X com o Sinal Y'),xlabel('l'),ylabel('r_{xy} [l]'),ylim([-1,1]);
subplot(3,2,6),stem(NYX,R0yx),title('Correlação Cruzada do Sinal Y com o Sinal X'),xlabel('l'),ylabel('r_{yx} [l]'),ylim([-1,1]);