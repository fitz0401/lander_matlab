% ���ݳ�ʼλ�ã������ϰ���
% ���룺��ʼλ�þ���������ϰ��1*n struct��

function Gap = CreateGap(MatFromTXT)

xq = MatFromTXT(1:4,1); yq = MatFromTXT(1:4,2);
% �ϰ���������10-30֮��
TotalNumber = randi([20 30],1);

Gap = repmat(struct('RectangleInitial',[0 0],'RectangleLengthWidth',[0 0]),1,TotalNumber);

% һ����˵������ʹ�ù�ʽ r = a + (b-a).*rand(1,N) �������� (a,b) �ڵ� 1*N ���������
i = 1;
while i
    Gap(i).RectangleInitial(1) = -3000 + (4000+3000) * rand(1,1); 
    Gap(i).RectangleInitial(2) = -2000 + (2000+2000) * rand(1,1); 
    Gap(i).RectangleLengthWidth = 1000 * rand(1,2);
    r = -200 + (200+200).*rand; % [-200 200]���ڵ������
    if r > 0
        Gap(i).Height = [0 r];
    else
        Gap(i).Height = [r 0];
    end
    
    A = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) 0];
    B = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2)];
    C = Gap(i).RectangleInitial + [0 Gap(i).RectangleLengthWidth(2)];
    D = Gap(i).RectangleInitial;
    ObsMatrix = [A; B; C; D]; % �ϰ���Ķ���
    
    in = inpolygon(xq,yq,ObsMatrix(:,1),ObsMatrix(:,2));
    if isempty(find(in == 1, 1))
        % ���û�����ڲ��ĵ�
        i = i + 1;
        xq = [xq;ObsMatrix(:,1)]; yq = [yq;ObsMatrix(:,2)];
    end
    
    if i > TotalNumber
        break
    end
end


end