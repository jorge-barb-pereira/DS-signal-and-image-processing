%Função Complementar ao Exercicio D1 e D3, criado por: Jorge Barbosa Pereira

function [y] = JorgePereira_TP6_C2_Interpolacao(x, x_inf, x_sup, y_inf, y_sup)

if x < x_inf || x > x_sup
    error('O Input "x" deve pertencer ao intervalo [x_inf;x_sup]')
end

delta_x = x_sup - x_inf;
delta_y = y_sup - y_inf;
declive = delta_y / delta_x;
    
y = declive * (x - x_inf) + y_inf;

if x_inf == x_sup
    y = (y_inf + y_sup)/2;
end
end

