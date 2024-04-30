clc;clear
close all;
folder_path = 'F:\dataset\Set 12'; % 替换为实际的文件夹路径
files = dir(fullfile(folder_path, '*.png')); % 可根据实际文件类型进行调整

for i = 1:length(files)
    filename = fullfile(folder_path, files(i).name);
    I = imread(filename);
    I=im2double(I);
    [m,n,~] = size(I);
    %图像模糊化
    LEN = 10;
    THETA = 20;
    PSF = fspecial('motion',LEN,THETA);
    Blurred = imfilter(I,PSF,'circular','conv');
    %模糊化图像加噪
    V = .002;
    BlurredNoisy = imnoise(Blurred,'gaussian',0,V);
    %用真实的PSF函数采用维纳滤波方法复原图像
    wnr = deconvwnr(Blurred,PSF);
    NSR = sum((V*prod(size(I))).^2) / sum(im2double(I(:)).^2);%信噪比的倒数
    wnr1 = deconvwnr(BlurredNoisy,PSF,1/NSR);
    %用真实的PSF函数和噪声强度作为参数进行约束最小二乘复原
    NP = V*prod(size(I)); % noise power
    Edged = edgetaper(Blurred,PSF);
    Edged1 = edgetaper(BlurredNoisy,PSF);
    [~,LAGRA] = deconvreg(Blurred,PSF);
    [~,LAGRA1] = deconvreg(BlurredNoisy,PSF,NP);
    reg = deconvreg(Edged,PSF,[],LAGRA);
    reg1 = deconvreg(Edged1,PSF,[],LAGRA1);
    %逆滤波
    If= fft2(Blurred); 
    Pf = fft2(PSF,m,n);
    deblurred = ifft2(If./Pf);
    If = fft2(BlurredNoisy);
    Pf = fft2(PSF,m,n);
    Noisy = BlurredNoisy - Blurred;
    Nf = fft2(Noisy);
    deblurred1= ifft2(If./Pf - Nf./Pf);

    figure(i)
    subplot(2,4,1),imshow(Blurred);xlabel('Blur');
    subplot(2,4,2),imshow(deblurred);xlabel('Inverse filter(Blur)');
    subplot(2,4,3),imshow(wnr);xlabel('Wiener filter(Blur)');
    subplot(2,4,4),imshow(reg);xlabel('CLS(Blur)');

    subplot(2,4,5),imshow(BlurredNoisy);xlabel('Blur+Noise');
    subplot(2,4,6),imshow(deblurred1);xlabel('Inverse filter(Blur+Noise)');
    subplot(2,4,7),imshow(wnr1);xlabel('Wiener filtering(Blur+Noise)');
    subplot(2,4,8),imshow(reg1);xlabel('CLS(Blur+Noise)');
end

