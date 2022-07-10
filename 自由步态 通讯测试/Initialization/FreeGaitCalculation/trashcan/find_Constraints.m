function [A, b, Incentre] = find_Constraints(BODY_temp, index)

% [x1 y1] * [k1] = [-1]
% [x2 y2]   [k2]   [-1] 求解直线的两个系数 k1x+k2y+10000=0 且要求k2必须为正数
x1 = BODY_temp.Body(1); y1 = BODY_temp.Body(6);
x2 = BODY_temp.Body(2); y2 = BODY_temp.Body(7);
x3 = BODY_temp.Body(3); y3 = BODY_temp.Body(8);
x4 = BODY_temp.Body(4); y4 = BODY_temp.Body(9);

switch index
    case 1
        k(1,:) = [x2,y2;x4,y4]\[-10000;-10000]; % k = [k1;k2]，2、4直线的两个系数
        if k(1,2) < 0
            k = -k;
            A = -k;
            b = -norm(k(1,:)) * BODY_temp.SM - 10000;
        else
            A = -k;
            b = -norm(k(1,:)) * BODY_temp.SM + 10000;
        end
        
        
        % 找三角形内心
        Incentre = find_Incentre([x2,y2],[x3,y3],[x4,y4]);
    case 2
        k(1,:) = [x1,y1;x3,y3]\[-10000;-10000]; % k = [k1;k2]，1、3直线的两个系数
        if k(1,2) < 0
            k = -k;
            A = k;
            b = -norm(k(1,:)) * BODY_temp.SM + 10000;
        else
            A = k;
            b = -norm(k(1,:)) * BODY_temp.SM - 10000;
        end
        
        Incentre = find_Incentre([x1,y1],[x3,y3],[x4,y4]);
    case 3
        k(1,:) = [x2,y2;x4,y4]\[-10000;-10000]; % k = [k1;k2]，2、4直线的两个系数
        if k(1,2) < 0
            k = -k;
            A = k;
            b = -norm(k(1,:)) * BODY_temp.SM + 10000;
        else
            A = k;
            b = -norm(k(1,:)) * BODY_temp.SM - 10000;
        end
        
        Incentre = find_Incentre([x1,y1],[x2,y2],[x4,y4]);
    case 4
        k(1,:) = [x1,y1;x3,y3]\[-10000;-10000]; % k = [k1;k2]，1、3直线的两个系数
        if k(1,2) < 0
            k = -k;
            A = -k;
            b = -norm(k(1,:)) * BODY_temp.SM - 10000;
        else
            A = -k;
            b = -norm(k(1,:)) * BODY_temp.SM + 10000;
        end
        
        Incentre = find_Incentre([x1,y1],[x2,y2],[x3,y3]);
    otherwise
        error("Wrong number in index.");
end


end