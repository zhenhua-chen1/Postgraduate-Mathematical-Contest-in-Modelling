function [MaxW,MinW,a,c1,c2,M,D,infinN]=ConstantParameter
%MaxW,MinW,a全为1时,即为最简单的速度控制
%MaxW=0.95;
%MinW=0.4;
MaxW=0.95;
MinW=0.4;
a=0.729;%约束因子
c1=2;
c2=2;
M=4;%路径解码中，一条路径中，待加入新节点ID最大后退间隔
D=60;%以原点为中心的搜索半径
infinN=-50000;%相当于无穷小，在优先权重比较中，不被第二次选中，或方便比较的初值