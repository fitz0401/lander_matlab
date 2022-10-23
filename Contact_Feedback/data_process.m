function [average_vel, average_acc, average_toq, window_vel, window_acc, window_toq, sum_data] = data_process(state_msg, legIndex, window_vel, window_acc, window_toq, sum_data) 
    window_length = 100;
    data_interval =5;
    current_count = state_msg.Header.Seq;
    % 滑动窗口内待更新元素的下标
    current_index = mod(current_count/data_interval, window_length)+1;
    % 滑动窗口内待更新元素和
    sum_data = sum_data - [window_vel(:, current_index); window_acc(:, current_index); window_toq(:, current_index)];
    % 更新滑动窗口：速度信号
    window_vel(1, current_index) = state_msg.Velocity(legIndex*3+1) / 1000;
    window_vel(2, current_index) = state_msg.Velocity(legIndex*3+2);
    window_vel(3, current_index) = -state_msg.Velocity(legIndex*3+3);
    % 更新滑动窗口：力矩信号由电流信号转化而来
    window_toq(1, current_index) = state_msg.Effort(legIndex*3+1) * 11.31 / 1000 * 0.95;
    window_toq(2, current_index) = -state_msg.Effort(legIndex*3+2) * 11.31 / 1000;
    window_toq(3, current_index) = -state_msg.Effort(legIndex*3+3) * 11.31 / 1000;
    
    %% 均值滤波
    sum_data = sum_data + [window_vel(:, current_index); window_acc(:, current_index); window_toq(:, current_index)];    
    average_vel = sum_data(1:3) / window_length;
    average_acc = sum_data(4:6) / window_length;
    average_toq = sum_data(7:9) / window_length;
end