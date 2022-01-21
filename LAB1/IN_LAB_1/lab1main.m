%% Linear Scaling
clc; clear; close all
Im = imread('darkImage.png');
[Inew]=lab1linscale(Im);

%% Conditional Scaling
clc; clear; close all
Im = imread('city.png');
Iref = imread('darkImage.png');
[Jnew]=lab1condscale(Im,Iref);

%% Box Filter
clc;clear;close all
Im = imread('aaaa.png');
k=5;
[Inew]=lab1locbox(Im,k);

%% Local Min/Max Filter
clc;clear;close all
Im = imread('darkImage.png');
k=10;
[Imax,Imin]=lab1locmaxmin(Im,k);