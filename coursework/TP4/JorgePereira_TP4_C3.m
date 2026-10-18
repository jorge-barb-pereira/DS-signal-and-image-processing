%Exercicio C3, criado por: Jorge Barbosa Pereira

function [] = JorgePereira_TP4_C3(X,Y_cell)
L = length(Y_cell{1});
Cor_cell = {[0.75 0 0], [0 0.75 0], [0 0 0.75], [0.75 0.75 0], [0 0.75 0.75],[0.75 0 0.75], [0.25,0.50,0.75],[0.75,0.25,0.50],[0.50,0.75,0.25],[0.75,0.50,0.25],[0.25,0.75,0.50],[0.50,0.25,0.75]};

%Normalização do Sinal de Entrada
if max(X) >= abs(min(X))
    X = X./max(X);
else
    X = X./abs(min(X));
end

if length(X) < L
    raise('O tamanho do Sinal de Entrada deve ser superior ao tamanho dos Sinais de Referência')

%Comparação do Sinal de Entrada Intregralmente
elseif length(X) < 2.0*L

%Auto Correlação do Sinal de Entrada
    NX = 0:length(X)-1;
    Rxx = xcorr(X,X);
    rxx0 = max(Rxx);

    R0_max = [];
    R0_min = [];
    L_max = [];
    L_min = [];

%Plot do Sinal de Entrada
    a = ceil(length(Y_cell)/4)+1;
    figure(1),subplot(a,4,[1,2,3,4]),stem(NX,X,'k'),title('Sinal de Entrada'),ylabel('x [n_x]'),xlabel('n_x'),ylim([-1,1]);

    for i = 1:length(Y_cell)

%Auto Correlação do Sinal de Referência
        Y = Y_cell{i};
        NY = 0:L-1;

        Ryy = xcorr(Y,Y);
        ryy0 = max(Ryy);

%Correlação Cruzada do Sinal de Entrada com o Sinal de Referência
        R0xy = xcorr(X,Y)/sqrt(rxx0*ryy0);
        NXY = (0:length(R0xy)-1) - (length(R0xy)-1)/2;

%Plot dos Sinais de Referência
        figure(1)
        subplot(a,4,i+4)
        stem(NY,Y,'Color',Cor_cell{i}),title(sprintf('Sinal de Referência %d',i),'FontSize',9),ylabel(sprintf('y_{%d} [n_y]',i)),xlabel('n_y');
        ylim([0,1]);

%Plot das Correlações Cruzadas
        figure(2)
        subplot(a-1,4,i)
        plot(NXY,R0xy,'Color',Cor_cell{i}),title(sprintf('Correlação Cruzada entre o Sinal de Entrada e o Sinal de Referência %d',i),'FontSize',7),ylabel(sprintf('r_{xy_{%d}} [l]',i)),xlabel('l');
        ylim([-1,1]);

%Determinação da Correlação Cruzada Máxima para cada Sinal de Referência
        [r0_max,i_max] = max(R0xy);
        l_max = NXY(i_max);
        [r0_min,i_min] = min(R0xy);
        l_min = NXY(i_min);
   
        R0_max = [R0_max, r0_max];
        R0_min = [R0_min, r0_min];
        L_max = [L_max, l_max]; 
        L_min = [L_min, l_min]; 
    end
 
%Determinação da Correlação Cruzada Máxima
    [r0_max,s_max] = max(R0_max);
    l_max = L_max(s_max);

    [r0_min,s_min] = min(R0_min);
    l_min = L_min(s_min);

%Plot do Sinal de Referência mais Semelhante com o Sinal de Entrada
    if isnan(r0_max) || isnan(r0_min)
        stem(NY,zeros(1,L),'Color','k')
    elseif r0_max > abs(r0_min)
        figure(2),sgtitle(sprintf('Correlação Cruzada Máxima -> |r_{xy_{%d}} [l=%d]| = %0.3f',s_max,l_max,r0_max),'FontSize',10)
        figure(3),hold on, plot(NX,X,'k'),stem(NY+l_max,Y_cell{s_max},'Color',Cor_cell{s_max}),title('Comparação do Sinal de Entrada com o Sinal de Referência com maior Correlação Cruzada'),legend('Sinal de Entrada',sprintf('Sinal de Referência %d',s_max)),ylabel(sprintf('x [n_x] | y_%d [n_x]',s_max)),xlabel('n_x'),hold off
    else
        figure(2),sgtitle(sprintf('Correlação Cruzada Máxima -> |r_{xy_{%d}} [l=%d]| = %0.3f',s_min,l_min,abs(r0_min)),'FontSize',10)
        figure(3),hold on, plot(NX,X,'k'),stem(NY+l_min,-1.*Y_cell{s_min},'Color',Cor_cell{s_min}),title('Comparação do Sinal de Entrada com o Sinal de Referência com maior Correlação Cruzada'),legend('Sinal de Entrada',sprintf('Simétrico do Sinal de Referência %d',s_max)),ylabel(sprintf('x [n_x] | y_%d [n_x]',s_max)),xlabel('n_x'),hold off
    end

