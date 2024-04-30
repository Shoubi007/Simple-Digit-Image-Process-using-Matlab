function II=adp_median(image,Smax)
%自适应中值滤波
%初始化
II=image;
II(:)=0;
alreadyProcessed=false(size(image));
%迭代
for k=3:2:Smax
zmin=ordfilt2(image,1,ones(k,k),'symmetric');
zmax=ordfilt2(image,k*k,ones(k,k),'symmetric');
zmed=medfilt2(image,[k k],'symmetric');
processUsingLevelB=(zmed>zmin)&(zmax>zmed)&(~alreadyProcessed);%需要转到B步骤的像素
zB=(image>zmin)&(zmax>image);
outputZxy=processUsingLevelB&zB;%满足步骤A，B的输出原值 对应的像素位置
outputZmed=processUsingLevelB&~zB;%满足A,不满足B的输出中值 对应的像素位置
II(outputZxy)=image(outputZxy);
II(outputZmed)=zmed(outputZmed);
alreadyProcessed=alreadyProcessed|processUsingLevelB;%处理过的像素
if all(alreadyProcessed(:))
    break;
end
end
II(~alreadyProcessed)=image(~alreadyProcessed);%超过窗口大小没被处理的像素位置 输出原值
    