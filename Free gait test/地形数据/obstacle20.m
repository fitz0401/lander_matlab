% ��������������5*2 double array��������в�̬���������˶�����ͼ
% �������巢��ǰ�����ҵ��ƶ���ʹ��������ɲ�̬

clear;clc;close all
clear global
clear classes
dbstop if error

fid = fopen('obstacle20.txt'); % ���ļ��ж�ȡ
A = textscan(fid,'[%f,%f]');
for i = 1:length(A{1,1})/3
    Gap(i).RectangleInitial = [A{1,1}(3*i-2) A{1,2}(3*i-2)];
    Gap(i).RectangleLengthWidth = [A{1,1}(3*i-1) A{1,2}(3*i-1)];
    Gap(i).Height = [A{1,1}(3*i) A{1,2}(3*i)];
end
clear fid A

InitialData(Gap);
