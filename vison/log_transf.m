clc; clear all; close all;
im=imread('sample.jpg');
g=rgb2gray(im);
imshow(g)
g2=im2double(g);
J1=1*log(1+g2);
J2=2*log(1+g2);
J3=5*log(1+g2);
figure, imshow(J1)
figure, imshow(J2)
figure, imshow(J3)

