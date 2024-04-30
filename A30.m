clc;clear
close all;
img=imread('C:\Users\Shoubi007\Desktop\TestA\TestA\A30.jpg');
I=rgb2gray(img);
[m,n,~]=size(I);
%t_1=I;
%for i=1:m
%for j=1:n
t_1(i,j)=I(i,j)+100*sin(0.4*(i+10))+20*sin(0.4*(j+12));
end
end
figure;imshow(I),title('Original image');
figure;imshow(t_1),title('With Sine noise');
G=im2double(t_1);
I_dft=fft2(G);
figure;imshow(log(1+abs(fftshift(I_dft))),[]),...
title('Spectrum');