% 输入五个点的坐标5*2 double array，计算可行步态，并画出运动过程图
% 允许身体发生前后左右的移动，使其完成自由步态

clear;clc;close all
clear global
clear classes
dbstop if error

fid = fopen('obstacle20.txt'); % 从文件中读取
A = textscan(fid,'[%f,%f]');
for i = 1:length(A{1,1})/3
    Gap(i).RectangleInitial = [A{1,1}(3*i-2) A{1,2}(3*i-2)];
    Gap(i).RectangleLengthWidth = [A{1,1}(3*i-1) A{1,2}(3*i-1)];
    Gap(i).Height = [A{1,1}(3*i) A{1,2}(3*i)];
end
clear fid A

InitialData(Gap);
