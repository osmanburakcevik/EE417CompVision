%% kt
clear all; close all; clc;
tic
% img =checkerboard(20);
img = imread('chessboard.png');
imshow(img);
Corners_Filtered= lab4ktcorners(img,200); %image
toc
%% harrison
clear all; close all; clc;
% img =checkerboard(20);
img = imread('Monastry.bmp');
imshow(img);
Corners_Filtered= lab4Harriscorners(img,1); %image