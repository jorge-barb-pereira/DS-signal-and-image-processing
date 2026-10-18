%Exercicio H, criado por: Jorge Barbosa Pereira

%O script está escrito de forma a mostrar 7 figuras resultantes de segmentações locais de diferentes imagens.
%Tempo total de execução ~ 60 segundos

%Formação da Imagem de Referencia
IM_SEG1 = imread('seg1.jpg');
IM_REF = imbinarize(IM_SEG1);

%Formação de Listas com Vários Fatores Multiplicativos
dp_factor_list = [0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0];
t_factor_list =  [0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0];

%Formação de Listas com Várias Imagens com Diferentes Iluminações
IM_list = {};
IM_list{1} = JorgePereira_TP2_H_Iluminacao(IM_SEG1,0  ,0  ,1  ,1);
IM_list{2} = JorgePereira_TP2_H_Iluminacao(IM_SEG1,0.2,0.8,1  ,1);
IM_list{3} = JorgePereira_TP2_H_Iluminacao(IM_SEG1,0  ,1  ,0  ,1);
IM_list{4} = JorgePereira_TP2_H_Iluminacao(IM_SEG1,0  ,0.5,0.5,1);
IM_list{5} = JorgePereira_TP2_H_Iluminacao(IM_SEG1,0.2,0.8,0.5,1);
IM_list{6} = imread('seg2.jpg');
IM_list{7} = imread('seg3.jpg');

%Estabelece o Numero Máximo de Subdivisões SxS
S_max = 13;

%Lista de Cores e as Colunas dos Plots
Cor_list = {[1 0 0], [0 1 0], [0 0 1], [1 1 0], [1 0 1], [0 1 1], [0.5 0.5 0.5], [0 0 0]};
C_PLOT =length(dp_factor_list)/2 + 1;

%Ciclo que seleciona as Várias Imagens
for i_IM = 1:length(IM_list)
    IM = IM_list{i_IM};
    T_GLO = graythresh(IM);
    DP_GLO = std2(IM);
    
%Formação de uma figura por Imagem
    figure(i_IM)
    sgtitle(sprintf('Fator_{DP} -> Fator Multiplicativo do Critério da Homogeneidade\nFator_{T} -> Fator Multiplicativo do Thresholding Homogeneo'),'FontSize', 9)

%Plot da Imagem Original
    subplot(2,C_PLOT,1)
    imshow(IM), title(sprintf('Imagem Original \n T_{Global} = %0.0f  |  DP_{Global} = %0.1f', T_GLO*255, DP_GLO),'FontSize')
    E_LOC = 10;

%Ciclo que seleciona o Fator Multiplicativo do Criterio de Homogeneidade
    for i_dp = 1:length(dp_factor_list)
        dp_factor = dp_factor_list(i_dp);
        
        if i_dp < C_PLOT
            subplot(2,C_PLOT,i_dp+1),axis([1 S_max 0 1])
        else
            subplot(2,C_PLOT,i_dp+2),axis([1 S_max 0 1])
        end
        hold on
        
%Ciclo que Seleciona o Fator Multiplicativo do Thresholding Homogeneo
        for i_t = 1:length(t_factor_list)
            t_factor = t_factor_list(i_t);
            
            E_list = [];
            S_list= [];
            
%Ciclo que Seleciona o Numero de Subdivisões
            for S = 1:S_max
                
%Formação da Imagem Segmentada
                IM_B = JorgePereira_TP2_H_Local (IM, S, dp_factor, t_factor);
                
%Calculo do Indice da Jaccard e do Indice de Hammoude por Comparação com a Imagem de Referencia
                E = 1-jaccard(IM_REF,IM_B);
                
%Seleção da Imagem com Melhor Segmentação Local
                if E < E_LOC
                    IM_LOC = IM_B;
                    dp_factor_LOC = dp_factor;
                    t_factor_LOC = t_factor;
                    S_LOC = S;
                    E_LOC = E;
                end
                E_list = [E_list, E];
                S_list = [S_list, S];
            end
            
%Plot do Indice de Hammoude em função Número de Subdivições
            plot(S_list,E_list, 'Color', Cor_list{i_t}), title(sprintf('Segmentação Local com Fator_{DP} = {%0.2f}',dp_factor),'FontSize', 9)
        end
        xlabel('Subdivisões (S)'), ylabel('Indice de Hammoude') 
        hold off
    end
    
    legend_list = cellstr(num2str(t_factor_list', 'Fator_{T} = %0.2f'));
    legend(legend_list)
    
%Plot da Imagem com Melhor Segmentação
    subplot(2,C_PLOT,C_PLOT+1),imshow(IM_LOC), title(sprintf('Imagem Binária com Melhor Segmentação \n Indice_{Hammoude} = %0.2f \n Fator_{DP} = %0.2f  |  Fator_{T} = %0.2f  |  S = %d', E_LOC, dp_factor_LOC, t_factor_LOC, S_LOC))
end