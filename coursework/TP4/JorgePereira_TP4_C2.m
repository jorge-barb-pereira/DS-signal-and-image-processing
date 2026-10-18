%Exercicio C2, criado por: Jorge Barbosa Pereira

%Exemplos de Execução: JorgePereira_TP4_C2([1,2,3,4,5,6,5,4,3,2,1],[1,2,3,4,5,6,5,4,3,2,1],1)
%Exemplos de Execução: JorgePereira_TP4_C2([1,2,3,4,5,6,5,4,3,2,1],[2,2,2,2,2,2,2,2,2,2,2],1)
function [r0_max,l_max] = JorgePereira_TP4_C2(X,Y,graf)

NX = 0:length(X)-1;
NY = 0:length(Y)-1;

%Calculo das Auto Correlações
Rxx = xcorr(X,X);
Ryy = xcorr(Y,Y);
rxx0 = max(Rxx);
ryy0 = max(Ryy);

%Calculo das Correlações Cruzadas
R0xx = Rxx/rxx0;
NXX = (0:length(R0xx)-1) - (length(R0xx)-1)/2;
R0yy = Ryy/ryy0;
NYY = (0:length(R0yy)-1) - (length(R0yy)-1)/2;

R0xy = xcorr(X,Y)/sqrt(rxx0*ryy0);
NXY = (0:length(R0xy)-1) - (length(R0xy)-1)/2;
R0yx = xcorr(Y,X)/sqrt(ryy0*rxx0);
NYX = (0:length(R0yx)-1) - (length(R0yx)-1)/2;

[r0_max,i_max] = max(R0xy);
l_max = NXY(i_max);

%Plot das Imagens
if graf == 1
    figure(1),sgtitle(sprintf('Correlação Cruzada Máxima = %0.2f\nAtraso da Correlação Cruzada Máxima do Sinal X com o Sinal Y = %d\nAtraso da Correlação Cruzada Máxima do Sinal Y com o Sinal X = %d\n',r0_max,l_max,-l_max),'FontSize', 11) 
    subplot(3,2,1),stem(NX,X),title('Sinal X'),xlabel('n'),ylabel('x [n]')
    subplot(3,2,2),stem(NY,Y),title('Sinal Y'),xlabel('n'),ylabel('y [n]')
    subplot(3,2,3),stem(NXX,R0xx),title('Auto Correlação do Sinal X'),xlabel('l'),ylabel('r_{xx} [l]'),ylim([-1,1]);
    subplot(3,2,4),stem(NYY,R0yy),title('Auto Correlação do Sinal Y'),xlabel('l'),ylabel('r_{yy} [l]'),ylim([-1,1]);
    subplot(3,2,5),stem(NXY,R0xy),title('Correlação Cruzada do Sinal X com o Sinal Y'),xlabel('l'),ylabel('r_{xy} [l]'),ylim([-1,1]);
    subplot(3,2,6),stem(NYX,R0yx),title('Correlação Cruzada do Sinal Y com o Sinal X'),xlabel('l'),ylabel('r_{yx} [l]'),ylim([-1,1]);
end
end

