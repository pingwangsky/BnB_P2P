% 从欧拉角合成旋转矩阵
function R=generate_rotation(a,b,c)
% a=a1*pi/180;
% b=b1*pi/180;
% c=c1*pi/180;
R = rotz(c)*roty(b)*rotx(a);
end


function r = rotx(t)
% roty: rotation about x-axis
r = [1	    0	      0;
     0	cos(t)	-sin(t);
     0	sin(t)	cos(t)];
end

function r = roty(t)
% roty: rotation about y-axis
r = [cos(t)	 0	sin(t);
          0	 1	     0;
    -sin(t)	 0	cos(t)];
end

function r = rotz(t)
% rotz: rotation about z-axis
r = [cos(t)	-sin(t)	0
     sin(t)	 cos(t)	0
         0	     0	1];
end