function traceData = ProcessTrace(table,robot)

traceData = zeros(size(table,1)+1,13); % Ϊ�˻��켣��������

traceData(1,1:12) = [robot(1) robot(6) robot(11) robot(2) robot(7) robot(12) ...
    robot(3) robot(8) robot(13) robot(4) robot(9) robot(14)];
for i = 1:size(table,1)
    % i = 1ʱ�����嶯��6�����ݣ���i = 2ʱ���Ŷ����岻��
    body = table{i,1}';
    traceData(i+1,1:12) = [body(1) body(6) body(11) body(2) body(7) body(12) ...
        body(3) body(8) body(13) body(4) body(9) body(14)];
end
traceData(:,13) = [cell2mat(table(:,2)); nan];
end