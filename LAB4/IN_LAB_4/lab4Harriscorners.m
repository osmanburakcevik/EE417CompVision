function [Corners_Filtered]=lab4Harriscorners(img,T)

[row,col,ch]=size(img);
if (ch==3)
    img=rgb2gray(img);
end

Corners_Filtered=zeros(size(img));
img=double(img);
Corners_Filtered=double(Corners_Filtered);
corners=[];

k=2;
Simg=lab2gaussfilt(img);
[Gx,Gy]=imgradientxy(Simg);

for i=k+1:1:row-k-1;
    for j=k+1:1:col-k-1; 
        windowIx=Gx(i-k:i+k,j-k:j+k);
        windowIy=Gy(i-k:i+k,j-k:j+k);
        h1=sum(sum(windowIx^2));
        h2=sum(sum(windowIy^2));
        h3=sum(sum(windowIx*windowIy));
        h4=h3;
        H=[h1 h3;h4 h2];
        b=trace(H);
        d=det(H);
        f=d/b;
        if(f>T)
            corners=[corners; i ,j]
        end
        
    end
end

figure;
    imshow(img);
    hold on;
    plot(corners(:,2),corners(:,1),'r*','MarkerSize',7,'LineWidth',1);
    title('Harris algorithm');
    
end