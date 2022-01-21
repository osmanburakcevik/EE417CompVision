tic
A = imread('coin.png');
A=rgb2gray(A);
imshow(A)
Rmin = 20;
Rmax = 60;

[centersBright, radiiBright] = imfindcircles(A,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',0.9);

[centersDark, radiiDark] = imfindcircles(A,[Rmin Rmax],'ObjectPolarity','bright','Sensitivity',0.9);

viscircles(centersBright, radiiBright,'Color','b');
viscircles(centersDark, radiiDark,'LineStyle','--');
toc