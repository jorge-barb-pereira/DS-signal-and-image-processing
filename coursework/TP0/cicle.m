list_m=[]
for i=1:8
    N=10^i;
    [m,P6]=funcao(N);
    list_m=[list_m, m];
end

plot(list_m)