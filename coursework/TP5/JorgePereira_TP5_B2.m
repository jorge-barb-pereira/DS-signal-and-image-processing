%Exercicio B2, criado por: Jorge Barbosa Pereira

%Construção dos Sinais
X0 = [];
Ra = [];
N = [];
L = 256;

for n=0:L-1
    x0 = 0.2*n*exp(-0.03*n);
    X0 = [X0,x0];
    ra = (cos(0.81*pi*n)+cos(0.85*pi*n)+cos(0.91*pi*n)+cos(0.95*pi*n))/4;
    Ra = [Ra,ra];
    N = [N,n];
end

Xa = X0 + Ra;

%Transformada de Fourier dos Sinais
F_X0 = fft(X0);
F_Xa = fft(Xa);

%Filtro Ideal
F_f = [ones(1,L/4),zeros(1,L/2),ones(1,L/4)];
F_Xaf = F_Xa.*F_f;

%Modulo
mod_F_X0 = abs(F_X0);
mod_F_Xa = abs(F_Xa);
mod_F_Xaf = abs(F_Xaf);
max_F_Xaf = max(mod_F_Xaf);

W = N./L*2;

%Sinal Filtrado
Xaf = ifft(F_Xaf);

%Plot das Figuras
figure(1)
subplot(2,3,1),plot(N,X0),xlim([0,L-1]),ylim([-1.1,3.1]),title('Sinal X_0'),xlabel('n'),ylabel('x_0 [n]');
subplot(2,3,2),plot(N,Xa),xlim([0,L-1]),ylim([-1.1,3.1]),title('Sinal X_a'),xlabel('n'),ylabel('x_a [n]');
subplot(2,3,3),hold on,plot(N,real(Xaf)),plot(N,imag(Xaf)),hold off,legend('Componente Real','Componente Imaginária'),xlim([0,L-1]),ylim([-0.1,3]),title('Sinal X_a Filtrado'),xlabel('n'),ylabel('x_a_f [n]');
subplot(2,3,4),plot([W,2],[mod_F_X0,mod_F_X0(1)]),xlim([-0.1,2.1]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal X_0'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_X_0 [\omega]|')
subplot(2,3,5),plot([W,2],[mod_F_Xa,mod_F_X0(1)]),xlim([-0.1,2.1]),ylim([-5,230]),title('Módulo da Transformada de Fourier do Sinal X_a'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_X_a [\omega]|')
subplot(2,3,6),hold on,plot([W,2],[F_f*max_F_Xaf,F_f(1)*max_F_Xaf],'--','Color',[0.5,0.5,0.5]),plot([W,2],[mod_F_Xaf,mod_F_Xaf(1)],'Color',[0 0.447 0.741]),xlim([-0.1,2.1]),hold off,ylim([-5,230]),legend('Filtro Passa-Baixo: \omega = 0.5\pi'),title('Módulo da Transformada de Fourier do Sinal X_a Filtrado'),xlabel('\omega (\pi^{-1})'),ylabel('|TFD_X_a_f [\omega]|')