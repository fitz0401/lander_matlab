% �����ȵĹ����ռ�

function BODY_FOR_CALU = LoadWorkspace(BODY_FOR_CALU)
% load ('E:\2021\���ɼ���\�Գ�Ң\��̬�滮�㷨Դ����\���ɲ�̬\workingarea\map_x.mat');
% load ('E:\2021\���ɼ���\�Գ�Ң\��̬�滮�㷨Դ����\���ɲ�̬\workingarea\map_y.mat');
% load ('E:\2021\���ɼ���\�Գ�Ң\��̬�滮�㷨Դ����\���ɲ�̬\workingarea\map_z_down.mat');
% load ('E:\2021\���ɼ���\�Գ�Ң\��̬�滮�㷨Դ����\���ɲ�̬\workingarea\map_z_up.mat');
% �����ռ������˭�ģ���������ϵ������������ϵ����
% ���ȹ����ռ�ĵ㴢�淽ʽ���������ϵ�������Ƶ���״�Ƿ����Ϊ�����壬������״�����Ƿ��Ӱ���������ʹ�����
path = "/home/abc/lander_control_ws/src/���ɲ�̬ ͨѶ����";
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
BODY_FOR_CALU.Leg(2).zBoundry_down = flipud(map_z_down); % �������µߵ�
BODY_FOR_CALU.Leg(2).zBoundry_up = flipud(map_z_up);

BODY_FOR_CALU.Leg(4).map_x = fliplr(-map_x);
BODY_FOR_CALU.Leg(4).map_y = fliplr(map_y);
BODY_FOR_CALU.Leg(4).zBoundry_down = fliplr(map_z_down); % �������ҵߵ�
BODY_FOR_CALU.Leg(4).zBoundry_up = fliplr(map_z_up);

BODY_FOR_CALU.Leg(3).map_x = fliplr(-BODY_FOR_CALU.Leg(2).map_x);
BODY_FOR_CALU.Leg(3).map_y = fliplr(BODY_FOR_CALU.Leg(2).map_y);
BODY_FOR_CALU.Leg(3).zBoundry_down = fliplr(BODY_FOR_CALU.Leg(2).zBoundry_down); % �������ҵߵ�
BODY_FOR_CALU.Leg(3).zBoundry_up = fliplr(BODY_FOR_CALU.Leg(2).zBoundry_up);

end