gps_rtk = load('gps_rtk/0709last.mat');
[timestamps,x_rtk,y_rtk,z_rtk] = ...
    Coordinates_convertor(gps_rtk.Jul9th20210454PMFlightAirdata);

%time cut: exp_9 : (0.265, 0.346);exp_11 : (0.6, 0.7) 
timestamp_len = size(timestamps,1);
t_start = 0.6;
t_end = 0.7;
t_0 = floor(t_start*timestamp_len);
t_1 = floor(t_end*timestamp_len);

x_cut = x_rtk(t_0+1:t_1);
y_cut = y_rtk(t_0+1:t_1);
z_cut = z_rtk(t_0+1:t_1);

figure(1);
plot3(x_cut,y_cut,z_cut);



