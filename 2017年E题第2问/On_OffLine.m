
%计算离线与在线性能
function On_OffLine(LoopCount,MeanAdapt,IsPlot)
for k=1:LoopCount
    OnLine(1,k)=sum(MeanAdapt(1,1:k))/k;%求取在线性能的数据
    OffLine(1,k)=min(MeanAdapt(1,1:k)); 
end

for k=1:LoopCount
    OffLine(1,k)=sum(OffLine(1,1:k))/k;%求取离线性能的数据
end

%绘制离线性能与在线性能曲线
%subplot(m,n,p);%将图形窗口分成m行n列的子窗口，序号为p的子窗口为当前窗口
if 1==IsPlot
    subplot(1,2,1);
    %figure
    hold on
    title('离线性能曲线图')
    xlabel('迭代次数');
    ylabel('离线性能');
    grid on
    plot(OffLine);

    subplot(1,2,2);
    %figure
    hold on
    title('在线性能曲线图')
    xlabel('迭代次数');
    ylabel('在线性能');
    grid on
    plot(OnLine);
end
