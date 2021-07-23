
plot3(vins_bottom(:,1),vins_bottom(:,2),vins_bottom(:,3));
hold on;
% plot3(rtk_bottom(:,1),rtk_bottom(:,2),rtk_bottom(:,3));

% vins 

t1=linspace(0,1);%有效范围
F1 = @(p)arrayfun(@(n)...
    norm(cross(vins_bottom(size(vins_bottom,1),:)-[p(1),p(2),p(3)]...
    ,[p(4),p(5),p(6)]))/norm([p(4),p(5),p(6)]),...
    [1:size(vins_bottom,1)]);

vins_len = size(vins_bottom,1);
vins_n = norm(vins_bottom(vins_len,:)-vins_bottom(1,:));
p= lsqnonlin(F1,[vins_bottom(1,1),vins_bottom(1,2),vins_bottom(1,3) ...
    vins_bottom(vins_len,1)-vins_bottom(1,1)/vins_n ...
    vins_bottom(vins_len,2)-vins_bottom(1,2)/vins_n ...
    vins_bottom(vins_len,3)-vins_bottom(1,3)/vins_n]);
plot3(p(1)+t1*p(4),p(2)+t1*p(5),p(3)+t1*p(6));
