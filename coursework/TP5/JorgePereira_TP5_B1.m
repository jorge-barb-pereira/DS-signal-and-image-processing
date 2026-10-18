%Exercicio B1, criado por: Jorge Barbosa Pereira

%Construção dos Sinais
X0 = [];
Ra = [];
Rb = [];
N = [];
L = 256;

for n=0:(L-1)
    x0 = 0.2*n*exp(-0.03*n);
    X0 = [X0,x0];
    ra = (cos(0.81*pi*n)+cos(0.85*pi*n)+cos(0.91*pi*n)+cos(0.95*pi*n))/4;
    Ra = [Ra,ra];
    rb = (rand(1) - 0.5)*0.8;
    Rb = [Rb,rb];
    N = [N,n];
end

Xa = X0 + Ra;
Xb = X0 + Rb;
Xc = X0 + Ra + Rb;

%Plot das Figuras
figure(1)
subplot(2,3,1),plot(N,X0),xlim([0,L-1]),ylim([-1,3.5]),title('Sinal X_0'),xlabel('n'),ylabel('x_0 [n]');
subplot(2,3,2),plot(N,Ra),xlim([0,L-1]),ylim([-1,1]),title('Sinal R_a'),xlabel('n'),ylabel('r_a [n]');
subplot(2,3,3),plot(N,Rb),xlim([0,L-1]),ylim([-0.4,0.4]),title('Sinal R_b'),xlabel('n'),ylabel('r_b [n]');
subplot(2,3,4),plot(N,Xa),xlim([0,L-1]),ylim([-1,3.5]),title('Sinal X_a'),xlabel('n'),ylabel('x_a [n]');
subplot(2,3,5),plot(N,Xb),xlim([0,L-1]),ylim([-1,3.5]),title('Sinal X_b'),xlabel('n'),ylabel('x_b [n]');
subplot(2,3,6),plot(N,Xc),xlim([0,L-1]),ylim([-1,3.5]),title('Sinal X_c'),xlabel('n'),ylabel('x_c [n]');

%Transformada de Fourier dos Sinais
F_X0 = fft(X0);
F_Ra = fft(Ra);
F_Rb = fft(Rb);
F_Xa = fft(Xa);
F_Xb = fft(Xb);
F_Xc = fft(Xc);

%Modulo e Fase
mod_F_Xa = [abs(F_Xa),abs(F_Xa(1))];
ang_F_Xa = [angle(F_Xa),angle(F_Xa(1))];

%Vetores com dois Periódos
ang_F_Xa_2P = [ang_F_Xa(1:L),ang_F_Xa];
mod_F_Xa_2P = [mod_F_Xa(1:L),mod_F_Xa];
W_pos = [N./L*2,2];
W_neg = -1.*flip(W_pos);
W_2P = [W_neg(1:L),W_pos];

%Indices de multiplos de pi
i_neg_2pi = 0;
i_neg_pi = L*(1/2)+1;
i_zero_pi = L*(2/2)+1;
i_pos_pi = L*(3/2)+1;
i_pos_2pi = L*(4/2)+1;

%Plot das Figuras
figure(2)
subplot(2,3,1),plot(W_2P(i_zero_pi:i_pos_2pi),mod_F_Xa_2P(i_zero_pi:i_pos_2pi)),xlim([-0.1,2.1]),ylim([-5,230]),title('Módulo da Transformada de Fourier Discreta do Sinal X_a entre [0:2\pi]','FontSize', 9),xlabel('\omega (\pi^{-1})'),ylabel('|FTD_X_a [\omega]|')
subplot(2,3,2),plot(W_2P(i_neg_pi:i_pos_pi),mod_F_Xa_2P(i_neg_pi:i_pos_pi)),xlim([-1.1,1.1]),ylim([-5,230]),title('Módulo da Transformada de Fourier Discreta do Sinal X_a entre [-\pi:\pi]','FontSize', 9),xlabel('\omega (\pi^{-1})'),ylabel('|FTD_X_a [\omega]|')
subplot(2,3,3),plot(W_2P(i_zero_pi:i_pos_pi),mod_F_Xa_2P(i_zero_pi:i_pos_pi)),xlim([-0.05,1.05]),ylim([-5,230]),title('Módulo da Transformada de Fourier Discreta do Sinal X_a entre [0:\pi]','FontSize', 9),xlabel('\omega (\pi^{-1})'),ylabel('|FTD_X_a [\omega]|')
subplot(2,3,4),plot(W_2P(i_zero_pi:i_pos_2pi),ang_F_Xa_2P(i_zero_pi:i_pos_2pi)),xlim([-0.1,2.1]),title('Fase da Transformada de Fourier do Sinal X_a entre [0:2\pi]','FontSize', 9),xlabel('\omega (\pi^{-1})'),ylabel('θ(TFD_X_a [\omega])')
subplot(2,3,5),plot(W_2P(i_neg_pi:i_pos_pi),ang_F_Xa_2P(i_neg_pi:i_pos_pi)),xlim([-1.1,1.1]),title('Fase da Transformada de Fourier do Sinal X_a entre [-\pi:\pi]','FontSize', 9),xlabel('\omega (\pi^{-1})'),ylabel('θ(TFD_X_a [\omega])')
subplot(2,3,6),plot(W_2P(i_zero_pi:i_pos_pi),ang_F_Xa_2P(i_zero_pi:i_pos_pi)),xlim([-0.05,1.05]),title('Fase da Transformada de Fourier do Sinal X_a entre [0:\pi]','FontSize', 9),xlabel('\omega (\pi^{-1})'),ylabel('θ(TFD_X_a [\omega])')

%Modulo
mod_F_X0 = abs(F_X0);
mod_F_Ra = abs(F_Ra);
mod_F_Rb = abs(F_Rb);
mod_F_Xa = abs(F_Xa);
mod_F_Xb = abs(F_Xb);
mod_F_Xc = abs(F_Xc);
W = N./L*2;
i_pi = L*(1/2)+1;

%Plot das Figuras
figure(3)
subplot(2,3,1),plot(W(1:i_pi),mod_F_X0(1:i_pi)),xlim([-0.05,1.05]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal X_0'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_X_0 [\omega]|')
subplot(2,3,2),plot(W(1:i_pi),mod_F_Ra(1:i_pi)),xlim([-0.05,1.05]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal R_a'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_R_a [\omega]|')
subplot(2,3,3),plot(W(1:i_pi),mod_F_Rb(1:i_pi)),xlim([-0.05,1.05]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal R_b'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_R_b [\omega]|')
subplot(2,3,4),plot(W(1:i_pi),mod_F_Xa(1:i_pi)),xlim([-0.05,1.05]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal X_a'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_X_a [\omega]|')
subplot(2,3,5),plot(W(1:i_pi),mod_F_Xb(1:i_pi)),xlim([-0.05,1.05]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal X_b'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_X_b [\omega]|')
subplot(2,3,6),plot(W(1:i_pi),mod_F_Xc(1:i_pi)),xlim([-0.05,1.05]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal X_c'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_X_c [\omega]|')