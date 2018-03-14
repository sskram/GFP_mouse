function [normA]=normal(A)
A=double(A);
normA=A-min(A(:));
normA=normA./(max(A(:))- min(A(:)));
normA=im2uint16(normA);
normA(normA<3500)=0;