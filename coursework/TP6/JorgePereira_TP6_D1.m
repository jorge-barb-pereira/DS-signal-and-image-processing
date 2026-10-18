%Exercicio D1, criado por: Jorge Barbosa Pereira

%Leitura das Imagens Aulixiares 
Pulmoes_Nan = imread('pulmoes_nan.png');
Pulmao_Esq_Nan = imread('pulmao_esq_nan.png');
Pulmao_Dir_Nan = imread('pulmao_dir_nan.png');

%Leitura da Serie de TAC
data = load_nii('MDR_TRN_001.nii');
IM_O = data.img;
IM_N = double((IM_O+3024)/6100);

%Seleção da Imagem do Corte Original
n_C = 60;
C_Original = rot90(IM_N(:,:,n_C));
[N_L,N_C] = size(C_Original);

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
Tab = prism(N_Obj);
Tab = [[0,0,0];[1,1,1];[1,0,0];[0,1,0];[0,0,1];Tab];

%Categorização dos Objetos
Lista_Objetos_Esq = {zeros(N_L,N_C)};
Lista_Tamanhos_Esq = [0];
Lista_Objetos_Dir = {zeros(N_L,N_C)};
Lista_Tamanhos_Dir = [0];
i_Dir = 2;
i_Esq = 2;

for i = 1:N_Obj
%Extração dos Objetos que Não Tocam a Margem e os seus respetivos Tamanhos(3 pixeis)     
    Obj = (C_Etiquetas==i);
    Tamanho_Obj = sum(Obj,'all');
    
    Marg = Obj;
    Marg(4:N_L-3,4:N_C-3) = false(N_L-6,N_C-6);
    Tamanho_Marg = sum(Marg,'all');
    
    if Tamanho_Marg == 0 &&  Tamanho_Obj > 5*5

        Metade_Esq = Obj;
        Metade_Esq(1:N_L,N_C/2+1:N_C) = zeros(N_L,N_C/2);
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

%Plot das Imagens do Processamento
figure(1),sgtitle("          Imagens da TAC: MDR_TRN_001.nii", 'FontSize', 12, 'Interpreter', 'none')
subplot(3,3,1),imshow(C_Original),title(sprintf('IM_O → Imagem Original do Corte  %0.0f',n_C))
subplot(3,3,2),imshow(C_Margem),title('IM_M → IM_O com Margem Suavizada')
subplot(3,3,3),imshow(C_Optima),title('IM_{TLO} → IM_M com Transformação Linear Optima')
subplot(3,3,4),imshow(C_Contraste),title('IM_C → IM_{TLO} com Transformação de Alto Contraste')
subplot(3,3,5),imshow(C_Negativa),title('IM_{INV} → IM_C com Inversão de Escala')
subplot(3,3,6),imshow(C_Binarizada),title('IM_{B} → IM_{INV} com Binarização Global')
subplot(3,3,7),imshow(C_Etiquetas,Tab),title('IM_{E} → IM_{B} com Etiquetas')

%Ordenação dos Objetos pelo seu Tamanho
[~ , Ordem_Tamanhos_Esq] = sort(Lista_Tamanhos_Esq,'descend');
[~ , Ordem_Tamanhos_Dir] = sort(Lista_Tamanhos_Dir,'descend');

%Verificação de Objetos no Lado Esquerdo com Tamanho Significativo
figure(2),sgtitle(sprintf('         Segmentação dos Pulmões no Corte %0.0f da TAC: MDR_TRN_001.nii',n_C), 'FontSize', 12,'Interpreter', 'none') 

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
    
    Pulmao_Esq_Suave = imopen(imclose(Pulmao_Esq,strel('disk',1,0)),strel('disk',1,0));

    %Plot do Pulmão Esquerdo  
    figure (2)
    subplot(2,3,1),imshow(Pulmao_Esq),title('Pulmão Esquerdo')
    subplot(2,3,4),imshow(Pulmao_Esq_Suave),title('Pulmão Esquerdo Suavizado')

else
    Pulmao_Esq = zeros(N_L,N_C);
    Pulmao_Esq_Suave = Pulmao_Esq;
    Esq_Bool = false;
    
    figure (2)
    subplot(2,3,1),imshow(Pulmao_Esq_Nan),title('Pulmão Esquerdo')
    subplot(2,3,4),imshow(Pulmao_Esq_Nan),title('Pulmão Esquerdo Suavizado')
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
    
    Pulmao_Dir_Suave = imopen(imclose(Pulmao_Dir,strel('disk',1,0)),strel('disk',1,0));

 %Plot do Pulmão Direito  
    figure (2)
    subplot(2,3,3),imshow(Pulmao_Dir),title('Pulmão Direito Identificado')
    subplot(2,3,6),imshow(Pulmao_Dir_Suave),title('Pulmão Direito Suavizado')
    
else
    Pulmao_Dir = zeros(N_L,N_C);
    Pulmao_Dir_Suave = Pulmao_Dir;
    Dir_Bool = false;
    
    figure (2)
    subplot(3,3,3),imshow(Pulmao_Dir_Nan),title('Pulmão Direito Identificado')
    subplot(2,3,6),imshow(Pulmao_Dir_Nan),title('Pulmão Direito Suavizado')
end    

%Plot de Ambos os Pulmões
if Esq_Bool || Dir_Bool
    figure (1)
    subplot(3,3,8),imshow(Pulmao_Esq + Pulmao_Dir),title('IM_{PI} → Pulmões Identificados')
    subplot(3,3,9),imshow(Pulmao_Esq_Suave + Pulmao_Dir_Suave),title('IM_{PS} → Pulmões Suavizados')
    figure (2)
    subplot(2,3,2),imshow(Pulmao_Esq + Pulmao_Dir),title('Pulmões Identificados')
    subplot(2,3,5),imshow(Pulmao_Esq_Suave + Pulmao_Dir_Suave),title('Pulmões Suavizados')
else   
    figure (1)
    subplot(3,3,8),imshow(Pulmoes_Nan),title('IM_{PI} → Pulmões Identificados')
    subplot(3,3,9),imshow(Pulmoes_Nan),title('IM_{PS} → Pulmões Suavizados')
    figure (2)
    subplot(2,3,2),imshow(Pulmoes_Nan),title('Pulmões Identificados')
    subplot(2,3,5),imshow(Pulmoes_Nan),title('Pulmões Suavizados')
end  
