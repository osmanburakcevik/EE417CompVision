function [Jnew]=lab1condscale(Im,Iref) 
[~,~,c]=size(Im);
if c==3 
    Im=rgb2gray(Im); 
end

[~,~,c]=size(Iref);
if c==3 
    Iref=rgb2gray(Iref); 
end

J=double(Im); 
I=double(Iref); 

b=std(I(:))/std(J(:));
a=mean(I(:))/b-mean(J(:));
Jnew=b*(J+a);

disp([mean(I(:)),mean(J(:)),mean(Jnew(:))]);
disp([std(I(:)),std(J(:)),std(Jnew(:))]);

Jnew=uint8(Jnew);

subplot(2,2,1.5),imshow(Iref); 
formatSpec="Reference Image, μ= %d and σ= %d";
A1=(mean(I(:)));
A2=(std(I(:)));
str=sprintf(formatSpec,A1,A2)
title(str)

subplot(2,2,3),imshow(Im); 
formatSpec2="Current Image, μ= %d and σ= %d";
A3=(mean(J(:)));
A4=(std(J(:)));
str2=sprintf(formatSpec2,A3,A4)
title(str2)

subplot(2,2,4),imshow(Jnew);
formatSpec3="Resulting Image, μ= %d and σ= %d";
A5=(mean(Jnew(:)));
A6=(mean(Jnew(:)));
str3=sprintf(formatSpec3,A5,A6)
title(str3)
end