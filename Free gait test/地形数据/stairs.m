% ��������������5*2 double array��������в�̬���������˶�����ͼ
% �������巢��ǰ�����ҵ��ƶ���ʹ��������ɲ�̬

clear;clc;close all
clear global
clear classes
dbstop if error

for i = 1:5 % ����¥��
    Gap(i).RectangleInitial = [1000*(i-1)+1500, -3000];
    Gap(i).RectangleLengthWidth = [1000 5000];
    Gap(i).Height = [0 50*i];
end

InitialData(Gap);
