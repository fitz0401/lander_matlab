% 输入五个点的坐标5*2 double array，计算可行步态，并画出运动过程图
% 允许身体发生前后左右的移动，使其完成自由步态

clear;clc;close all
clear global
clear classes
dbstop if error

Gap.RectangleInitial = [2000,-1800];
Gap.RectangleLengthWidth = [1500,1000];
Gap.Height = [0,55];

InitialData(Gap);
