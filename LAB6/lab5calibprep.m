close all;clear all;clc;

%%
im=imread('assignmente.png');

[row,col,chNum]=size(im);

if (chNum==3)
    im=rgb2gray(im);
end

corners=detectHarrisFeatures(im);

imshow(im);
hold on;
plot(corners.Location(:,1),corners.Location(:,2),'*');

%%
BW = edge(im,'canny');

[H,theta,rho] = hough(BW);

P = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(BW,theta,rho,P,'FillGap',10,'MinLength',15);

%%

line1=[0 490 ; 1078 700];

theta1=75;
rho1=329.878;

line2=[0 490 ; 1078 700];
theta2=-45;
rho2=204.067;

b=[rho1; rho2];

A=[cosd(theta1) sind(theta1); cosd(theta2) sind(theta2)];

intPoint=inv(A)*b;

x=[0:col];
y1=(rho1-x*cosd(theta1))/sind(theta1);
y2=(rho2-x*cosd(theta2))/sind(theta2);

plot(0:col,y1,'r','LineWidth',1.5);
plot(0:col,y2,'r','LineWidth',1.5);
plot(intPoint(1,1),intPoint(2,1),'*','LineWidth',1,'color','yellow');


% % PLOTTING CORNERS FOR COMPARISON
% plot(harris(:,1),harris(:,2),'bo',"MarkerSize",5);
% plot(C(1),C(2),'x',"MarkerSize",5,'Color','magenta');
% x1=C(1);
% y1=C(2);
% x2=324;
% y2=331;
% distance=sqrt((x2-x1)^2+(y2-y1)^2);
% disp('distance: ')
% disp(distance)
