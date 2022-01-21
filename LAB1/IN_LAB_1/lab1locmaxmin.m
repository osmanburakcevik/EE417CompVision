function [Imax,Imin]=lab1locmaxmin(Im,k) 
I=double(Im); 
[h,w,c]=size(I); 
Imax=zeros(h,w); 
Imin=zeros(h,w);

for i=k+1:h-k 
    for j=k+1:w-k 
        wp=I(i-k:i+k ,j-k:j+k);
        Imax(i,j)=max(wp(:)); 
        Imin(i,j)=min(wp(:)); 
    end
end

Imax=uint8(Imax); 
Imin=uint8(Imin); 

subplot(1,3,1),imshow(Im); 
title 'Original Image' 

subplot(1,3,2),imshow(Imax); 
formatSpec="Local Max Filtered Image, k=%d"; 
A1=(k);
str=sprintf(formatSpec,A1)
title(str)

subplot(1,3,3),imshow(Imin); 
formatSpec2="Local Min Filtered Image, k=%d"; 
str2=sprintf(formatSpec2,A1)
title(str2)
end