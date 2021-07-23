clc;
clear all;
close all;
num = 50; % num个随机点
Rand1 = randi([-1,1],num,3); %噪声范围
Rand2 = randi([-1,1],num,3);

Point1 = [1:0.5:0.5*(num+1); 1:0.5:0.5*(num+1); 1:0.5:0.5*(num+1)]'+ Rand1;
plot3(Point1(:,1),Point1(:,2),Point1(:,3),'r.');
hold on;

Point2 = [0.5*(num+1):-0.5:1; 1:0.5:0.5*(num+1); 0.5*(num+1):-0.5:1]'+ Rand2;
plot3(Point2(:,1),Point2(:,2),Point2(:,3),'g+');

%直线拟合1
t1=linspace(0,25);%有效范围
F1 = @(p)arrayfun(@(n)norm(cross(Point1(num,:)-[p(1),p(2),p(3)],...
    [p(4),p(5),p(6)]))/norm([p(4),p(5),p(6)]),[1:size(Point1,1)]);

p= lsqnonlin(F1,[1 1 1 1 1 1]);
plot3(p(1)+t1*p(4),p(2)+t1*p(5),p(3)+t1*p(6));

%直线拟合2
t2=linspace(0,-8);
F2 = @(p)arrayfun(@(n)norm(cross(Point2(num,:)-[p(1),p(2),p(3)],...
    [p(4),p(5),p(6)]))/norm([p(4),p(5),p(6)]),[1:size(Point2,1)]);

p= lsqnonlin(F2,[25,2,25,1,1,1]); %初始化迭代
plot3(p(1)+t2*p(4),p(2)+t2*p(5),p(3)+t2*p(6));

grid on;
hold off;