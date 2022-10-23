% 根据初始位置，生成障碍物
% 输入：初始位置矩阵，输出：障碍物（1*n struct）

function Gap = CreateGap(MatFromTXT)

xq = MatFromTXT(1:4,1); yq = MatFromTXT(1:4,2);
% 障碍物总数是10-30之间
TotalNumber = randi([20 30],1);

Gap = repmat(struct('RectangleInitial',[0 0],'RectangleLengthWidth',[0 0]),1,TotalNumber);

% 一般来说，可以使用公式 r = a + (b-a).*rand(1,N) 生成区间 (a,b) 内的 1*N 个随机数。
i = 1;
while i
    Gap(i).RectangleInitial(1) = -3000 + (4000+3000) * rand(1,1); 
    Gap(i).RectangleInitial(2) = -2000 + (2000+2000) * rand(1,1); 
    Gap(i).RectangleLengthWidth = 1000 * rand(1,2);
    r = -200 + (200+200).*rand; % [-200 200]以内的随机数
    if r > 0
        Gap(i).Height = [0 r];
    else
        Gap(i).Height = [r 0];
    end
    
    A = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) 0];
    B = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2)];
    C = Gap(i).RectangleInitial + [0 Gap(i).RectangleLengthWidth(2)];
    D = Gap(i).RectangleInitial;
    ObsMatrix = [A; B; C; D]; % 障碍物的顶点
    
    in = inpolygon(xq,yq,ObsMatrix(:,1),ObsMatrix(:,2));
    if isempty(find(in == 1, 1))
        % 如果没有在内部的点
        i = i + 1;
        xq = [xq;ObsMatrix(:,1)]; yq = [yq;ObsMatrix(:,2)];
    end
    
    if i > TotalNumber
        break
    end
end


end