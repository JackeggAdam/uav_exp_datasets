path_data_path=importdata('path_data/exp9/path/Path_368.txt');
path_data_loop=importdata('path_data/exp9/Loop_path/Loop_path_132.txt');
rtk_data = load('gps_rtk/0709last.mat');

x = path_data_path(:,1);
y = path_data_path(:,2);
z = path_data_path(:,3);

x_loop = path_data_loop(:,1);
y_loop = path_data_loop(:,2);
z_loop = path_data_loop(:,3);

xp_rang = max(x_loop)-min(x_loop);
yp_rang = max(y_loop)-min(y_loop);
zp_rang = max(z_loop)-min(z_loop);

x_rtk = rtk_data.Jul9th20210454PMFlightAirdata.latitude(2:5159);
y_rtk = rtk_data.Jul9th20210454PMFlightAirdata.longitude(2:5159);
z_rtk = rtk_data.Jul9th20210454PMFlightAirdata.altitude_above_seaLevelmeters(2:5159);

timestamp_len = size(x_rtk,1);
%exp_9 : (0.265, 0.346);exp_11 : (0.6, 0.7) 
t_start = 0.304;
t_end = 0.346;
t_0 = floor(t_start*timestamp_len);
t_1 = floor(t_end*timestamp_len);
disp(size(x_rtk(t_0+1:t_1),1));
x_cut = x_rtk(t_0+1:t_1);
y_cut = y_rtk(t_0+1:t_1);
z_cut = z_rtk(t_0+1:t_1);

x_rang = max(x_cut)-min(x_cut);
y_rang = max(y_cut)-min(y_cut);
z_rang = max(z_cut)-min(z_cut);

x_alpht = xp_rang/x_rang;
y_alpht = yp_rang/y_rang;
z_alpht = zp_rang/z_rang;

x_bias = min(x_cut)*x_alpht-min(x_loop);
y_bias = min(y_cut)*y_alpht-min(y_loop);
z_bias = min(z_cut)*z_alpht-min(z_loop);

% figure(1);
% plot3(x_cut,y_cut,z_cut);
% hold on;
figure(2);
plot3(-(x_cut*x_alpht-x_bias+8),-(y_cut*y_alpht-y_bias+0.22),...
    z_cut*z_alpht-z_bias-0.2);
% plot3(x_cut*x_alpht-x_bias,y_cut*y_alpht-y_bias,...
%     z_cut*z_alpht-z_bias);
hold on;
plot3(x_loop,y_loop,z_loop);


