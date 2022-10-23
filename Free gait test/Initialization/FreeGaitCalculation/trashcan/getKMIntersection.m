% 现有总的工作空间，找到其中各个腿的所在位置，并判断出在公共工作空间中，哪只脚的运动学裕度最小
function index = getKMIntersection(BODY_FOR_CALU)
KM = zeros(4,1);
for i = 1:4
    % 找map_y为0时，x的最小值
    KM(i) = min(BODY_FOR_CALU.interSpace(i).map_x(BODY_FOR_CALU.interSpace(i).map_y == 0));
end
[~,index] = min(abs(KM));

%{
% 找到公共工作空间
Bit_map_legs = getLegArea(BODY_FOR_CALU, step_x, step_y);
Bit_map_body = getBodyArea(BODY_FOR_CALU, step_x, step_y);
% Bit_map_legs：四腿在总工作空间下的区域
% Bit_map_body：公共工作空间在总工作空间下的区域
for i = 1:4
    KMLegx = nan(length(step_y), length(step_x)); KMLegy = KMLegx;
    KMLegx(Bit_map_legs(i,:,:)) = BODY_FOR_CALU.Leg(i).map_x;
    KMLegy(Bit_map_legs(i,:,:)) = BODY_FOR_CALU.Leg(i).map_y;
    KMLegx(~Bit_map_body) = nan;
    % 找map_y为0时，x的最小值
    KM(i) = min(KMLegx(KMLegy == min(abs(KMLegy))));
end
[~,index] = min(KM);
%}
end