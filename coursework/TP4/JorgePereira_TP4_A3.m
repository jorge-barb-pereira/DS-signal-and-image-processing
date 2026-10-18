%Exercicio A3, criado por: Jorge Barbosa Pereira

%Exemplo de Execução: JorgePereira_TP4_A3([1,2,3,4,5,6,5,4,3,2,1],[1,2,3,4,5,6,5,4,3,2,1])
%Exemplo de Execução: JorgePereira_TP4_A3([1,2,3,4,5,6,5,4,3,2,1],[2,2,2,2,2,2,2,2,2,2,2])
function [ER] = JorgePereira_TP4_A3(X1, X2)

%Verificação dos Tamanhos Identicos dos Sinais
if length(X1) ~= length(X2)
    warning('Os Inputs X1 e X2 devem mesmo número de elementos')
    while length(X1) > length(X2)
        X2 = [X2,0];
    end
    while length(X1) > length(X2)
        X1 = [X1,0];
    end    
end

%Calculo do Erro Relativo
ER = norm(X2-X1,2)/norm(X1,2);

end

