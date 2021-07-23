clear all;
close all;
clc;
v1=[1 2 3];
v2=[4 5 6];
LS=linspace(0,10,1000);
L1 = LS.'*v1;
L2 = LS.'*v2;
figure(1);
hold on;
plot3(L1(:,1),L1(:,2),L1(:,3));
plot3(L2(:,1),L2(:,2),L2(:,3));

%转为单位向量
nv1 = v1/norm(v1);
nv2 = v2/norm(v2);
delta = 10;
if norm(nv1+nv2)==-3
    q = [0 0 0 0];
else
    u = cross(nv1,nv2);
    u = u/norm(u);

    theta = acos(sum(nv1.*nv2))/2;
    s_theta = theta/delta;
    q = [cos(s_theta) sin(s_theta)*u];
end

%由四元数构造旋转矩阵
R=[2*q(1).^2-1+2*q(2)^2  2*(q(2)*q(3)+q(1)*q(4)) 2*(q(2)*q(4)-q(1)*q(3));
    2*(q(2)*q(3)-q(1)*q(4)) 2*q(1)^2-1+2*q(3)^2 2*(q(3)*q(4)+q(1)*q(2));
    2*(q(2)*q(4)+q(1)*q(3)) 2*(q(3)*q(4)-q(1)*q(2)) 2*q(1)^2-1+2*q(4)^2];

for i=1:delta
    L3 = L1*R*norm(v2);
    plot3(L3(:,1),L3(:,2),L3(:,3));
    hold on;
end
hold on;






% s = nv1*R*norm(v2);