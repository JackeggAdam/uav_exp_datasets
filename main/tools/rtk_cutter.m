function [x_rtk,y_rtk,z_rtk] = ...
    rtk_cutter(Start_time,End_time,FlightAirdata_table)

[timestamps,x_rtk,y_rtk,z_rtk] = ...
    Coordinates_convertor(FlightAirdata_table);

timestamp_len = size(timestamps,1);
t_start = Start_time;
t_end = End_time;
t_0 = floor(t_start*timestamp_len);
t_1 = floor(t_end*timestamp_len);

x_rtk = x_rtk(t_0+1:t_1);
y_rtk = y_rtk(t_0+1:t_1);
z_rtk = z_rtk(t_0+1:t_1);

return



