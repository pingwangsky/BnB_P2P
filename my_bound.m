%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This programe is implemented via MATLAB 2018.                              %
% Author :  Ping Wang                                                        %
% Contact:  pingwangsky@gmail.com                                            %
% License:  Copyright (c) 2019 Ping Wang, All rights reserved.               %
% Address:  College of Electrical and Information Engineering,               %
%           Lanzhou University of Technology                                 %
% My site:  https://sites.google.com/view/ping-wang-homepage                 %
%  Github:  https://github.com/pingwangsky                                   %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Q_lower,Q_upper]=my_bound4(nc,V,Bi)
% Compute the rotation uncertainty distance (maxRotDis) for each point in the data and each level of rotation subcube
SQRT3=1.732050808;
r0=(Bi(4:6,:)+Bi(1:3,:))*0.5;
% R= rodrigues(r0);
R=generate_rotation(r0(1),r0(2),r0(3));
sigma=0.5*norm(Bi(4)-Bi(1));  %¼ÆËã°ë¾¶
phi=min([SQRT3*sigma,pi]);
n=size(V,2);
m=size(nc,2);
% obj=zeros(m,n);
E=abs(pi/2-acos(abs(nc.'*R*V)));
E1=E-phi;
E1(E1<0)=0;
Q_upper=sum(min(E));
Q_lower=sum(min(E1));
end