function [Inew]=lab1locbox(Im,k)
I=double(Im);
[h,w,c]=size(I);
Inew=I;

for i=k+1:h-k
    for j=k+1:w-k
        wp=I(i-k:i+k,j-k:j+k);
        Inew(i,j)=mean(wp(:));
    end
end

Inew=uint8(Inew);

subplot(2,1,1),imshow(Im);
title 'Original Image'

subplot(2,1,2),imshow(Inew);
formatSpec="Box Filtered Image, k=%d";
A1=(k);
str=sprintf(formatSpec,A1)
title(str)
end