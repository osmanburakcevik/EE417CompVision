function [x_img,y_img,prewGrad,prewEdge] = lab3prewitt(img,thold)

[row,col,chNum]=size(img);

if (chNum==3)
    img=rgb2gray(img);
end

img=double(img);

xfilter=[-1 0 1;-1 0 1;-1 0 1];
yfilter=[-1 -1 -1;0 0 0;1 1 1];

x_img=conv2(img, xfilter);
y_img=conv2(img, yfilter);

prewGrad=sqrt(x_img.^2+y_img.^2);
prewEdge=zeros(size(img));
for i=1:1:row
   
    for j=1:1:col
        
        if prewGrad(i,j)<=thold
        prewEdge(i,j)=0;
        
        
        else
            prewEdge(i,j)=255;
        end
            
    end  
    
end