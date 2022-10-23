% 输入五个点的坐标5*2 double array，计算可行步态，并画出运动过程图
% 允许身体发生前后左右的移动，使其完成自由步态

clear;clc;close all
clear global
clear classes
dbstop if error

Gap(1).RectangleInitial = [2000,-1800];
Gap(1).RectangleLengthWidth = [1500,1000];
Gap(1).Height = [0,55];

Gap(2).RectangleInitial = [2500,500];
Gap(2).RectangleLengthWidth = [1300,1300];
Gap(2).Height = [0,40];

InitialData(Gap);
