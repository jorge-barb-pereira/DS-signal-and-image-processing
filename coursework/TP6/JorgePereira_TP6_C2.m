%Exercicio C2, criado por: Jorge Barbosa Pereira

%Exemplos de Execução:
%JorgePereira_TP6_C2('MDR_TRN_001.nii',4,5)
%JorgePereira_TP6_C2('MDR_TRN_002.nii',4,5)

function [] = JorgePereira_TP6_C2(data_path,NL,NC)

%Leitura da Serie de TAC
data = load_nii(data_path);
IM_O = data.img;

%Normalização
IM_N = double((IM_O+3024)/6100);

%Numero Total de Plots
N_Plots = NL*NC;

%Numero Total de Cortes da Serie
N_Cortes = size(IM_N,3);

figure(1),sgtitle("           Imagens de TAC: " + data_path, 'FontSize', 11, 'Interpreter', 'none')
for i = 1:N_Plots
    
%Interpolação do número do Corte
    n_C = round(JorgePereira_TP6_C2_Interpolacao(i, 1, N_Plots, 1, N_Cortes));
    C = rot90(IM_N(:,:,n_C));
    
%Plot do Corte
    subplot(NL,NC,i),imshow(C),title(sprintf('Corte %0.0f',n_C))
    
end
end
