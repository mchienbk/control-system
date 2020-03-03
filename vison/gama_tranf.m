clc; clear all; close all;
im=imread('sample.jpg');
g=rgb2gray(im);
imshow(g)
g2=im2double(g);
J1=imadjust(g,[],[],1);
J2=imadjust(g,[],[],3);
J3=imadjust(g,[],[],0.4);
figure,imshow(J1);
figure,imshow(J2);
figure,imshow(J3);
