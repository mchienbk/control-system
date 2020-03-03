clc; clear all; close all;
im=imread('sample.jpg');
g=rgb2gray(im);
g=im2uint8(g);
[M,N]=size(g);
        for x = 1:M
            for y = 1:N
                s(x,y)= 255-g(x,y);
            end
        end
s = mat2gray(s);
imshow(g), figure, imshow(s);
