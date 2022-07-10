% ������������ɶ�Ӧ���ϰ�������
% 'stair' һ��̨��
% 'read' ���ı��ж�ȡ
% 'random' �������
% ' '(������) ���ϰ���
% 'stairs' ����¥��
% 'slope' б��
function gap = InitialGapData(varargin)
% Default input arguments
inArgs = {'clear'};
% Replace default input arguments by input values
inArgs(1:nargin) = varargin;

if strcmp('clear', inArgs{1}) % ���ϰ���
    gap(1).RectangleInitial = [0 0]; gap(1).RectangleLengthWidth = [0 0]; gap(1).Height = [0 0];
elseif strcmp('stair', inArgs{1}) % һ��̨��
        gap(1).RectangleInitial = [750, -3000];
        gap(1).RectangleLengthWidth = [4000 5000];
        gap(1).Height = [0 50];
elseif strcmp('read', inArgs{1}) % ���ļ��ж�ȡ
    fid = fopen('Gap.txt'); 
    A = textscan(fid,'[%f,%f]');
    for i = 1:length(A{1,1})/3
        gap(i).RectangleInitial = [A{1,1}(3*i-2) A{1,2}(3*i-2)];
        gap(i).RectangleLengthWidth = [A{1,1}(3*i-1) A{1,2}(3*i-1)];
        gap(i).Height = [A{1,1}(3*i) A{1,2}(3*i)];
    end
elseif strcmp('random', inArgs{1}) % �������
    gap = CreateGap(MatFromTXT); 
elseif strcmp('stairs', inArgs{1}) % ����¥��
    for i = 1:5
        gap(i).RectangleInitial = [1200*(i-1)+1400, -3000];
        gap(i).RectangleLengthWidth = [1200 5000];
        gap(i).Height = [0 40*i];
    end
elseif strcmp('slope', inArgs{1}) % б��
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