%Exercicio C2, criado por: Jorge Barbosa Pereira

%Importação do Filto
load JorgePereira_TP5_C2_Filtro

%Construção dos Sinais
L = 256;
X0 = [];
Ra = [];
N = [];

for n=0:L-1
    x0 = 0.2*n*exp(-0.03*n);
    X0 = [X0,x0];
    ra = (cos(0.81*pi*n)+cos(0.85*pi*n)+cos(0.91*pi*n)+cos(0.95*pi*n))/4;
    Ra = [Ra,ra];
    N = [N,n];
end

W = N./L*2*pi;
Xa = X0 + Ra;

F_X0 = fft(X0);
F_Xa = fft(Xa);

%Aplicação dos Filtros
Filtro_0 = [ones(1,L/4),zeros(1,L/2),ones(1,L/4)];
[num_1,dem_1] = sos2tf(SOS_1,G_1);
Xa0 = ifft(F_Xa.*Filtro_0);
Xa1 = filter(num_1,dem_1,Xa);
Xa2 = filtfilt(num_1,dem_1,Xa);
[Xa3, Filtro_3] = lowpass(Xa,0.5);
Xa4 = Xa;
[Xa4, Filtro_41] = bandstop(Xa4,[0.79 0.83]);
[Xa4, Filtro_42] = bandstop(Xa4,[0.83 0.87]);
[Xa4, Filtro_43] = bandstop(Xa4,[0.89 0.93]);
[Xa4, Filtro_44] = bandstop(Xa4,[0.93 0.97]);

%Ganho dos Filtros
Filtro_1 = freqz(num_1,dem_1,W);
Filtro_2 = freqz(num_1,dem_1,W);
Filtro_3 = freqz(Filtro_3,W);
Filtro_41 = freqz(Filtro_41,W);
Filtro_42 = freqz(Filtro_42,W);
Filtro_43 = freqz(Filtro_43,W);
Filtro_44 = freqz(Filtro_44,W);
Filtro_4 = Filtro_41 .* Filtro_42 .* Filtro_43 .* Filtro_44;

%Transformadas de Fourier
F_Xa0 = fft(Xa0);
F_Xa1 = fft(Xa1);
F_Xa2 = fft(Xa2);
F_Xa3 = fft(Xa3);
F_Xa4 = fft(Xa4);

%Erro Relativo
eXa0 = norm(Xa0-X0,2)/norm(X0,2);
eXa1 = norm(Xa1-X0,2)/norm(X0,2);
eXa2 = norm(Xa2-X0,2)/norm(X0,2);
eXa3 = norm(Xa3-X0,2)/norm(X0,2);
eXa4 = norm(Xa4-X0,2)/norm(X0,2);

%Auto Correlação
rX0 = max(xcorr(X0,X0));
rXa0 = max(xcorr(Xa0,Xa0));
rXa1 = max(xcorr(Xa1,Xa1));
rXa2 = max(xcorr(Xa2,Xa2));
rXa3 = max(xcorr(Xa3,Xa3));
rXa4 = max(xcorr(Xa4,Xa4));

%Correlação Cruzada
R0Xa0 = xcorr(X0,Xa0)/sqrt(rX0*rXa0);
R0Xa1 = xcorr(X0,Xa1)/sqrt(rX0*rXa1);
R0Xa2 = xcorr(X0,Xa2)/sqrt(rX0*rXa2);
R0Xa3 = xcorr(X0,Xa3)/sqrt(rX0*rXa3);
R0Xa4 = xcorr(X0,Xa4)/sqrt(rX0*rXa4);

