close all;
clc;
clear;
%利用分支界定法求解3d和2d匹配问题;

%% 生成合成数据
% camera's parameters
npt=7;

width= 640;
height= 480;
f= 800;

nl=0;
% generate 3d coordinates in camera space
Xc= [xrand(1,npt,[-2 2]); xrand(1,npt,[-2 2]); xrand(1,npt,[4 8])];
t= mean(Xc,2)
% r0=randn(3,1);
% R= rodrigues(r0)
%给定旋转真值 
a1=10;
b1=50;
c1=120;

a=a1*pi/180;
b=b1*pi/180;
c=c1*pi/180;
R=generate_rotation(a,b,c)
% transfer 3d points in camera frame to the world frame
Xw= R.'*(Xc-repmat(t,1,npt));

% project 3d points in the camera frame onto the image plane;
xx= [Xc(1,:)./Xc(3,:); Xc(2,:)./Xc(3,:)]*f;
xxn= xx+randn(2,npt)*nl;
xxn= xxn./f;
xxn=xxn(:,end:-1:1);



% 分支定界法求解
% branch-and-bound
n=size(Xw,2);

index=nchoosek(1:n,2)';
W1=Xw(:,index(1,:));
W2=Xw(:,index(2,:));
x1=xxn(:,index(1,:));
x2=xxn(:,index(2,:));

k=size(W1,2);
xx1=[x1;ones(1,k)];
xx2=[x2;ones(1,k)];

nc=xnorm(cross(xx2,xx1));    V=xnorm(W2-W1);

% 设定搜索区域
r_lu=[0,0,0,200,200,200]'; %rotation domain, the search domain of rotation;
r_lu=r_lu*pi/180;
% r_lu=[-pi,-pi,-pi,pi,pi,pi]'; %rotation domain, the search domain of rotation;
best_r=[0;0;0]; % Inilization of rotation;
best_Q=Inf;       % Inilization of object function;                
best_branch=r_lu;
branch=[ ];

Q_u=zeros(1,8); %upper bound of each divided branchs.
Q_l=zeros(1,8); %lower bound of each divided branchs.

V1=[];  %绘图相关
V2=[];
tic
while(norm(best_branch(4:6)-best_branch(1:3))>1e-6)
    new_branch=Branch(best_branch);
    for i=1:8
        [Q_lower,Q_upper]=my_bound(nc,V,new_branch(:,i));
        Q_u(i)=Q_upper;
        Q_l(i)=Q_lower;
    end 
    branch=[branch,[new_branch;Q_l;Q_u]]; 
    [min_Q_u,ind_best_now]=min(Q_u);
    [max_Q_l,ind_best_bran]=min(branch(end-1,:));    %所有下界里面最小的;
    if min_Q_u<best_Q
        best_Q=min_Q_u;
        best_r=0.5*(new_branch(1:3,ind_best_now)+new_branch(4:6,ind_best_now));
    end 
    best_branch=branch(1:6,ind_best_bran);
    branch(:,ind_best_bran)=[];
    branch(:,branch(end-1,:)>best_Q)=[];       
%     Exit if the optError is less than or equal to the lower bound plus a small epsilon
    V1=[V1,best_Q];
    V2=[V2,max_Q_l];
    if(norm(best_Q-max_Q_l)<=1e-4)
        disp('get best rotation!')        
        break;       
    end
end




% 得到最佳的旋转矩阵
R_estimation=generate_rotation(best_r(1),best_r(2),best_r(3))

figure(1);
hold on;
plot(V1,'r-','LineWidth',2);
plot(V2,'b-','LineWidth',2);
xlabel('Iteration','FontSize',15,'FontName','Times New Roman');
ylabel('Upper and Lower bound ','FontSize',15,'FontName','Times New Roman');
legend('Upper','Lower');
set(figure(1),'position',[100,100,400,350]);
box on;

