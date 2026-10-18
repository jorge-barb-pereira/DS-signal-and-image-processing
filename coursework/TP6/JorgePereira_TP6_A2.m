%Exercicio A2, criado por: Jorge Barbosa Pereira

%Leitura do Sinal
load EEG.mat

S_EEG = data;
freq_EEG = 100;
dt_EEG = 1/freq_EEG;

%Eixo do Tempo do Sinal
T_EEG = (0:(length(S_EEG)-1)) * dt_EEG;

%Eixo das Frequencias
W = (0:length(S_EEG))./length(S_EEG)*pi;

%Formação do Filtro
[num,dem] = butter(8,[5 15]/(freq_EEG/2));
Filtro = freqz(num,dem,W);
h_Filtro = abs(Filtro);
g_Filtro = 20*log10(h_Filtro);

%Formacao do Sinal Filtrado
S_EEG_f = filter(num,dem,S_EEG);

%Plot das Figuras
figure(1)
subplot(3,2,[1 2]),plot(T_EEG,S_EEG),ylabel('x_{EEG} [t]'),xlabel('t (s)'),title('Sinal EEG Original'),ylim([-5e5 5e5]);
subplot(3,2,[3 4]),plot(T_EEG,S_EEG_f),ylabel('x_{EEG} [t]'),xlabel('t (s)'),title('Sinal EEG Filtrado'),ylim([-5e5 5e5]);
subplot(3,2,5),plot(W./(2*pi)*freq_EEG,h_Filtro),ylabel('h_{Filtro} [f]'),xlabel('f (Hz)'),title('Resposta Espetral do Filtro'),xlim([0 50]);
subplot(3,2,6),plot(W./(2*pi)*freq_EEG,g_Filtro),ylabel('g_{Filtro} [f] (dB)'),xlabel('f (Hz)'),title('Resposta Espetral do Filtro em dB'),xlim([0 50]),ylim([-200 0]);