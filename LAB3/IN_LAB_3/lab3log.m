function[E] = lab3log(img,Th1,Th2)

[row,col,chNum]=size(img);

if (chNum==3)
    img=rgb2gray(img);
end

img=double(img);

J=lab2gaussfilt(img);
kernel=[0 1 0; 1 -4 1; 0 1 0];
E=zeros(size(img));
G = zeros(size(img));
G=conv2(J,kernel,'same');

k=1
% for i = k+1:1:row-k-1
%    for j = k+1:1:col-k-1
%     Window = J(i-k:i+k,j-k:j+k);
%     value = sum(dot(Window,kernel));
%     G(i,j) = value;
%    end
% end

for i=k+1:1:row-k-1
    for j=k+1:1:col-k-1
        
       if (abs(G(i,j))>=Th1)
           if ( (G(i,j)*G(i+1,j)<0) || (G(i,j)*G(i-1,j))<0) || (G(i,j)*G(i,j+1)<0) || (G(i,j)*G(i,j-1)<0 )
               if( (abs(G(i+1,j)-G(i,j))>=Th2) || (abs(G(i-1,j)-G(i,j))>=Th2) || (abs(G(i,j+1)-G(i,j))>=Th2) || (abs(G(i,j-1)-G(i,j))>=Th2))
                   E(i,j)=255;
               end
           end
      
       else
           if ( (G(i+1,j)*G(i-1,j)<0) || (G(i,j+1)*G(i,j-1)<0) )
               if( (abs(G(i+1,j)-G(i-1,j))/2>=Th2) || (abs(G(i,j+1)-G(i,j-1))/2>=Th2) )
                   E(i,j)=255;
               end
           end
       end 
       
    end
end

for(x=1:1:100)
   gp(x) = G(100,x) ;
end

img=uint8(img);
G=uint8(G);
E=uint8(E);

figure
subplot(1,3,1);
imshow(img);
title('Original Image');

subplot(1,3,2);
imshow(G);
title('LoG Filtered Image');

subplot(1,3,3);
plot(gp);
title('Gradient Profile');


end