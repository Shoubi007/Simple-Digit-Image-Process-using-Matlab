function output = adp_mean(image,imagen,n)
[width,height]=size(image);
mu=0;  %��ֵ
imagenn=im2double(imagen);%imagen����ͼ��
iamgee=im2double(image);
%��ʼ��
imagedd=imagenn;
imagemean=imagenn;
imagevar=imagenn;

sigma=(imagenn-iamgee).^2; %����f�γ���gxy�ϵ���������
 
for i=1:width-n+1
        for j=1:height-n+1
            pattern=imagenn(i:i+n-1,j:j+n-1);
            patterns=reshape(pattern,1,length(pattern(:)));
            means=mean(patterns);%���ֵ
            imagemean(i+(n-1)/2,j+(n-1)/2)=means;
            vars=var(patterns,1);%�󷽲�
            imagevar(i+(n-1)/2,j+(n-1)/2)=vars;
        end
end
%������Ӧ�ֲ��˲��ĸ������������޸�
da=(sigma<1);%��������С��1�ķ���ԭ����ֵ
dc=~da&(abs(sigma-imagevar)<=100); %����������ֲ�����߶����ʱ������һ������ֵ
db=~dc; %���е�����ʣ�µ�����λ������Ϊ��ֵ
%da,db,dcΪ�߼�ֵ
imagedd(da)=imagenn(da);
imagedd(db)=imagemean(db);  
imagedd(dc)=imagenn(dc)-(sigma(dc)./imagevar(dc).*(imagenn(dc)-imagemean(dc)));   
output=imagedd;
end

