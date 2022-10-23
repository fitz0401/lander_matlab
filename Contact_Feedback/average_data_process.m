% Author:Fitz
% Date:2022/10
% 均值滤波
% 数据信息：【位置】【速度】【电流】【加速度】
% 说明：速度均值滤波效果较好；差分加速度噪声仍然非常大，但数值很小初步可以忽略；
%       电流信息均值滤波效果一般，仍有较大波动。

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
    no_contact_data(count,7) = no_contact_data(count,7) * 11.31 / 1000 * 0.95;
    % 辅电机
    no_contact_data(count,8:9) = no_contact_data(count,8:9) * 11.31 / 1000;
    % 主电机
    contact_data(count,7) = contact_data(count,7) * 11.31 / 1000 * 0.95;
    % 辅电机
    contact_data(count,8:9) = contact_data(count,8:9) * 11.31 / 1000;
end
% 忽略前50ms不稳定数据
ignore_time = 50;

%% 均值滤波
window_length = 500;
% 存储数据的滑动窗口
window_no_contact_data = zeros(window_length,9);
window_contact_data = zeros(window_length,9);
% 存储窗口内数据和
sum_no_contact_data = zeros(1,9);
sum_contact_data = zeros(1,9);
% 输出均值滤波结果
average_no_contact_data = zeros(total_time - ignore_time - window_length,9);
average_contact_data = zeros(total_time - ignore_time - window_length,9);
% 模拟实时执行程序
for count = (ignore_time + 1) : total_time
    % 获取当前滑动窗口内位置下标[10,1,2,...,8,9]
    cur_index = mod((count - ignore_time),window_length) + 1;
    % 修改数据和：减去当前位置的旧元素
    sum_no_contact_data = sum_no_contact_data - window_no_contact_data(cur_index,:);
    sum_contact_data = sum_contact_data - window_contact_data(cur_index,:);
    % 更新滑动窗口
    window_no_contact_data(cur_index,:) = no_contact_data(count,4:12);
    window_contact_data(cur_index,:) = contact_data(count,4:12);
    % 修改数据和：加上当前位置的新元素
    sum_no_contact_data = sum_no_contact_data + window_no_contact_data(cur_index,:);
    sum_contact_data = sum_contact_data + window_contact_data(cur_index,:); 
    % count() - ignore_time > window_length时，计算滑动窗口内数据均值
    if (count - ignore_time) > window_length
        average_no_contact_data(count - ignore_time - window_length, :) = sum_no_contact_data / window_length;
        average_contact_data(count - ignore_time - window_length, :) = sum_contact_data / window_length;
    end
end

%% 绘图
t = (ignore_time+window_length+1):total_time;
for fig_index = 1:9
    figure(fig_index)
    subplot(2,1,1)
    plot(t,average_no_contact_data(:,fig_index));
    subplot(2,1,2)
    plot(t,average_contact_data(:,fig_index));
end
