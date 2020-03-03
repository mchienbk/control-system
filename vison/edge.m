clc; clear all; close all;
% Load Image
im=imread('sample.jpg');
g=im;
% g=rgb2gray(im);
imshow(g)

% Canny and Sobel Edge detect
% BW1 = edge(g,'sobel');
BW2 = edge(g,'canny');
BW3 = edge(I,'Prewitt');
figure;
imshowpair(BW3,BW2,'montage')
title('Prewitt Filter                                   Canny Filter');
