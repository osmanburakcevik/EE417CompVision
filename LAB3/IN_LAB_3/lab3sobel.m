function [x_img,y_img,sob_Grad,sob_Edge] = lab3sobel(img,thold)

[row,col,ch]=size(img);

if (ch==3)
    img=rgb2gray(img);
end

img=double(img);

xfilter=[-1 0 1;-2 0 2;-1 0 1];
yfilter=[-1 -2 -1;0 0 0;1 2 1];

x_img=conv2(img, xfilter);
y_img=conv2(img, yfilter);

sob_Grad=sqrt(x_img.^2+y_img.^2);
sob_Edge=zeros(size(img));

for i=1:1:row
    for j=1:1:col
        if sob_Grad(i,j)<=thold
            sob_Edge(i,j)=0;
        else
            sob_Edge(i,j)=255;
        end
    end
end

x_img=uint8(x_img);
y_img=uint8(y_img);
sob_Grad=uint8(sob_Grad);
sob_Edge=uint8(sob_Edge);

end