%Plot das Figuras
figure(1),sgtitle(sprintf('  Erro Relativo X_a_0 = %0.3f  |  Erro Relativo X_a_1 = %0.3f \n Correlação Cruzada Máxima X_a_0 = %0.4f  |  Correlação Cruzada Máxima X_a_1 = %0.4f',eXa0,eXa1,max(R0Xa0),max(R0Xa1)))
subplot(2,2,1)
hold on
plot([W,2*pi]./pi,abs([Filtro_0,Filtro_0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([Filtro_1,Filtro_1(1)]),'Color',[0,1,0]),xlim([-0.1,2.1]),ylim([-0.01,1.01]),legend('Filtro Ideal','Filtro IIR_1'),ylabel('h[\omega]'),xlabel('\omega (\pi^{-1})'),title('Filtro IIR_1 - Construido com filterDesigner e Aplicado com filter()')
hold off
subplot(2,2,2)
hold on
plot(N,real(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,real(Xa),'Color',[0.5,0.5,0.5]),plot(N,real(Xa0),'Color',[1,0,0]),plot(N,real(Xa1),'Color',[0,1,0]),xlim([0,L-1]),ylim([-1,3]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_1 - Sinal com Filtro IIR_1'),ylabel('Re(x[n])'),xlabel('n'),title('Componente Real dos Sinais')
hold off
subplot(2,2,3)
hold on
plot([W,2*pi]./pi,abs([F_X0,F_X0(1)]),'Color',[0,0,0],'LineWidth',2.5),plot([W,2*pi]./pi,abs([F_Xa,F_Xa(1)]),'Color',[0.5,0.5,0.5]),plot([W,2*pi]./pi,abs([F_Xa0,F_Xa0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([F_Xa1,F_Xa1(1)]),'Color',[0,1,0]),xlim([-0.1,2.1]),ylim([-2,235]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_1 - Sinal com Filtro IIR_1'),ylabel('|TFD[\omega]|'),xlabel('\omega (\pi^{-1})'),title('Módulo da Transformada de Fourier')
hold off
subplot(2,2,4)
hold on
plot(N,imag(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,imag(Xa),'Color',[0.5,0.5,0.5]),plot(N,imag(Xa0),'Color',[1,0,0]),plot(N,imag(Xa1),'Color',[0,1,0]),xlim([0,L-1]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_1 - Sinal com Filtro IIR_1'),ylabel('Im(x[n])'),xlabel('n'),title('Componente Imaginária dos Sinais')
hold off

figure(2),sgtitle(sprintf('  Erro Relativo X_a_0 = %0.3f  |  Erro Relativo X_a_2 = %0.3f \n Correlação Cruzada Máxima X_a_0 = %0.4f  |  Correlação Cruzada Máxima X_a_2 = %0.4f',eXa0,eXa2,max(R0Xa0),max(R0Xa2)))
subplot(2,2,1)
hold on
plot([W,2*pi]./pi,abs([Filtro_0,Filtro_0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([Filtro_2,Filtro_2(1)]),'Color',[0,0,1]),xlim([-0.1,2.1]),ylim([-0.01,1.01]),legend('Filtro Ideal','Filtro IIR_2'),ylabel('h[\omega]'),xlabel('\omega (\pi^{-1})'),title('Filtro IIR_2 - Construido com filterDesigner e Aplicado com filtfilt()')
hold off
subplot(2,2,2)
hold on
plot(N,real(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,real(Xa),'Color',[0.5,0.5,0.5]),plot(N,real(Xa0),'Color',[1,0,0]),plot(N,real(Xa2),'Color',[0,0,1]),xlim([0,L-1]),ylim([-1,3]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_2 - Sinal com Filtro IIR_2'),ylabel('Re(x[n])'),xlabel('n'),title('Componente Real dos Sinais')
hold off
subplot(2,2,3)
hold on
plot([W,2*pi]./pi,abs([F_X0,F_X0(1)]),'Color',[0,0,0],'LineWidth',2.5),plot([W,2*pi]./pi,abs([F_Xa,F_Xa(1)]),'Color',[0.5,0.5,0.5]),plot([W,2*pi]./pi,abs([F_Xa0,F_Xa0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([F_Xa2,F_Xa2(1)]),'Color',[0,0,1]),xlim([-0.1,2.1]),ylim([-2,235]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_2 - Sinal com Filtro IIR_2'),ylabel('|TFD[\omega]|'),xlabel('\omega (\pi^{-1})'),title('Módulo da Transformada de Fourier')
hold off
subplot(2,2,4)
hold on
plot(N,imag(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,imag(Xa),'Color',[0.5,0.5,0.5]),plot(N,imag(Xa0),'Color',[1,0,0]),plot(N,imag(Xa2),'Color',[0,0,1]),xlim([0,L-1]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_2 - Sinal com Filtro IIR_2'),ylabel('Im(x[n])'),xlabel('n'),title('Componente Imaginária dos Sinais')
hold off

figure(3),sgtitle(sprintf('  Erro Relativo X_a_0 = %0.3f   |   Erro Relativo X_a_3 = %0.3f \n Correlação Cruzada Máxima X_a_0 = %0.4f   |   Correlação Cruzada Máxima X_a_3 = %0.4f',eXa0,eXa3,max(R0Xa0),max(R0Xa3)))
subplot(2,2,1)
hold on
plot([W,2*pi]./pi,abs([Filtro_0,Filtro_0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([Filtro_3,Filtro_3(1)]),'Color',[0,1,1]),xlim([-0.1,2.1]),ylim([-0.01,1.01]),legend('Filtro Ideal','Filtro IIR_3'),ylabel('h[\omega]'),xlabel('\omega (\pi^{-1})'),title('Filtro IIR_3 - Construido e Aplicado com lowpass()')
hold off
subplot(2,2,2)
hold on
plot(N,real(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,real(Xa),'Color',[0.5,0.5,0.5]),plot(N,real(Xa0),'Color',[1,0,0]),plot(N,real(Xa3),'Color',[0,1,1]),xlim([0,L-1]),ylim([-1,3]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_3 - Sinal com Filtro IIR_3'),ylabel('Re(x[n])'),xlabel('n'),title('Componente Real dos Sinais')
hold off
subplot(2,2,3)
hold on
plot([W,2*pi]./pi,abs([F_X0,F_X0(1)]),'Color',[0,0,0],'LineWidth',2.5),plot([W,2*pi]./pi,abs([F_Xa,F_Xa(1)]),'Color',[0.5,0.5,0.5]),plot([W,2*pi]./pi,abs([F_Xa0,F_Xa0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([F_Xa3,F_Xa3(1)]),'Color',[0,1,1]),xlim([-0.1,2.1]),ylim([-2,235]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_3 - Sinal com Filtro IIR_3'),ylabel('|TFD[\omega]|'),xlabel('\omega (\pi^{-1})'),title('Módulo da Transformada de Fourier')
hold off
subplot(2,2,4)
hold on
plot(N,imag(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,imag(Xa),'Color',[0.5,0.5,0.5]),plot(N,imag(Xa0),'Color',[1,0,0]),plot(N,imag(Xa3),'Color',[0,1,1]),xlim([0,L-1]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_3 - Sinal com Filtro IIR_3'),ylabel('Im(x[n])'),xlabel('n'),title('Componente Imaginária dos Sinais')
hold off

figure(4),sgtitle(sprintf('  Erro Relativo X_a_0 = %0.3f   |   Erro Relativo X_a_4 = %0.3f \n Correlação Cruzada Máxima X_a_0 = %0.4f   |   Correlação Cruzada Máxima X_a_4 = %0.4f',eXa0,eXa4,max(R0Xa0),max(R0Xa4)))
subplot(2,2,1)
hold on
plot([W,2*pi]./pi,abs([Filtro_0,Filtro_0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([Filtro_4,Filtro_4(1)]),'Color',[0.9290 0.6940 0.1250]),xlim([-0.1,2.1]),ylim([-0.01,1.01]),legend('Filtro Ideal','Filtro IIR_4'),ylabel('h[\omega]'),xlabel('\omega (\pi^{-1})'),title('Filtro IIR_4 - Construido e Aplicado com stopband()')
hold off
subplot(2,2,2)
hold on
plot(N,real(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,real(Xa),'Color',[0.5,0.5,0.5]),plot(N,real(Xa0),'Color',[1,0,0]),plot(N,real(Xa4),'Color',[0.9290 0.6940 0.1250]),xlim([0,L-1]),ylim([-1,3]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_4 - Sinal com Filtro IIR_4'),ylabel('Re(x[n])'),xlabel('n'),title('Componente Real dos Sinais')
hold off
subplot(2,2,3)
hold on
plot([W,2*pi]./pi,abs([F_X0,F_X0(1)]),'Color',[0,0,0],'LineWidth',2.5),plot([W,2*pi]./pi,abs([F_Xa,F_Xa(1)]),'Color',[0.5,0.5,0.5]),plot([W,2*pi]./pi,abs([F_Xa0,F_Xa0(1)]),'Color',[1,0,0]),plot([W,2*pi]./pi,abs([F_Xa4,F_Xa4(1)]),'Color',[0.9290 0.6940 0.1250]),xlim([-0.1,2.1]),ylim([-2,235]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_4 - Sinal com Filtro IIR_4'),ylabel('|TFD[\omega]|'),xlabel('\omega (\pi^{-1})'),title('Módulo da Transformada de Fourier')
hold off
subplot(2,2,4)
hold on
plot(N,imag(X0),'Color',[0,0,0],'LineWidth',2.5),plot(N,imag(Xa),'Color',[0.5,0.5,0.5]),plot(N,imag(Xa0),'Color',[1,0,0]),plot(N,imag(Xa4),'Color',[0.9290 0.6940 0.1250]),xlim([0,L-1]),legend('X_0 - Sinal de Referência ','X_a - Sinal com Ruído','X_a_0 - Sinal com Filtro Ideal','X_a_4 - Sinal com Filtro IIR_4'),ylabel('Im(x[n])'),xlabel('n'),title('Componente Imaginária dos Sinais')
hold off


