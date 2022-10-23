% Author:Fitz
% Date:2022/10
% Butterworth滤波
% 说明：

clc
clear
close all

%% 导入样机测试数据
no_contact_data = load("样机实测数据\202211019_down75_345.txt");
contact_data = load("样机实测数据\202211019_down75_contact_345.txt");
total_time = length(no_contact_data);
% 获取加速度信息
for count = 2 : total_time
    no_contact_data(count,10:12) = (no_contact_data(count,4:6) - no_contact_data(count - 1,4:6)) / 0.001;
    contact_data(count,10:12) = (contact_data(count,4:6) - contact_data(count - 1,4:6)) / 0.001;
end
% 电流信号转化为力矩信号
for count = 1 : total_time
    % 主电机
    no_contact_data(count,7) = no_contact_data(count,7) / 1000 * 8.3;
    % 辅电机
    no_contact_data(count,8:9) = no_contact_data(count,8:9) / 1000 * 300;
    % 主电机
    contact_data(count,7) = contact_data(count,7) / 1000 * 8.3;
    % 辅电机
    contact_data(count,8:9) = contact_data(count,8:9) / 1000 * 300;
end
% 忽略前50ms不稳定数据
ignore_time = 50;

%% Butterworth滤波
% 滤波器参数
fs = 1000;
order = 1;
omega = (10/2/pi)/(fs/2);
x = no_contact_data((ignore_time+1):end,8);
Ts = 1/fs;
N  = total_time - ignore_time;
t = (0:N-1)*Ts;
delta_f = 1*fs/N;
X = fftshift(abs(fft(x)))/N;
X_angle = fftshift(angle(fft(x)));
f = (-N/2:N/2-1)*delta_f;
figure(1);
subplot(3,1,1);
plot(t,x);
title('原信号');
subplot(3,1,2);
plot(f,X);
grid on;
title('原信号频谱幅度特性');
subplot(3,1,3);
plot(f,X_angle);
title('原信号频谱相位特性');
grid on;
%获得转移函数系数
[b,a] = butter(order,omega);
%滤波
filter_lp_s = filter(b,a,x);
X_lp_s = fftshift(abs(fft(filter_lp_s)))/N;
X_lp_s_angle = fftshift(angle(fft(filter_lp_s)));
figure(2);
freqz(b,a); %滤波器频谱特性
figure(3);
subplot(3,1,1);
plot(t,filter_lp_s);
grid on;
title('低通滤波后时域图形');
subplot(3,1,2);
plot(f,X_lp_s);
title('低通滤波后频域幅度特性');
subplot(3,1,3);
plot(f,X_lp_s_angle);
title('低通滤波后频域相位特性');