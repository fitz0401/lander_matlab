% 导入腿的工作空间

function BODY_FOR_CALU = LoadWorkspace(BODY_FOR_CALU)
% load ('E:\2021\集成技术\赵辰尧\步态规划算法源代码\自由步态\workingarea\map_x.mat');
% load ('E:\2021\集成技术\赵辰尧\步态规划算法源代码\自由步态\workingarea\map_y.mat');
% load ('E:\2021\集成技术\赵辰尧\步态规划算法源代码\自由步态\workingarea\map_z_down.mat');
% load ('E:\2021\集成技术\赵辰尧\步态规划算法源代码\自由步态\workingarea\map_z_up.mat');
% 工作空间是相对谁的，机身坐标系还是世界坐标系？？
% 各腿工作空间的点储存方式，相对坐标系？？点云的形状是否必须为长方体，其他形状点云是否会影响后续代码和处理？？
path = "/home/abc/lander_control_ws/src/自由步态 通讯测试";
load (strcat(path,'/workingarea/WS_up.mat'));
load (strcat(path,'/workingarea/WS_down.mat'));
load (strcat(path,'/workingarea/XS.mat'));
load (strcat(path,'/workingarea/YS.mat'));

map_x=XS;
map_y=YS;
map_z_up=WS_up;
map_z_down=WS_down;



BODY_FOR_CALU.Leg(1).map_x = map_x;
BODY_FOR_CALU.Leg(1).map_y = map_y;
BODY_FOR_CALU.Leg(1).zBoundry_down = map_z_down;
BODY_FOR_CALU.Leg(1).zBoundry_up = map_z_up;

BODY_FOR_CALU.Leg(2).map_x = flipud(map_x);
BODY_FOR_CALU.Leg(2).map_y = flipud(-map_y);
BODY_FOR_CALU.Leg(2).zBoundry_down = flipud(map_z_down); % 矩阵上下颠倒
BODY_FOR_CALU.Leg(2).zBoundry_up = flipud(map_z_up);

BODY_FOR_CALU.Leg(4).map_x = fliplr(-map_x);
BODY_FOR_CALU.Leg(4).map_y = fliplr(map_y);
BODY_FOR_CALU.Leg(4).zBoundry_down = fliplr(map_z_down); % 矩阵左右颠倒
BODY_FOR_CALU.Leg(4).zBoundry_up = fliplr(map_z_up);

BODY_FOR_CALU.Leg(3).map_x = fliplr(-BODY_FOR_CALU.Leg(2).map_x);
BODY_FOR_CALU.Leg(3).map_y = fliplr(BODY_FOR_CALU.Leg(2).map_y);
BODY_FOR_CALU.Leg(3).zBoundry_down = fliplr(BODY_FOR_CALU.Leg(2).zBoundry_down); % 矩阵左右颠倒
BODY_FOR_CALU.Leg(3).zBoundry_up = fliplr(BODY_FOR_CALU.Leg(2).zBoundry_up);

end