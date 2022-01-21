%% Part 1: Linear Filtering (Gaussian)
clear all; close all; clc;
img = imread('gaussNoise.png');
ResImg = lab2gaussfilt(img);
figure
    subplot(1,2,1)
        imshow(img)
    subplot(1,2,2)
        imshow(ResImg)
%% Part 2: Non-Linear Filtering (Median)
clear all; close all; clc;
img = imread('Tiger.png');
k=10;
ResImg = lab2medfilt(img,k);
%% Part 3: Sharpening
clear all; close all; clc;
img = imread('mother.png');
limbda = 10;
Mode = 3;
ResImg = lab2sharpen(img,limbda,Mode);
%% Part 4: First Derivative
clear all; close all; clc;
img = imread('mother.png');
[x_filtered,y_filtered] = lab2sobelfilt(img);