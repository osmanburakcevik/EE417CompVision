%% kt
clear all; close all; clc;
tic
%img =checkerboard(20);
img = imread('blocks.png');
imshow(img);
Corners_Filtered= lab4ktcorners(img,50); %image
toc
%% harrison
clear all; close all; clc;
tic
% img =checkerboard(100);
% img = (checkerboard > 0);
img = imread('Monastry.bmp');
imshow(img);
Corners_Filtered= lab4Harriscorners(img,200); %image
toc