close all;clear all;clc;
%%
imageRight=imread('S01R.png');
imageLeft=imread('S01L.png');

imageRight=rgb2gray(imageRight);
imageRight=double(imageRight)

imageLeft=rgb2gray(imageLeft);
imageLeft=double(imageLeft)

w=60; %width of the correlation window should be based on the "scale" of the scene
% w=40 for S00L and S00R
% w=60 for S01L and S01R
k=5;

offset=w+k;

imageRight = padarray(imageRight,[offset offset],'both');
imageLeft = padarray(imageLeft,[offset offset],'both');

[dimensionY,dimensionX]=size(imageLeft);
disparity=zeros(dimensionY,dimensionX);

for xLeft=offset+1:dimensionX-offset-1
    
for yLeft=offset+1:dimensionY-offset-1
    
subLeft=imageLeft(yLeft-k:yLeft+k,xLeft-k:xLeft+k);
dist=[];

for xRight=xLeft:-1:xLeft-w
    
subRight=imageRight(yLeft-k:yLeft+k,xRight-k:xRight+k);

SSD=sum(sum((subLeft-subRight).^2));
dist=[dist;xLeft,xRight,SSD];
end

ind=find(dist(:,3)==min(dist(:,3)));
xRight=dist(ind(1),2);
distance=xLeft-xRight;

disparity(yLeft,xLeft)=distance;
end

end

imageRight=uint8(imageRight);
imageLeft=uint8(imageLeft);

imshow(stereoAnaglyph(imageRight,imageLeft));
figure; imagesc(disparity); colormap jet; colorbar