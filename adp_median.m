function II=adp_median(image,Smax)
%����Ӧ��ֵ�˲�
%��ʼ��
II=image;
II(:)=0;
alreadyProcessed=false(size(image));
%����
for k=3:2:Smax
zmin=ordfilt2(image,1,ones(k,k),'symmetric');
zmax=ordfilt2(image,k*k,ones(k,k),'symmetric');
zmed=medfilt2(image,[k k],'symmetric');
processUsingLevelB=(zmed>zmin)&(zmax>zmed)&(~alreadyProcessed);%��Ҫת��B���������
zB=(image>zmin)&(zmax>image);
outputZxy=processUsingLevelB&zB;%���㲽��A��B�����ԭֵ ��Ӧ������λ��
outputZmed=processUsingLevelB&~zB;%����A,������B�������ֵ ��Ӧ������λ��
II(outputZxy)=image(outputZxy);
II(outputZmed)=zmed(outputZmed);
alreadyProcessed=alreadyProcessed|processUsingLevelB;%�����������
if all(alreadyProcessed(:))
    break;
end
end
II(~alreadyProcessed)=image(~alreadyProcessed);%�������ڴ�Сû�����������λ�� ���ԭֵ
    