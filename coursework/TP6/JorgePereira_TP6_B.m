%Exercicio B, criado por: Jorge Barbosa Pereira

%Leitura do Audio
[Sinal,Freq] = audioread('Canto1.mp3');
sound(Sinal, Freq)

%Sinal Completo e respetivo Eixo do Tempo
Sinal = Sinal(:,1);
T_Sinal = (0:(length(Sinal)-1)) * (1/Freq);

%Sinal com Ruido Ambiente e respetivo Eixo do Tempo
Ambiente = Sinal(300000:500001);
T_Ambiente = T_Sinal(300000:500001);

%Sinal com Ruido Ambiente e respetivo Eixo do Tempo
Canto = Sinal(500001:700000);
T_Canto = T_Sinal(500001:700000);

%Transformada de Fourier dos Sinais
F_Sinal = fft(Sinal);
F_Ambiente = fft(Ambiente);
F_Canto = fft(Canto);

%Eixo de Frequência dos Sinais
W_Sinal = (0:(length(Sinal)-1))./length(Sinal)*Freq/1000;
W_Ambiente = (0:(length(Ambiente)-1))./length(Ambiente)*Freq/1000;
W_Canto = (0:(length(Canto)-1))./length(Canto)*Freq/1000;

%Parametros do Espectrograma
[S,F,T,P] = spectrogram(Sinal,128,96,128,Freq);

%Plot das Figuras
figure(1)
subplot(2,2,[1,2]),ylabel('x_{Original} [t]'),xlabel('t (s)'),plot(T_Sinal,Sinal),title('Sinal Original'),xlim([0,26.8])
subplot(2,2,3),ylabel('x_{Ambiente} [t]'),xlabel('t (s)'),plot(T_Ambiente,Ambiente),title('Sinal com Ruído Ambiente'),xlim([6.8,11.4])
subplot(2,2,4),ylabel('x_{Canto} [t]'),xlabel('t (s)'),plot(T_Canto,Canto),title('Sinal com Canto'),xlim([11.3,15.9])

figure(2)
subplot(2,3,1),ylabel('x_{Original} [t]'),xlabel('t (s)'),plot(T_Sinal,Sinal),title('Sinal Original', 'FontSize', 10),xlim([0,26.8])
subplot(2,3,2),ylabel('x_{Ambiente} [t]'),xlabel('t (s)'),plot(T_Ambiente,Ambiente),title('Sinal com Ruído Ambiente', 'FontSize', 10),xlim([6.8,11.4])
subplot(2,3,3),ylabel('x_{Canto} [t]'),xlabel('t (s)'),plot(T_Canto,Canto),title('Sinal com Canto', 'FontSize', 10),xlim([11.3,15.9])
subplot(2,3,4),plot(W_Sinal(1:(length(W_Sinal)/2)+1),abs(F_Sinal(1:(length(F_Sinal)/2)+1))),ylabel('|TFD_{Original} [f]|'),xlabel('f (KHz)'),title('Módulo da Transformada de Fourier do Sinal Original', 'FontSize', 10),xlim([0,22050/1000]);
subplot(2,3,5),plot(W_Ambiente(1:(length(W_Ambiente)/2)+1),abs(F_Ambiente(1:(length(F_Ambiente)/2)+1))),ylabel('|TFD_{Ambiente} [f]|'),xlabel('f (KHz)'),title('Módulo da Transformada de Fourier do Sinal com Ruído Ambiente', 'FontSize', 10),xlim([0,22050/1000]);
subplot(2,3,6),plot(W_Canto(1:(length(W_Canto)/2)+1),abs(F_Canto(1:(length(F_Canto)/2)+1))),ylabel('|TFD_{Canto} [f]|'),xlabel('f (KHz)'),title('Módulo da Transformada de Fourier do Sinal com Canto', 'FontSize', 10),xlim([0,22050/1000]);

figure(3)
surf(T,F,10*log(P),'edgecolor','none')
axis tight, view(0,90), xlabel('t (s)'), ylabel('f (Hz)'), title('Espectrograma do Sinal Original')