clear all; close all; clc;
%%
img = imread('calibrationObject.png');
[row, col, ch]=size(img);
if ch==3
    img_gray = rgb2gray(img);
end

img_edge = edge(img_gray,'canny');
imshow(img_edge);
[H,theta,rho] = hough(img_edge);
P = houghpeaks(H,2000,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(img_edge,theta,rho,P,'FillGap',10,'MinLength',15);
figure 
subplot(1,2,1), imshow(img)
subplot(1,2,2), imshow(img_gray)
hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','green');
    plot(xy(1,1),xy(1,2),'x','MarkerSize',4,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','MarkerSize',4,'Color','red');
    len = norm(lines(k).point1 - lines(k).point2);
end
hold off
%%
img = imread('calibrationObject.png');
[row, col, ch]=size(img);
if ch==3
    img_gray = rgb2gray(img);
end
corns=detectHarrisFeatures(img_gray);
imshow(img);
hold on;
plot(corns.Location(:,1),corns.Location(:,2),'*','Color','blue');
Lines_B =  [50 190; 200 260];
Lines_E =  [110 110 ; 140 320];
Thetas1=-64;
Thetas2=-10;
Rhos1=-151;
Rhos2=85;

A = [cosd(Thetas1) sind(Thetas1) ;cosd(Thetas2), sind(Thetas2)];
b = [Rhos1;Rhos2];
P=inv(A)*b;

x=[0:col];
y1=((Rhos1-x*cosd(Thetas1))/sind(Thetas1));
y2=((Rhos2-x*cosd(Thetas2))/sind(Thetas2));

plot(0:col,y1,'r','LineWidth',1.5,'Color','magenta');
plot(0:col,y2,'r','LineWidth',1.5,'Color','magenta');
plot(P(1,1),P(2,1),'*','MarkerSize',3,'Color','magenta');
