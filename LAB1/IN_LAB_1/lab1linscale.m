function [Inew]=lab1linscale(Im) 
[h,w,c]=size(Im); 
if c==3 
    Im=rgb2gray(Im); 
end

I=double(Im); 
a= -min(I(:));
Gmax=255;
b= Gmax/(max(I(:))-min(I(:)));
Inew=b*(I+a);
Inew=uint8(Inew);  

subplot(2,2,1),imshow(Im); 
title 'Original Image'

subplot(2,2,2),imshow(Inew); 
title 'Linearly Scaled Image' 

subplot(2,2,3),histogram(Im); 
xlim([0,255])
ylim([0,11000])
formatSpec="Histogram of the Original Image Umin= %d and Umax= %d";
A1=(min(I(:)));
A2=(max(I(:)));
str=sprintf(formatSpec,A1,A2)
title(str)

subplot(2,2,4),histogram(Inew); 
xlim([0,255])
ylim([0,11000])
formatSpec2="Histogram of the Linearly Scaled Image Umin= %d and Umax= %d";
A3=(min(Inew(:)));
A4=(max(Inew(:)));
str2=sprintf(formatSpec2,A3,A4)
title(str2)
end
