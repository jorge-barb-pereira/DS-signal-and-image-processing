%Estudo do exercício A3, criado por: Jorge Barbosa Pereira

%Este script foi criado de modo a comparar as imagens geradas pelas duas versões da função do exercício A3
angs = [15, 30, 45, 60, 75];
i = 1;

%Formação de Tabuleiros com diferentes Angulos de Iluminação através das duas versões da função do exercício A3
for ang = angs
    
    Tab_v1 = JorgePereira_TP1_A3_v1(512,0,1,ang,0);    
    Tab_v2 = JorgePereira_TP1_A3_v2(512,0,1,ang,0);
    Tab_dif = abs(double(Tab_v1) - double(Tab_v2));
    Tab_dif = uint8(Tab_dif);
    
    figure(1)
    subplot(3,length(angs),i)
    imshow(Tab_v1), title(sprintf('Tabuleiro de Xadrez V1 \n Inclinação de Iluminação = %0.2fº',ang))
    subplot(3,length(angs),i + length(angs))
    imshow(Tab_v2), title(sprintf('Tabuleiro de Xadrez V2 \n Inclinação de Iluminação = %0.2fº',ang))
    subplot(3,length(angs),i + 2*length(angs))
    imshow(Tab_dif), title(sprintf('Imagem V1-V2 \n Inclinação de Iluminação = %0.2fº',ang))
    
    figure(2)
    subplot(3,length(angs),i)
    imhist(Tab_v1), title(sprintf('Histograma de Cinzentos V1 \n Inclinação de Iluminação = %0.2fº',ang))
    subplot(3,length(angs),i + length(angs))
    imhist(Tab_v2), title(sprintf('Histograma de Cinzentos V2 \n Inclinação de Iluminação = %0.2fº',ang))
    subplot(3,length(angs),i + 2*length(angs))
    imhist(Tab_dif), title(sprintf('Histograma de Cinzentos V1-V2 \n Inclinação de Iluminação = %0.2fº',ang))
    i = i + 1;
end

%Conclui-se que ambas as funções produzem o efeito de ilumminação gradual pretendido, apesar das imagens geradas pelas duas funções não serem iguais.
%Contudo a função V2 é muito mais eficiente do que a função V1, uma vez que na versão V1 foi implementado um algoritmo iterativo e na função V2 foi usado formulas geométricas de forma direta.