function [ParSwarm,OptSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope,M,infinN)

if nargin~=5
    error('粒子群初始化：输入的参数个数错误。')
end
if nargout<2
    error('粒子群初始化：输出的参数的个数太少，不能保证以后的运行。');
end

[row,colum]=size(ParticleSize);
if row>1||colum>1
    error('粒子群初始化：输入的粒子的维数错误，是一个1行1列的数据。');
end
[row,colum]=size(ParticleScope);
if row~=ParticleSize||colum~=2
    error('粒子群初始化：输入的粒子的维数范围错误。');
end

%初始化粒子群矩阵
%初始化粒子群矩阵，全部设为[0-1]随机数
%rand('state',0);
% a1=randperm(60);
% a2=randperm(60);
ParSwarm=rand(SwarmSize,2*ParticleSize+1);%初始化位置 速度 历史优化值

%对粒子群中位置,速度的范围进行调节
for k=1:ParticleSize
    ParSwarm(:,k)=ParSwarm(:,k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);%调节速度，使速度与位置的范围一致
    ParSwarm(:,ParticleSize+k)=ParSwarm(:,ParticleSize+k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);
end

%对每一个粒子计算其适应度函数的值
for k=1:SwarmSize
    [RC,RC_Ca]=decoding(ParSwarm(k,1:ParticleSize));
    ParSwarm(k,2*ParticleSize+1)=RC_Ca;%计算每个粒子的适应度值
end

%初始化粒子群最优解矩阵
OptSwarm=zeros(SwarmSize+1,ParticleSize);
%粒子群最优解矩阵全部设为零
[maxValue,row]=min(ParSwarm(:,2*ParticleSize+1));
%寻找适应度函数值最大的解在矩阵中的位置(行数)
OptSwarm=ParSwarm(1:SwarmSize,1:ParticleSize);
OptSwarm(SwarmSize+1,:)=ParSwarm(row,1:ParticleSize);%将适应度值最大的粒子的位置最为全局粒子的最优值


