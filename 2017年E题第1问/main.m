clc
clear 
close all
tic
disp('读取数据')
% DataGet()
load data
PSwarmSize=10;%种群规模
PSize=24;%大小
IterMax=10;%迭代次数
IsDraw=1;%是否画图
IsStep=0;%是否一步步迭代
IsPlot=1;
[MaxW,MinW,a,c1,c2,M,D,infinN]=ConstantParameter;%调用常参
%初始化种群
ParticleScope=zeros(PSize,2);
 for h=1:PSize
        ParticleScope(h,2)=D;
        ParticleScope(h,1)=-D;
 end      
 
[row,colum]=size(ParticleScope);
if row~=PSize||colum~=2
    error('输入的粒子的维数范围错误。');
end
ParticleScope=zeros(PSize,2);
 for h=1:PSize
        ParticleScope(h,2)=D;
        ParticleScope(h,1)=-D;
 end
[ParSwarm,OptSwarm]=InitSwarm(PSwarmSize,PSize,ParticleScope,M,infinN);
 drawParticle(PSwarmSize,ParSwarm,PSize,IsDraw);
%开始更新算法的调用
for k=1:IterMax
    %显示迭代的次数：
    disp('----------------------------------------------------------')
    TempStr=sprintf('第 %g 次迭代',k);
    disp(TempStr);
    disp('----------------------------------------------------------')
    
    %调用一步迭代的算法
    %[ParSwarm,OptSwarm]=StepFindFunc(ParSwarm,OptSwarm,AdaptFunc,ParticleScope,0.95,0.4,IterMax,k);
    [ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,MaxW,MinW,a,c1,c2,IterMax,k,M,infinN);
    
    %在目标函数的图形上绘制2维以下的粒子的新位置
    drawParticle(PSwarmSize,ParSwarm,PSize,IsDraw);
    
    XResult=OptSwarm(PSwarmSize+1,1:PSize);%存取本次迭代得到的全局最优值
    [RC,RC_Ca]=decoding(XResult);
    YResult=RC_Ca;%计算全局最优值对应的粒子的适应度值               
    if IsStep~=0
        %XResult=OptSwarm(PSwarmSize+1,1:PSize);
        %YResult=AdaptFunc(XResult);
        str=sprintf('%g 步迭代的最优目标函数值 %g',k,YResult);
        disp(str);
        disp('下次迭代，按任意键继续');
        pause
    end
    
    %记录每一步的平均适应度
    MeanAdapt(1,k)=mean(ParSwarm(:,2*PSize+1));%mean函数为取有效值函数
end
%for循环结束标志

%记录最小与最大的平均适应度
MinMaxMeanAdapt=[min(MeanAdapt),max(MeanAdapt)];

%计算离线与在线性能
On_OffLine(IterMax,MeanAdapt,IsPlot);
%记录本次迭代得到的最优值 适应度值
XResult=OptSwarm(PSwarmSize+1,1:PSize);
[RC,RC_Ca,Rc_CaK]=decoding(XResult);
YResult=Rc_CaK;
Result={};
Result=[Result,RC,YResult,MinMaxMeanAdapt];

%% 输出
path=numtostr(Result{1,1});%转成字符串输出
for k=1:PSize
    disp(['第',num2str(k),'辆车的路径为：',path{k}])
    disp(['其到达时刻为：',num2str(YResult(k))])
end
