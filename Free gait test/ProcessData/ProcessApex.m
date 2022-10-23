function [apexData,robot] = ProcessApex(table,robot)

% n*18������
apexData = zeros(size(table,1)+1,18); % ��һ���Ǹտ�ʼ�����ݣ���δ�˶�
robot = [robot; zeros(size(table,1),42)];

for i = 1:2:size(table,1)
    % i = 1ʱ�����嶯��6�����ݣ���i = 2ʱ���Ŷ����岻��
    apexData(i+1,1:6) = table{i,3};
    robot(i+1,:) = table{i,1}'; 
    if i < size(table,1)
        robot(i+2,:) = table{i+1,1}';
    end
end
% ֻ�нǶ�(:,4:6)����Եģ������Ķ��Ǿ���ֵ��ֱ�Ӵ�robot�︳ֵ
% xm,ym,zmΪ��������ϵ�ڰ�ɫ�ṹ������G��ԣ���������ϵԭ��O������ֵ��
% theta_G,beta_G,gama_G��Ϊ����ת����ŷ���ǡ�
% ÿ��ʱ�̶���Ҫ����18����ֵ��n��ʱ����Ҫ��n��18�ľ������£�
% [xm,ym,zm,theta_G,beta_G,gama_G,[x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4]]
apexData(:,1:3) = [robot(:,5)+80 robot(:,10) robot(:,15)];
apexData(:,7:18) = [robot(:,1) robot(:,6) robot(:,11)...
    robot(:,2) robot(:,7) robot(:,12)...
    robot(:,3) robot(:,8) robot(:,13)...
    robot(:,4) robot(:,9) robot(:,14)] - ...
    repmat(apexData(:,1:3),1,4);
end