%Comparação do Sinal de Entrada Segmentado    
else
    warning('O tamanho do Sinal de Entrada é pelo menos 2.0x maior que o tamanho do Sinal de Entrada. Como tal, serão realizadas comparações de segmentos do Sinal de Entrada.')

%Plot do Sinal de Entrada
    NX = 0:length(X)-1;  
    a = ceil(length(Y_cell)/4)+1;
    figure(1),subplot(a,4,[1,2,3,4]),stem(NX,X,'k'),title('Sinal de Entrada'),ylabel('x [n_x]'),xlabel('n_x'),ylim([-1,1]);
    
    for i = 1:length(Y_cell)
 
%Plot dos Sinais de Referência
        Y = Y_cell{i};
        NY = 0:L-1;
        subplot(a,4,i+4)
        stem(NY,Y,'Color',Cor_cell{i}),title(sprintf('Sinal de Referência %d',i),'FontSize',8),ylabel(sprintf('y_{%d} [n_y]',i)),xlabel('n_y');
        ylim([0,1]);
    end

%Determinação do número de Segmentos   
    n_L = length(X) / L;
    n_X = 1;
    while n_L > 1-10e-10
        n_X = n_X + 1;
        n_L = n_L / (n_X) * (n_X-1);
    end
    n_L = n_L / (n_X-1) * (n_X);
    n_X = n_X - 1;

%Plot do Sinal de Entrada
    figure(3),plot(NX,X,'k'),
    j_pre=1;
    for j=1:n_X
        
%Auto Correlação do Segmenro do Sinal de Entrada       
        j_pos = round(j*n_L*L);
        Xj = X(j_pre:j_pos);
        Rxxj = xcorr(Xj,Xj);
        rxx0j = max(Rxxj);
        
        R0_max = [];
        R0_min = [];
        L_max = [];
        L_min = [];

        for i = 1:length(Y_cell)
            
%Auto Correlação do Sinal de Referência         
            Y = Y_cell{i};
            NY = 0:L-1;
            Ryy = xcorr(Y,Y);
            ryy0 = max(Ryy);

%Correlação Cruzada do Segmento do Sinal de Entrada com o Sinal de Referência
            R0xy = xcorr(Xj,Y)/sqrt(rxx0j*ryy0);
            NXY = (0:length(R0xy)-1) - (length(R0xy)-1)/2;
   
%Determinação da Correlação Cruzada Máxima para cada Sinal de Referência 
            [r0_max,i_max] = max(R0xy);
            l_max = NXY(i_max);
            [r0_min,i_min] = min(R0xy);
            l_min = NXY(i_min);
   
            R0_max = [R0_max, r0_max];
            R0_min = [R0_min, r0_min];
            L_max = [L_max, l_max]; 
            L_min = [L_min, l_min]; 
        end
        
%Determinação da Correlação Cruzada Máxima de cada Segmento do Sinal de Entrada        
        [r0_max,s_max] = max(R0_max);
        l_max = L_max(s_max);

        [r0_min,s_min] = min(R0_min);
        l_min = L_min(s_min);

%Plot do Sinal de Referência mais Semelhante com o Segmento do Sinal de Entrada
        hold on
        if isnan(r0_max) || isnan(r0_min)
            stem(NY+j_pre-1,zeros(1,L),'Color','k')
        elseif r0_max > abs(r0_min)
            stem(NY+l_max+j_pre-1,Y_cell{s_max},'Color',Cor_cell{s_max})
        else
            stem(NY+l_min+j_pre-1,-1.*Y_cell{s_min},'Color',Cor_cell{s_min})
        end
        hold off
        j_pre = j_pos + 1;
    end
    title('Comparação de Segmentos do Sinal de Entrada com os Sinais de Referência com maior Correlação Cruzada'),ylabel('x [n_x] | y [n_x]'),xlabel('n_x')
end
end

