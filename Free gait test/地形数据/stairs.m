% 输入五个点的坐标5*2 double array，计算可行步态，并画出运动过程图
% 允许身体发生前后左右的移动，使其完成自由步态

clear;clc;close all
clear global
clear classes
dbstop if error

for i = 1:5 % 三阶楼梯
    Gap(i).RectangleInitial = [1000*(i-1)+1500, -3000];
    Gap(i).RectangleLengthWidth = [1000 5000];
    Gap(i).Height = [0 50*i];
end

InitialData(Gap);
