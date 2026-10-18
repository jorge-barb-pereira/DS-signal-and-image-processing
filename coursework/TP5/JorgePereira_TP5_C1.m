%Exercicio C1, criado por: Jorge Barbosa Pereira

%Importação dos Filtos
load JorgePereira_TP5_C1_Filtros.mat

L = 1000;
W = (0:L)/L*pi;

%Converção de Secção de Segunda Ordem para Função de Transferencia
[num_Alto,dem_Alto] = sos2tf(SOS_Alto,G_Alto);
[num_Baixo,dem_Baixo] = sos2tf(SOS_Baixo,G_Baixo);
[num_Passa_Banda,dem_Passa_Banda] = sos2tf(SOS_Passa_Banda,G_Passa_Banda);
[num_Rejeita_Banda,dem_Rejeita_Banda] = sos2tf(SOS_Rejeita_Banda,G_Rejeita_Banda);

%Converção da Função de Transferencia para Zero-Polos
[z_Alto,p_Alto,k_Alto] = tf2zp(num_Alto,dem_Alto);
[z_Baixo,p_Baixo,k_Baixo] = tf2zp(num_Baixo,dem_Baixo);
[z_Passa_Banda,p_Passa_Banda,k_Passa_Banda] = tf2zp(num_Passa_Banda,dem_Passa_Banda);
[z_Rejeita_Banda,p_Rejeita_Banda,k_Rejeita_Banda] = tf2zp(num_Rejeita_Banda,dem_Rejeita_Banda);

%Ganho
h_Alto = freqz(num_Alto,dem_Alto,W);
h_Baixo = freqz(num_Baixo,dem_Baixo,W);
h_Passa_Banda = freqz(num_Passa_Banda,dem_Passa_Banda,W);
h_Rejeita_Banda = freqz(num_Rejeita_Banda,dem_Rejeita_Banda,W);

g_Alto = 20*log10(abs(h_Alto));
g_Baixo = 20*log10(abs(h_Baixo));
g_Passa_Banda = 20*log10(abs(h_Passa_Banda));
g_Rejeita_Banda = 20*log10(abs(h_Rejeita_Banda));

%Fase
ang_Alto = angle(h_Alto);
ang_Baixo = angle(h_Baixo);
ang_Passa_Banda = angle(h_Passa_Banda);
ang_Rejeita_Banda = angle(h_Rejeita_Banda);

%Plot das Figuras
figure(1),sgtitle('High Pass Filter')
subplot(2,2,1),plot(W,g_Alto),title('Gain'),ylim([-200,1]),xlim([0,3.15]),ylabel('Magnitude (dB)'),xlabel('\omega');
subplot(2,2,2),plot(W,ang_Alto),title('Phase'),ylim([-3.15,3.15]),xlim([0,3.15]),ylabel('θ (rad)'),xlabel('\omega');
subplot(2,2,3),impz(num_Alto,dem_Alto,100);
subplot(2,2,4),zplane(z_Alto,p_Alto,k_Alto),title('Z Plane');

figure(2),sgtitle('Low Pass Filter')
subplot(2,2,1),plot(W,g_Baixo),title('Gain'),ylim([-200,1]),xlim([0,3.15]),ylabel('Magnitude (dB)'),xlabel('\omega');
subplot(2,2,2),plot(W,ang_Baixo),title('Phase'),ylim([-3.15,3.15]),xlim([0,3.15]),ylabel('θ (rad)'),xlabel('\omega');
subplot(2,2,3),impz(num_Baixo,dem_Baixo,100);
subplot(2,2,4),zplane(z_Baixo,p_Baixo,k_Baixo),title('Z Plane');

figure(3),sgtitle('Band Pass Filter')
subplot(2,2,1),plot(W,g_Passa_Banda),title('Gain'),ylim([-200,1]),xlim([0,3.15]),ylabel('Magnitude (dB)'),xlabel('\omega');
subplot(2,2,2),plot(W,ang_Passa_Banda),title('Phase'),ylim([-3.15,3.15]),xlim([0,3.15]),ylabel('θ (rad)'),xlabel('\omega');
subplot(2,2,3),impz(num_Passa_Banda,dem_Passa_Banda,100);
subplot(2,2,4),zplane(z_Passa_Banda,p_Passa_Banda,k_Passa_Banda),title('Z Plane');

figure(4),sgtitle('Band Stop Filter')
subplot(2,2,1),plot(W,g_Rejeita_Banda),title('Gain'),ylim([-200,1]),xlim([0,3.15]),ylabel('Magnitude (dB)'),xlabel('\omega');
subplot(2,2,2),plot(W,ang_Rejeita_Banda),title('Phase'),ylim([-3.15,3.15]),xlim([0,3.15]),ylabel('θ (rad)'),xlabel('\omega');
subplot(2,2,3),impz(num_Rejeita_Banda,dem_Rejeita_Banda,100);
subplot(2,2,4),zplane(z_Rejeita_Banda,p_Rejeita_Banda,k_Rejeita_Banda),title('Z Plane');


