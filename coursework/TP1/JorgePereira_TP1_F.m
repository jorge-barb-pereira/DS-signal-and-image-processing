%Exercicio F, criado por: Jorge Barbosa Pereira

%O script está escrito de forma a mostrar 8 figuras resultantes das combinações possíveis dos vários tipos de imagens, tipos de ruidos e paddings.
%Tempo total de execução ~ 60 segundos

%De forma a visualizar menos figuras e serem apresentados resultados mais sucintos
%podem e devem ser apagados alguns elementos das seguintes listas:

IM_O_list = {'real', 'sintetic'};
noise_type_list = {'salt & pepper', 'gaussian'};
pad_list = {'zero', 'symmetric'};

im_path = 'Robot_BW.tif';
function_path = JorgePereira_TP1_A3_v2(512,0.20,0.80,0,0);

n_fig = 0;
max_fil_size = 45;
noise_list = [0.05, 0.10, 0.20, 0.40, 0.80];

%Ciclo que seleciona a Imagem a ser trabalhada
for IM_O_i = 1:length(IM_O_list)
    
    IM_O = IM_O_list{IM_O_i};
    if strcmp(IM_O, 'real')
        IM_O = imread(im_path);
        title_IM_O = 'Imagem Real';
    elseif strcmp(IM_O, 'sintetic')
        IM_O = function_path;
        title_IM_O = 'Imagem Sintética';
    end
    IM_O_d = double(IM_O);
  
%Ciclo que seleciona o tipo de ruído aplicado à imagem
    for noise_type_i = 1:length(noise_type_list)
    
        noise_type = noise_type_list{noise_type_i};
        if strcmp(noise_type, 'salt & pepper')
            title_noise = 'sujeita a Ruído Sal & Pimenta';
        elseif strcmp(noise_type, 'gaussian')
            title_noise = 'sujeita a Ruído Gaussiano';
        end
        
%Ciclo que seleciona o tipo de padding dos filtros
        for pad_i = 1:length(pad_list)
            
            pad =  pad_list{pad_i};
            if strcmp(pad, 'zero')
                pad_AVE = 0;
                pad_MED = pad;
                title_pad = '| Padding Zeros';
            elseif strcmp(pad, 'symmetric')
                pad_AVE = pad;
                pad_MED = pad;
                title_pad = '| Padding Simétrico';
            end
            n_fig = n_fig +1;
            i = 1;
            figure(n_fig)
            sgtitle([title_IM_O ' ' title_noise ' ' title_pad]);
            
%Ciclo que percorre os vários valores de ruido e cria novas imagens degradadas
            for noise = noise_list
                
                IM_N = imnoise(IM_O, noise_type, noise);
                IM_N_d = double(IM_N);

%Calculo do erro absoluto médio inicial devido unicamente ao ruído
                E_N = mean2(abs(IM_O_d - IM_N_d));
                E_AVE_nXn_list = E_N;
                E_AVE_nX1_list = E_N;
                E_AVE_1Xn_list = E_N;
                E_MED_nXn_list = E_N;
                E_MED_nX1_list = E_N;
                E_MED_1Xn_list = E_N;
                fil_size_list = 1;

%Ciclo que percorre vários tamanhos de filtro
                for fil_size = 3:2:max_fil_size

%Aplicação de filtros Média e Mediana (Quadrados , Linha e Coluna) à Imagem com Ruído
                    AVE_nXn = fspecial('average', fil_size);
                    AVE_1Xn = ones(1,fil_size)/fil_size;
                    AVE_nX1 = ones(fil_size,1)/fil_size;
                    IM_AVE_nXn = imfilter(IM_N, AVE_nXn, pad_AVE);
                    IM_AVE_nXn_d = double(IM_AVE_nXn);
                    IM_AVE_1Xn = imfilter(IM_N, AVE_1Xn, pad_AVE);
                    IM_AVE_1Xn_d = double(IM_AVE_1Xn);
                    IM_AVE_nX1 = imfilter(IM_N, AVE_nX1, pad_AVE);
                    IM_AVE_nX1_d = double(IM_AVE_nX1);
                    IM_MED_nXn = medfilt2(IM_N, [fil_size fil_size], pad_MED);
                    IM_MED_nXn_d = double(IM_MED_nXn);
                    IM_MED_1Xn = medfilt2(IM_N, [1 fil_size], pad_MED); 
                    IM_MED_1Xn_d = double(IM_MED_1Xn);
                    IM_MED_nX1 = medfilt2(IM_N, [fil_size 1], pad_MED);
                    IM_MED_nX1_d = double(IM_MED_nX1);

%Calculo dos erros absolutos médios das imagens com filtro e armanezamento dos erros em listas
                    E_AVE_nXn = mean2(abs(IM_O_d - IM_AVE_nXn_d));
                    E_AVE_nXn_list = [E_AVE_nXn_list, E_AVE_nXn];
                    E_AVE_1Xn = mean2(abs(IM_O_d - IM_AVE_1Xn_d));
                    E_AVE_1Xn_list = [E_AVE_1Xn_list, E_AVE_1Xn];
                    E_AVE_nX1 = mean2(abs(IM_O_d - IM_AVE_nX1_d));
                    E_AVE_nX1_list = [E_AVE_nX1_list, E_AVE_nX1];
                    E_MED_nXn = mean2(abs(IM_O_d - IM_MED_nXn_d));
                    E_MED_nXn_list = [E_MED_nXn_list, E_MED_nXn];
                    E_MED_1Xn = mean2(abs(IM_O_d - IM_MED_1Xn_d));
                    E_MED_1Xn_list = [E_MED_1Xn_list, E_MED_1Xn];
                    E_MED_nX1 = mean2(abs(IM_O_d - IM_MED_nX1_d));
                    E_MED_nX1_list = [E_MED_nX1_list, E_MED_nX1];
                    fil_size_list = [fil_size_list, fil_size];
                end

%Plot dos vário gráficos Erro Absoluto Médio vs Tamanho do Filtro

            subplot(2,length(noise_list),i)
            hold on
            plot(fil_size_list,E_AVE_nXn_list),plot(fil_size_list,E_AVE_1Xn_list),plot(fil_size_list,E_AVE_nX1_list)
            hold off
            legend('Filtro Quadrado','Filtro Linha','Filtro Coluna'),ylabel('Erro Absoluto Médio'),xlabel('Tamanho do Filtro')
            title(sprintf('\nPerformance Filtro de Média \n Ruído = %d%%' , noise*100),'FontSize', 8) 

            subplot(2,length(noise_list),i + length(noise_list))
            hold on
            plot(fil_size_list,E_MED_nXn_list),plot(fil_size_list,E_MED_1Xn_list),plot(fil_size_list,E_MED_nX1_list)
            hold off
            legend('Filtro Quadrado','Filtro Linha','Filtro Coluna'),ylabel('Erro Absoluto Médio'),xlabel('Tamanho do Filtro')
            title(sprintf('Performance Filtro de Mediana \n Ruído = %d%%', noise*100),'FontSize', 8) 
    
            i = i + 1;
            end
        end
    end
end

