%Exercicio D2, criado por: Jorge Barbosa Pereira

%Exemplos de Execução:
%JorgePereira_TP6_D2('MDR_TRN_001.nii',4)
%JorgePereira_TP6_D2('MDR_TRN_001.nii',4,true)
%JorgePereira_TP6_D2('MDR_TRN_001.nii',25,true)
%JorgePereira_TP6_D2('MDR_TRN_002.nii',25,true)

function [] = JorgePereira_TP6_D2(data_path,N_Plots,Smooth)

if nargin == 2
    Smooth = false;
end

%Leitura das Imagens Aulixiares 
Pulmoes_Nan = imread('pulmoes_nan.png');
Pulmao_Esq_Nan = imread('pulmao_esq_nan.png');
Pulmao_Dir_Nan = imread('pulmao_dir_nan.png');

%Inicialização das Figuras
figure(1),sgtitle("           Imagens Originais da TAC: " + data_path, 'FontSize', 11, 'Interpreter', 'none')
figure(2),sgtitle("           Imagens do Pulmão Esquerdo da TAC: " + data_path, 'FontSize', 11, 'Interpreter', 'none')
figure(3),sgtitle("           Imagens do Pulmão Direito da TAC: " + data_path, 'FontSize', 11, 'Interpreter', 'none')
figure(4),sgtitle("           Imagens dos Pulmões da TAC: " + data_path, 'FontSize', 11, 'Interpreter', 'none')

%Leitura das Imagens de TAC
data = load_nii(data_path);
IM_O = data.img;
IM_N = double((IM_O+3024)/6100);
N_Cortes = size(IM_N,3);

nl = ceil(sqrt(N_Plots));
nc = ceil(sqrt(N_Plots));

for i = 1:N_Plots
%Seleção da Imagem do Corte Original
    n_C = round(JorgePereira_TP6_C2_Interpolacao(i, 1, N_Plots, 1, N_Cortes));
    C_Original = rot90(IM_N(:,:,n_C));
    [N_L,N_C] = size(C_Original);
    
%Plot dos Cortes de TAC de Refência
    figure(1)
    subplot(nl,nc,i),imshow(C_Original),title(sprintf('Corte %0.0f',n_C))
    
%Formação da Imagem com Margem Suavizada
    [Cval, ~, indCval] = unique(C_Original);
    min_C_Original = Cval(2);
    max_C_Original = Cval(end);
    Cval(1) = min_C_Original;
    C_Margem = Cval(indCval);
    C_Margem = reshape(C_Margem, size(C_Original));

%Formação da Imagem com Transformação Linear Ótima
    C_Optima = imadjust(C_Margem,[min_C_Original max_C_Original], []);

%Formação da Imagem com Transformação de Alto Contraste
    C_Contraste = C_Optima .* 2.0;

%Formação da Imagem Negativa
    C_Negativa = imcomplement(C_Contraste);

%Formação da Imagem Binária
    T_d = 0.85;
    C_Binarizada = imbinarize(C_Negativa, T_d);
    
%Formação da Imagem com Etiquetas
    [C_Etiquetas, N_Obj] = bwlabel(C_Binarizada,4);
    C_Etiquetas = uint16(C_Etiquetas);

%Categorização dos Objetos
    Lista_Objetos_Esq = {zeros(N_L,N_C)};
    Lista_Tamanhos_Esq = [0];
    Lista_Objetos_Dir = {zeros(N_L,N_C)};
    Lista_Tamanhos_Dir = [0];
    i_Dir = 2;
    i_Esq = 2;
    
    for j = 1:N_Obj
%Extração dos Objetos que Não Tocam a Margem e os seus respetivos Tamanhos(3 pixeis) 
        Obj = (C_Etiquetas==j);
        Tamanho_Obj = sum(Obj,'all');
    
        Marg = Obj;
        Marg(4:N_L-3,4:N_C-3) = false(N_L-6,N_C-6);
        Tamanho_Marg = sum(Marg,'all');
  
        if Tamanho_Marg == 0 &&  Tamanho_Obj > 5*5

            Metade_Esq = Obj;
            Metade_Esq(1:N_L,N_C/2:N_C) = zeros(N_L,N_C/2+1);
            Tamanho_Metade_Esq = sum(Metade_Esq,'all');
            
%Atribuição do Lado dos Objetos (Esquerda ou Direira)       
            if Tamanho_Metade_Esq/Tamanho_Obj >= 0.75
                Lista_Objetos_Esq{i_Esq} = Obj;
                Lista_Tamanhos_Esq(i_Esq) = Tamanho_Obj;
                i_Esq = i_Esq + 1;
            
            elseif Tamanho_Metade_Esq/Tamanho_Obj <= 0.25
                Lista_Objetos_Dir{i_Dir} = Obj;
                Lista_Tamanhos_Dir(i_Dir) = Tamanho_Obj;
                i_Dir = i_Dir + 1;
            end
        end  
    end

