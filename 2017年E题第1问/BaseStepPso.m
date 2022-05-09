%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%基本的粒子群算法的单步更新位置,速度的算法函数
function [ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,MaxW,MinW,a,c1,c2,LoopCount,CurCount,M,infinN)

if nargin~=12  %输入容错
    error('粒子群迭代：输入的参数个数错误。')
end
if nargout~=2  %输出容错
    error('粒子群迭代：输出的个数太少，不能保证循环迭代。')
end


%*********************************************
%*****更改下面的代码，可以更改惯性因子的变化*****
%---------------------------------------------------------------------
%线形递减策略

w=MaxW-CurCount*((MaxW-MinW)/LoopCount);

[ParRow,ParCol]=size(ParSwarm);

%得到粒子的维数
ParCol=(ParCol-1)/2;
SubTract1=OptSwarm(1:ParRow,:)-ParSwarm(:,1:ParCol);%求解出历史最优值与当前位置的差值


for row=1:ParRow
    SubTract2=OptSwarm(ParRow+1,:)-ParSwarm(row,1:ParCol);%计算出全局最优值与当前该粒子位置的差值
    %速度更新公式
    TempV=w.*ParSwarm(row,ParCol+1:2*ParCol)+c1*unifrnd(0,1).*SubTract1(row,:)+c2*unifrnd(0,1).*SubTract2;
    %限制速度的代码
    for h=1:ParCol
        if TempV(:,h)>ParticleScope(h,2)
            TempV(:,h)=ParticleScope(h,2);
        end
        if TempV(:,h)<-ParticleScope(h,2)
            TempV(:,h)=-ParticleScope(h,2)+1e-10;%加1e-10防止适应度函数被零除
        end
    end
    %更新该粒子速度值
    ParSwarm(row,ParCol+1:2*ParCol)=TempV;
     %---------------------------------------------------------------------
    
    TempPos=ParSwarm(row,1:ParCol)+a*TempV;
    %限制位置范围的代码
    for h=1:ParCol
        if TempPos(:,h)>ParticleScope(h,2)
            TempPos(:,h)=ParticleScope(h,2);
        end
        if TempPos(:,h)<=ParticleScope(h,1)
            TempPos(:,h)=ParticleScope(h,1)+1e-10;%加1e-10防止适应度函数被零除
        end
    end
    %更新该粒子位置值
    ParSwarm(row,1:ParCol)=TempPos;
    
    %计算每个粒子的新的适应度值
%     [container_num]=decoding(ParSwarm(k,1:ParticleSize));
%     ParSwarm(k,2*ParticleSize+1)=AdaptFunc(container_num);%计算每个粒子的适应度值
    
    [RC,RC_Ca]=decoding(ParSwarm(row,1:ParCol));
    ParSwarm(row,2*ParCol+1)=RC_Ca;
    
    [RC,RC_Ca]=decoding(OptSwarm(row,1:ParCol));
    if ParSwarm(row,2*ParCol+1)>RC_Ca
        OptSwarm(row,1:ParCol)=ParSwarm(row,1:ParCol);
    end
end
%for循环结束
%寻找适应度函数值最大的解在矩阵中的位置(行数)，进行全局最优值的改变 
[maxValue,row]=min(ParSwarm(:,2*ParCol+1));

[RC,RC_Ca]=decoding(ParSwarm(row,1:ParCol));
YResult=RC_Ca;
[RC,RC_Ca]=decoding(OptSwarm(ParRow+1,:));
Y0Result=RC_Ca;

%if AdaptFunc(ParSwarm(row,1:ParCol))>AdaptFunc(OptSwarm(ParRow+1,:))
if YResult>Y0Result
    OptSwarm(ParRow+1,:)=ParSwarm(row,1:ParCol);
end
