vl=1:100;
vc=ones(100,1);
M=vc*vl;
imshow(M);

M2=M/100;
imshow(M2);

M3=mat2gray(M);
imshow(M3);

%Double -> escala de cinzentos [0:1]

M8bits=uint8(M);
imshow(M8bits);

%Uint8 -> escala de cinzentos [0:255]
