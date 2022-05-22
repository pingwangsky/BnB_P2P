%******************************************************************************
% This programe is implemented via MATLAB 2018.                              *
% Author :  Ping Wang                                                        *
% Contact:  pingwangsky@gmail.com                                            *
% License:  Copyright (c) 2019 Ping Wang, All rights reserved.               *
% Address:  College of Electrical and Information Engineering,               *
%           Lanzhou University of Technology                                 *
% My site:  https://sites.google.com/view/ping-wang-homepage                 *
%*****************************************************************************/

function out=Branch(branch)
% The input branch is divided into eight sub-branch;
L=branch(1:3);      % lower
U=branch(4:6);      % upper
M=0.5*(L+U);        % middle

lower_x=L(1);   lower_y=L(2);   lower_z=L(3);
middle_x=M(1);  middle_y=M(2);  middle_z=M(3);
upper_x=U(1);   upper_y=U(2);   upper_z=U(3);

out(:,1)=[middle_x,middle_y,middle_z,upper_x,upper_y,upper_z]';
out(:,2)=[lower_x,middle_y,middle_z,middle_x,upper_y,upper_z]';
out(:,3)=[lower_x,lower_y,middle_z,middle_x,middle_y,upper_z]';
out(:,4)=[middle_x,lower_y,middle_z,upper_x,middle_y,upper_z]';
out(:,5)=[middle_x,middle_y,lower_z,upper_x,upper_y,middle_z]';
out(:,6)=[lower_x,middle_y,lower_z,middle_x,upper_y,middle_z]';
out(:,7)=[lower_x,lower_y,lower_z,middle_x,middle_y,middle_z]';
out(:,8)=[middle_x,lower_y,lower_z,upper_x,middle_y,middle_z]';
end