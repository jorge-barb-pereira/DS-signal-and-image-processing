% It is good practise to include comments in code

%Simulator: throw of dice

N=1000;
D=randi(6,1,N);
m=mean(D)
D6=D==6;  %Boolean Matrix with 1 == True and 0 == False
P6=100*sum(D==6)/N
