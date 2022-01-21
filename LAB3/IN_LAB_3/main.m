%% lAB3 edge detection
clear all; close all; clc;
%% sobel
clear all; close all; clc;

img=imread('peppers.png');
[row,col,ch]=size(img);
if (ch==3)
    img=rgb2gray(img);
end

[sobel_X, sobel_Y, sob_Grad, sob_Edge]=lab3sobel(img,150);

figure
subplot(2,3,1);
imshow(img);
title('Original');

subplot(2,3,2);
imshow(sobel_X);
title('Sobel X Filtered');

subplot(2,3,3);
imshow(sobel_Y);
title('Sobel Y Filtered');

subplot(2,3,5);
imshow(sob_Grad);
title('Sobel Gradient');

subplot(2,3,6);
imshow(sob_Edge);
title('Sobel Edges');
%% prewitt
clear all; close all; clc;
im=imread('peppers.png');

[row,col,chNum]=size(im);

if (chNum==3)
    im=rgb2gray(im);
end

[prewX, prewY, prewGrad, prewEdge]=lab3prewitt(im,50);

figure
subplot(2,3,1);
imshow(im);
title('Original Image');

subplot(2,3,2);
imshow(prewX);
title('Prewitt X Filtered Image');

subplot(2,3,3);
imshow(prewY);
title('Prewitt Y Filtered Image');

subplot(2,3,5);
imshow(prewGrad);
title('Prewitt Gradient');

subplot(2,3,6);
imshow(prewEdge);
title('Prewitt Edges');

%% Log
clear all; close all; clc;

img=imread('Object_contours.jpg');
Th1=50;
Th2=50;
[E]=lab3log(img,Th1,Th2);

