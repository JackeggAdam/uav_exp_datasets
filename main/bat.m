%0 导入数据
vins_data = importdata('vins_data/exp10/Loop_path/Loop_path_650.txt');
rtk_data = load('rtk_data/20210721_11_53.mat');

%1 切割rtk轨迹并转换为xyz坐标系
%设定时间段,分割rtk数据
%cutter会将WGS84坐标系转换为xyz坐标系,以轨迹起点为原点
%exp_5 : 0.02,0.121
%exp_6 : 0.14,0.22
%exp_7 : 0.28,0.43
%exp_8 : 0.455,0.56   ||  vins cut: 113:624
%exp_9 : 0.58,0.708   ||  vins cut: 77:701
%exp_10: 0.74,0.979   ||  vins cut: 105:1160
rtk_cut_Start_time = 0.74;
rtk_cut_End_time = 0.979;
[y_rtk,x_rtk,z_rtk] = ...
    rtk_cutter(rtk_cut_Start_time,rtk_cut_End_time,...
    rtk_data.Jul21st20211153AMFlightAirdata);
figure(1);
% plot3(x_rtk(105:400),y_rtk(105:400),z_rtk(105:400)*0);% plot cutted rtk
plot3(x_rtk,y_rtk,z_rtk*0);% plot rtk
hold on;

%2 输入vins轨迹
vins_data = vins_data(105:1160,:)*diag([1,1,0]);%vins cut && flatten
x_vins = vins_data(:,1);
y_vins = vins_data(:,2);
z_vins = vins_data(:,3);
% plot3(x_vins,y_vins,z_vins);% plot vins

%3 固定rtk轨迹,旋转vins轨迹
% %3-0 导入历史拟合数据
vins_bottom_path = vins_fit_data_exp10;
rtk_bottom_path = rtk_fit_data_exp10;
vins_O = vins_O_exp10;
rtk_O = rtk_O_exp10;
vins_bias_exp10 = [1,0.5,0];
vins_bias = vins_bias_exp10;
%3-1 拟合vins底部轨迹
[vins_line,vins_range] = Linear_solver(vins_bottom_path);
vins_line_range = linspace(0,vins_range);
% plot3(vins_line(1)+vins_line_range*vins_line(4),...
%     vins_line(2)+vins_line_range*vins_line(5),...
%     vins_line(3)+vins_line_range*vins_line(6));

%3-2 拟合rtk底部轨迹
[rtk_line,rtk_range] = Linear_solver(rtk_bottom_path);
rtk_line_range = linspace(0,rtk_range);
% plot3(rtk_line(1)+rtk_line_range*rtk_line(4),...
%     rtk_line(2)+rtk_line_range*rtk_line(5),...
%     rtk_line(3)+rtk_line_range*rtk_line(6));

%3-3 计算旋转矩阵
[R_vr,dR] = RotMatrix_solver(vins_line(4:6),rtk_line(4:6));
%3-4 旋转vins轨迹
vins_Rot = vins_data*R_vr*dR^-7*diag([1,1,1]);
x_vins_Rot = vins_Rot(:,1);
y_vins_Rot = vins_Rot(:,2);
z_vins_Rot = vins_Rot(:,3);

%3-5 计算水平偏移
vins_bias_exp5 = [-0.36,0.71,0];%[-0.36,0.71,0];
bias = rtk_O.Position - vins_O.Position + vins_bias;
plot3(x_vins_Rot+bias(1),y_vins_Rot+bias(2),z_vins_Rot+bias(3));

grid on;
hold off;


