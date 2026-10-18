function [m,P6]= funcao(N)

D=randi(6,1,N);
m=mean(D);
D6=D==6;
P6=100*sum(D==6)/N;

end