%Exercicio A1, criado por: Jorge Barbosa Pereira

%Leitura dos Sinais
load cello.mat
load EEG.mat

S_cello = cello.x;
dt_cello = cello.dt;

S_EEG = data;
dt_EEG = 1/100;

%Eixo Temporal dos Sinais
T_cello = (0:(length(S_cello)-1)) * dt_cello;
T_EEG = (0:(length(S_EEG)-1)) * dt_EEG;

%Transformada de Fourier dos Sinais
F_cello = fft(S_cello);
F_EEG = fft(S_EEG);

%Eixo de Frequências dos Sinais
W_cello = (0:(length(S_cello)-1))./length(S_cello)*(1/dt_cello);
W_EEG = (0:(length(S_EEG)-1))./length(S_EEG)*(1/dt_EEG);

%Plot das Figuras
figure(1),sgtitle(sprintf('f_{aquisição} = %0.0f Hz  |  n_{aquisições} = %0.0f',1/dt_EEG,length(S_EEG)), 'FontSize', 10)
subplot(1,2,1),plot(T_EEG,S_EEG),ylabel('x_{EEG} [t]'),xlabel('t (s)'),title('Sinal EEG');
subplot(1,2,2),plot(W_EEG(1:(length(W_EEG)/2)+1),abs(F_EEG(1:(length(F_EEG)/2)+1))),ylabel('|TFD_{EEG} [f]|'),xlabel('f (Hz)'),title('Módulo da Transformada de Fourier'),xlim([0,50]),ylim([-0.02e7,2.25e7]);

figure(2),sgtitle(sprintf('f_{aquisição} = %0.0f Hz  |  n_{aquisições} = %0.0f',1/dt_cello,length(S_cello)), 'FontSize', 10)
subplot(1,2,1),plot(T_cello,S_cello),ylabel('x_{Cello} [t'),xlabel('t (s)'),title('Sinal Cello'),xlim([0 1.15]);
subplot(1,2,2),plot(W_cello(1:(length(W_cello)/2)+1),abs(F_cello(1:(length(F_cello)/2)+1))),ylabel('|TFD_{Cello} [f]|'),xlabel('f (Hz)'),title('Módulo da Transformada de Fourier'),xlim([0,4096]),ylim([-2.5,325]);

