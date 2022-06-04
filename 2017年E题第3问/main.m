clc
clear 
close all
dbstop if error
tic
disp('load data')
% DataGet()
load data
PSwarmSize=10;% pop size
PSize=24;
IterMax=10;% the Number of iterations
IsDraw=0;% Drawing or not the process
IsPlot=1;% Drawing or not the result 
[MaxW,MinW,a,c1,c2,M,D,infinN]=ConstantParameter;% call the Parameter

% Initializing populations
ParticleScope=zeros(PSize,2);
 for h=1:PSize
        ParticleScope(h,2)=D;
        ParticleScope(h,1)=-D;
 end      
 
[row,colum]=size(ParticleScope);
if row~=PSize||colum~=2
    error('Wrong range of particle number dimensions entered.');
end
ParticleScope=zeros(PSize,2);
 for h=1:PSize
        ParticleScope(h,2)=D;
        ParticleScope(h,1)=-D;
 end
[ParSwarm,OptSwarm]=InitSwarm(PSwarmSize,PSize,ParticleScope,M,infinN);
 drawParticle(PSwarmSize,ParSwarm,PSize,IsDraw);
 
% Starting the algorithm
for k=1:IterMax
    % Show the number of iterations£º
    disp('----------------------------------------------------------')
    TempStr=sprintf('the No.%g iteration',k);
    disp(TempStr);
    disp('----------------------------------------------------------')
    
    % Calling the  iterative algorithm
    %[ParSwarm,OptSwarm]=StepFindFunc(ParSwarm,OptSwarm,AdaptFunc,ParticleScope,0.95,0.4,IterMax,k);
    [ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,MaxW,MinW,a,c1,c2,IterMax,k,M,infinN);
    
    % Plotting the new position of a particle in 2 dimensions or less on the graph of the objective function
    drawParticle(PSwarmSize,ParSwarm,PSize,IsDraw);
    
    XResult=OptSwarm(PSwarmSize+1,1:PSize);%Access the global optimal value from this iteration
    [RC,RC_Ca]=decoding(XResult);
    YResult=RC_Ca;%Access the global optimum from this iteration               
    
    % Record the average adaptation at this step
    MeanAdapt(1,k)=mean(ParSwarm(:,2*PSize+1));%mean function of taking the valid value function
end

% Record minimum and maximum average fitness
MinMaxMeanAdapt=[min(MeanAdapt),max(MeanAdapt)];
% Calculating offline and online performance
On_OffLine(IterMax,MeanAdapt,IsPlot);
% Record the optimal value (fitness value) obtained for this iteration
XResult=OptSwarm(PSwarmSize+1,1:PSize);
[RC,RC_Ca,Time]=decoding(XResult);
YResult=Time;
Result={};
Result=[Result,RC,YResult,MinMaxMeanAdapt];

%% output
path=numtostr(Result{1,1});%Convert to string output
for k=1:PSize
    disp(['the path of the No.',num2str(k),' vehicle is£º'])
    disp(path{k})
    disp('the arrive time is£º')
    tik=YResult(k,:);
    tik(find(tik==0))=[];
    tik=[0,tik];
    disp(num2str(tik))
end