%Ordenação dos Objetos pelo seu Tamanho
    [~ , Ordem_Tamanhos_Esq] = sort(Lista_Tamanhos_Esq,'descend');
    [~ , Ordem_Tamanhos_Dir] = sort(Lista_Tamanhos_Dir,'descend');

%Verificação de Objetos no Lado Esquerdo com Tamanho Significativo
    if Lista_Tamanhos_Esq(Ordem_Tamanhos_Esq(1)) > 20*20
        Esq_Bool = true;    
    
        Pulmao_Esq_Inicial = Lista_Objetos_Esq{Ordem_Tamanhos_Esq(1)};
        Pulmao_Esq = Pulmao_Esq_Inicial;
        Ordem_Tamanhos_Esq(1) = [];

        Pulmao_Esq_Bool = true;
 
%Reconstrução do Pulmão Esquerdo
        while Pulmao_Esq_Bool
        
            for j_Esq = Ordem_Tamanhos_Esq
        
                Obj_Esq = Lista_Objetos_Esq{j_Esq};
                Obj_Dilatado = imdilate(Obj_Esq,strel('disk',5,0));
                Im = Pulmao_Esq_Inicial + Obj_Dilatado;
        
                if max(max(Im))>1
                    Pulmao_Esq = Pulmao_Esq_Inicial + Obj_Esq;
                    Pulmao_Esq_Inicial = Pulmao_Esq;
                    Ordem_Tamanhos_Esq(Ordem_Tamanhos_Esq==j_Esq) = [];
                    Pulmao_Esq_Bool = true;
                    break
                end
                Pulmao_Esq_Bool = false;
            end
        end
          
        if Smooth
            Pulmao_Esq = imopen(imclose(Pulmao_Esq,strel('disk',1,0)),strel('disk',1,0));
        end
        
%Plot do Pulmão Esquerdo 
        figure (2)
        subplot(nl,nc,i),imshow(Pulmao_Esq),title(sprintf('Corte %0.0f',n_C))

    else
        Pulmao_Esq = zeros(N_L,N_C);
        Esq_Bool = false;
    
        figure (2)
        subplot(nl,nc,i),imshow(Pulmao_Esq_Nan),title(sprintf('Corte %0.0f',n_C))
    end

%Verificação de Objetos no Lado Direito com Tamanho Significativo
    if Lista_Tamanhos_Dir(Ordem_Tamanhos_Dir(1)) > 20*20
        Dir_Bool = true;    
    
        Pulmao_Dir_Inicial = Lista_Objetos_Dir{Ordem_Tamanhos_Dir(1)};
        Pulmao_Dir = Pulmao_Dir_Inicial;
        Ordem_Tamanhos_Dir(1) = [];

        Pulmao_Dir_Bool = true;
 
%Reconstrução do Pulmão Direito
        while Pulmao_Dir_Bool
        
            for j_Dir = Ordem_Tamanhos_Dir
        
                Obj_Dir = Lista_Objetos_Dir{j_Dir};
                Obj_Dilatado = imdilate(Obj_Dir,strel('disk',5,0));
                Im = Pulmao_Dir_Inicial + Obj_Dilatado;
        
                if max(max(Im))>1
                    Pulmao_Dir = Pulmao_Dir_Inicial + Obj_Dir;
                    Pulmao_Dir_Inicial = Pulmao_Dir;
                    Ordem_Tamanhos_Dir(Ordem_Tamanhos_Dir==j_Dir) = [];
                    Pulmao_Dir_Bool = true;
                    break
                end
                Pulmao_Dir_Bool = false;
            end
        end
        
        if Smooth
            Pulmao_Dir = imopen(imclose(Pulmao_Dir,strel('disk',1,0)),strel('disk',1,0));
        end
        
%Plot do Pulmão Direito
        figure (3)
        subplot(nl,nc,i),imshow(Pulmao_Dir),title(sprintf('Corte %0.0f',n_C))

    else
        Pulmao_Dir = zeros(N_L,N_C);
        Dir_Bool = false;
    
        figure (3)
        subplot(nl,nc,i),imshow(Pulmao_Dir_Nan),title(sprintf('Corte %0.0f',n_C))
    end    

%Plot de Ambos os Pulmões
    if Esq_Bool || Dir_Bool
        figure(4)
        subplot(nl,nc,i),imshow(Pulmao_Esq + Pulmao_Dir),title(sprintf('Corte %0.0f',n_C))
    else   
        figure (4)
        subplot(nl,nc,i),imshow(Pulmoes_Nan),title(sprintf('Corte %0.0f',n_C))
    end
end    
end

