function [timestamps,x_rtk,y_rtk,z_rtk]=Coordinates_convertor(FlightAirdata_table)
format long;
%data import
data_lat = FlightAirdata_table.latitude(2:5159);
data_lon = FlightAirdata_table.longitude(2:5159);
data_alt = FlightAirdata_table.altitude_above_seaLevelmeters(2:5159);
data_size = size(data_lat,1);
%parametor
Ea = 6378137.0;%长半轴
Eb = 6356752.3;%短半轴
f = (Ea-Eb)/Ea;%扁率
%设轨迹起点为原点
O_lat = data_lat(1)*pi/180;
O_lon = data_lon(1)*pi/180;
O_alt = data_alt(1);

% M_lat = data_lat(:);
% M_lon = data_lon(:);
% M_alt = data_alt(:);
M_lat = data_lat(:)*pi/180;
M_lon = data_lon(:)*pi/180;
M_alt = data_alt(:);


x_o2m = zeros(data_size,1);
y_o2m = zeros(data_size,1);
z_o2m = zeros(data_size,1);
for i = 2:data_size
    R_M = Ea*(1-f*(sin(M_lat(i)))^2)+M_alt(i);
    x_o2m(i) = (M_lat(i) - O_lat)*R_M;
    y_o2m(i) = (M_lon(i) - O_lon)*R_M*cos(M_lat(i));
    z_o2m(i) = M_alt(i) - O_alt;
    disp([x_o2m(i),y_o2m(i),z_o2m(i)]);
end
% for i = 2:data_size
%     R_M = Ea*(1-f*(sin(M_lat(i)))^2)+M_alt(i);
%     x_o2m(i) = (M_lat(i) - O_lat)*R_M;
%     y_o2m(i) = (M_lon(i) - O_lon)*R_M*cos(M_lat(i));
%     z_o2m(i) = M_alt(i) - O_alt;
%     disp([x_o2m(i),y_o2m(i),z_o2m(i)]);
% end
timestamps = FlightAirdata_table.timemillisecond(2:5159);
x_rtk = x_o2m;
y_rtk = y_o2m;
z_rtk = z_o2m;
return;






