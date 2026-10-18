%Exercicio C1, criado por: Jorge Barbosa Pereira

%Leitura da Série de Tac
data = load_nii('MDR_TRN_001.nii');
IM_O = data.img;

%Normalização
IM_N = double((IM_O+3024)./6100);

%Leitura de cada Corte
C10 = rot90(IM_N(:,:,10));
C30 = rot90(IM_N(:,:,30));
C50 = rot90(IM_N(:,:,50));
C70 = rot90(IM_N(:,:,70));
C90 = rot90(IM_N(:,:,90));
C110 = rot90(IM_N(:,:,110));

%Plot das Figuras
figure(1),sgtitle("          Imagens de TAC: MDR_TRN_001.nii", 'FontSize', 11, 'Interpreter', 'none')
subplot(2,3,1),imshow(C10),title('Corte 10');
subplot(2,3,2),imshow(C30),title('Corte 30');
subplot(2,3,3),imshow(C50),title('Corte 50');
subplot(2,3,4),imshow(C70),title('Corte 70');
subplot(2,3,5),imshow(C90),title('Corte 90');
subplot(2,3,6),imshow(C110),title('Corte 110');




