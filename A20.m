clc;clear
close all
folder_path = 'F:\dataset\Set 12'; % 替换为实际的文件夹路径
files = dir(fullfile(folder_path, '*.png')); % 可根据实际文件类型进行调整

for i = 1:length(files)
    filename = fullfile(folder_path, files(i).name);
    img = imread(filename);
    %x=rgb2gray(img);
    x=im2double(img);
    [m,n]=size(x);
    %高斯噪声和椒盐噪声
    y=imnoise(x,'gaussian',0.1);
    z=imnoise(x,'salt & pepper',0.05);
    figure(i)
    subplot(3,3,1);imshow(x);xlabel('Original Image');
    subplot(3,3,2);imshow(y);xlabel('Gaussian Noisy');
    subplot(3,3,3);imshow(z);xlabel('Salt & Pepper');

    y1= adp_mean(x,y,3);
    y2=adp_median(y,20);
    z1= adp_mean(x,z,3);
    z2=adp_median(z,20);

    subplot(3,3,4),imshow(y);xlabel('Gaussian Noisy');
    subplot(3,3,5),imshow(y1);xlabel('Adaptive mean filter');
    subplot(3,3,6),imshow(y2);xlabel('Adaptive median filter'); 

    subplot(3,3,7),imshow(z);xlabel('Salt & Pepper');
    subplot(3,3,8),imshow(z1);xlabel('Adaptive mean filter');
    subplot(3,3,9),imshow(z2);xlabel('Adaptive median filter');
end
 
