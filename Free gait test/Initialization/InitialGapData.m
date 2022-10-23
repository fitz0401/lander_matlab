% 输入参数，生成对应的障碍物数据
% 'stair' 一阶台阶
% 'read' 从文本中读取
% 'random' 随机生成
% ' '(无输入) 无障碍物
% 'stairs' 三阶楼梯
% 'slope' 斜坡
function gap = InitialGapData(varargin)
% Default input arguments
inArgs = {'clear'};
% Replace default input arguments by input values
inArgs(1:nargin) = varargin;

if strcmp('clear', inArgs{1}) % 无障碍物
    gap(1).RectangleInitial = [0 0]; gap(1).RectangleLengthWidth = [0 0]; gap(1).Height = [0 0];
elseif strcmp('stair', inArgs{1}) % 一阶台阶
        gap(1).RectangleInitial = [750, -3000];
        gap(1).RectangleLengthWidth = [4000 5000];
        gap(1).Height = [0 50];
elseif strcmp('read', inArgs{1}) % 从文件中读取
    fid = fopen('Gap.txt'); 
    A = textscan(fid,'[%f,%f]');
    for i = 1:length(A{1,1})/3
        gap(i).RectangleInitial = [A{1,1}(3*i-2) A{1,2}(3*i-2)];
        gap(i).RectangleLengthWidth = [A{1,1}(3*i-1) A{1,2}(3*i-1)];
        gap(i).Height = [A{1,1}(3*i) A{1,2}(3*i)];
    end
elseif strcmp('random', inArgs{1}) % 随机生成
    gap = CreateGap(MatFromTXT); 
elseif strcmp('stairs', inArgs{1}) % 三阶楼梯
    for i = 1:5
        gap(i).RectangleInitial = [1200*(i-1)+1400, -3000];
        gap(i).RectangleLengthWidth = [1200 5000];
        gap(i).Height = [0 40*i];
    end
elseif strcmp('slope', inArgs{1}) % 斜坡
    warning('500 gaps will be calculated at the same time. Bumpy scrolling probably.');
    for i = 1:500 
        gap(i).RectangleInitial = [10*(i-1)+700, -3000];
        gap(i).RectangleLengthWidth = [10 5000];
    %     Gap(i).Height = [-0.1*i 0];
        gap(i).Height = [0 0.5*i];
    end
else
    error('Do not input correct gap message.');
end

end