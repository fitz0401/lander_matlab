% �����ܵĹ����ռ䣬�ҵ����и����ȵ�����λ�ã����жϳ��ڹ��������ռ��У���ֻ�ŵ��˶�ѧԣ����С
function index = getKMIntersection(BODY_FOR_CALU)
KM = zeros(4,1);
for i = 1:4
    % ��map_yΪ0ʱ��x����Сֵ
    KM(i) = min(BODY_FOR_CALU.interSpace(i).map_x(BODY_FOR_CALU.interSpace(i).map_y == 0));
end
[~,index] = min(abs(KM));

%{
% �ҵ����������ռ�
Bit_map_legs = getLegArea(BODY_FOR_CALU, step_x, step_y);
Bit_map_body = getBodyArea(BODY_FOR_CALU, step_x, step_y);
% Bit_map_legs���������ܹ����ռ��µ�����
% Bit_map_body�����������ռ����ܹ����ռ��µ�����
for i = 1:4
    KMLegx = nan(length(step_y), length(step_x)); KMLegy = KMLegx;
    KMLegx(Bit_map_legs(i,:,:)) = BODY_FOR_CALU.Leg(i).map_x;
    KMLegy(Bit_map_legs(i,:,:)) = BODY_FOR_CALU.Leg(i).map_y;
    KMLegx(~Bit_map_body) = nan;
    % ��map_yΪ0ʱ��x����Сֵ
    KM(i) = min(KMLegx(KMLegy == min(abs(KMLegy))));
end
[~,index] = min(KM);
%}
end