%0 导入数据
vins_data = importdata('path_data/exp13/Loop_path/Loop_path_371.txt');
rtk_data = load('gps_rtk/0709last.mat');
%1 切割rtk轨迹并转换为xyz坐标系
%设定时间段,分割rtk数据
%cutter会将WGS84坐标系转换为xyz坐标系,以轨迹起点为原点
%exp_9  : (0.265, 0.346)
%exp_11 : (0.6, 0.7) 
%exp_13 : (0.775, 0.92)
rtk_cut_Start_time = 0.775;
rtk_cut_End_time = 0.92;
[y_rtk,x_rtk,z_rtk] = ...
    rtk_cutter(rtk_cut_Start_time,rtk_cut_End_time,...
    rtk_data.Jul9th20210454PMFlightAirdata);
z_rtk = z_rtk * 0;
figure(1);
plot3(x_rtk,y_rtk,z_rtk);
hold on;
%2 输入vins轨迹
x_vins = vins_data(400:700,1);
y_vins = vins_data(400:700,2);
z_vins = vins_data(400:700,3) * 0;
% plot3(x_vins,y_vins,z_vins);

%3 固定rtk轨迹,旋转vins轨迹
%3-0 导入历史拟合数据
vins_bottom_path = vins_fit_data_exp13;
rtk_bottom_path = rtk_fit_data_exp13;
vins_O = vins_O_exp13;
rtk_O = rtk_O_exp13;
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
R_vr = RotMatrix_solver(vins_line(4:6),rtk_line(4:6));
%3-4 旋转vins轨迹
vins_Rot = vins_data*R_vr*diag([1,1,1]);
x_vins_Rot = vins_Rot(:,1);
y_vins_Rot = vins_Rot(:,2);
z_vins_Rot = vins_Rot(:,3)*0;
%3-5 计算水平偏移
vins_bias_exp13 = [1.9,-2.6,0];
bias = rtk_O.Position - vins_O.Position + vins_bias_exp13;
plot3(x_vins_Rot+bias(1),y_vins_Rot+bias(2),z_vins_Rot+bias(3));

grid on;
hold off;


