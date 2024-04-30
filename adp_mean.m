function output = adp_mean(image,imagen,n)
[width,height]=size(image);
mu=0;  %均值
imagenn=im2double(imagen);%imagen含噪图像
iamgee=im2double(image);
%初始化
imagedd=imagenn;
imagemean=imagenn;
imagevar=imagenn;

sigma=(imagenn-iamgee).^2; %干扰f形成在gxy上的噪声方差
 
for i=1:width-n+1
        for j=1:height-n+1
            pattern=imagenn(i:i+n-1,j:j+n-1);
            patterns=reshape(pattern,1,length(pattern(:)));
            means=mean(patterns);%求均值
            imagemean(i+(n-1)/2,j+(n-1)/2)=means;
            vars=var(patterns,1);%求方差
            imagevar(i+(n-1)/2,j+(n-1)/2)=vars;
        end
end
%对自适应局部滤波的各项条件作了修改
da=(sigma<1);%噪声方差小于1的返回原像素值
dc=~da&(abs(sigma-imagevar)<=100); %噪声方差与局部方差高度相关时，返回一个近似值
db=~dc; %略有调整，剩下的像素位置设置为均值
%da,db,dc为逻辑值
imagedd(da)=imagenn(da);
imagedd(db)=imagemean(db);  
imagedd(dc)=imagenn(dc)-(sigma(dc)./imagevar(dc).*(imagenn(dc)-imagemean(dc)));   
output=imagedd;
end

