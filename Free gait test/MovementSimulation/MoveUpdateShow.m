% MoveUpdateShow：Move身体 & Update工作空间 & Show
% 输入：Foot_index（走哪一步 double）1-4表示腿号，5表示身体  , Step（走的步长 1*2 double）

function BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, Foot_index, Step, BODY_PARA)

bodytemp = BODY_FOR_CALU;
%用类内置的move函数实现机器人的运动，即对身体和足端存储点的移动和质心的移动以及总质心的重新计算
BODY_FOR_CALU = BODY_FOR_CALU.Move(Foot_index, Step(1), Step(2), Step(3)); % 5 代表身体
if Foot_index == 5
    BODY_FOR_CALU.RotateAngle = Step(4:6);
    BODY_FOR_CALU = BODY_FOR_CALU.Rotate(Step(4), Step(5), Step(6));
    
    %机身运动时TBG此处进行调整,这里BODY_FOR_CALU.RotateAngle中储存的欧拉角表示的是此时机身的姿态角
    TBG_tem=[eul2rotm(BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX'),BODY_FOR_CALU.TBG(1:3,4);0 0 0 1];
    BODY_FOR_CALU.TBG=[eye(3),[Step(1);Step(2);Step(3)];0 0 0 1] * TBG_tem;   
%     BODY_FOR_CALU.TBG=[eul2rotm(BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX'),[Step(1);Step(2);Step(3)];0 0 0 1] * BODY_FOR_CALU.TBG;        
end

if Foot_index == 5
    iVector = 1:4;
else
    iVector = Foot_index;
end

%这里第一步运动的时候，为什么腿1有一个沿Y正方向的小运动？？？
for i = iVector
    % 身体顶点的偏移量，相当于脚向相反的方向运动
    deltaX = (BODY_FOR_CALU.Body(i)-BODY_FOR_CALU.Body(15+i)) - (bodytemp.Body(i)-bodytemp.Body(15+i));
    deltaY = (BODY_FOR_CALU.Body(5+i)-BODY_FOR_CALU.Body(19+i)) - (bodytemp.Body(5+i)-bodytemp.Body(19+i));
    deltaZ = (BODY_FOR_CALU.Body(10+i)-BODY_FOR_CALU.Body(23+i)) - (bodytemp.Body(10+i)-bodytemp.Body(23+i));
    delta = [deltaX; deltaY; deltaZ];
    delta = eul2rotm(-BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX') * delta;
    
    delta(1) = round(delta(1) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
    delta(2) = round(delta(2) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % 向6.25（工作空间精度）取整，保证能整除6.25
    
    %这里当身体移动时，需要给四腿加上相反的运动，且相对的工作空间要做对应平移
    %为什么腿运动时工作空间也要运动，如果这样说明map_x的原点表示足端点，在导入工作空间的时候应该注意？？？？
    BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x - delta(1);
    BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y - delta(2);
    BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down - delta(3);
    BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up - delta(3);

    BODY_FOR_CALU.interSpace(i,:) = BODY_FOR_CALU.interSpace(i,:) + [delta(1) delta(2)];%工作空间坐标系做对应平移
end
%{
if Foot_index == 5
    for i = 1:4
        % 身体顶点的偏移量，相当于脚向相反的方向运动
        deltaX = (BODY_FOR_CALU.Body(i)-BODY_FOR_CALU.Body(15+i)) - (bodytemp.Body(i)-bodytemp.Body(15+i));
        deltaY = (BODY_FOR_CALU.Body(5+i)-BODY_FOR_CALU.Body(19+i)) - (bodytemp.Body(5+i)-bodytemp.Body(19+i));
        deltaZ = (BODY_FOR_CALU.Body(10+i)-BODY_FOR_CALU.Body(23+i)) - (bodytemp.Body(10+i)-bodytemp.Body(23+i));
        delta = [deltaX; deltaY; deltaZ];
        delta = eul2rotm(-BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX') * delta;
        
        delta(1) = round(delta(1) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
        delta(2) = round(delta(2) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % 向6.25（工作空间精度）取整，保证能整除6.25
        
        BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x - delta(1);
        BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y - delta(2);
        BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down - delta(3);
        BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up - delta(3);
        
        BODY_FOR_CALU.interSpace(i,:) = BODY_FOR_CALU.interSpace(i,:) + [delta(1) delta(2)];
    end
else
    % 身体顶点的偏移量，相当于脚向相反的方向运动
    deltaX = (BODY_FOR_CALU.Body(Foot_index)-BODY_FOR_CALU.Body(15+Foot_index)) - (bodytemp.Body(Foot_index)-bodytemp.Body(15+Foot_index));
    deltaY = (BODY_FOR_CALU.Body(5+Foot_index)-BODY_FOR_CALU.Body(19+Foot_index)) - (bodytemp.Body(5+Foot_index)-bodytemp.Body(19+Foot_index));
    deltaZ = (BODY_FOR_CALU.Body(10+Foot_index)-BODY_FOR_CALU.Body(23+Foot_index)) - (bodytemp.Body(10+Foot_index)-bodytemp.Body(23+Foot_index));
    delta = [deltaX; deltaY; deltaZ];
    delta = eul2rotm(-BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX') * delta;
    
    delta(1) = round(delta(1) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
    delta(2) = round(delta(2) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % 向6.25（工作空间精度）取整，保证能整除6.25
    
    BODY_FOR_CALU.Leg(Foot_index).map_x = BODY_FOR_CALU.Leg(Foot_index).map_x - delta(1);
    BODY_FOR_CALU.Leg(Foot_index).map_y = BODY_FOR_CALU.Leg(Foot_index).map_y - delta(2);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_down = BODY_FOR_CALU.Leg(Foot_index).zBoundry_down - delta(3);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_up = BODY_FOR_CALU.Leg(Foot_index).zBoundry_up - delta(3);
    
    BODY_FOR_CALU.interSpace(Foot_index,:) = BODY_FOR_CALU.interSpace(Foot_index,:) + [delta(1) delta(2)];
end
%}
TEMP = Aminate_MoveBody(Foot_index, BODY_FOR_CALU,BODY_PARA);
BODY_FOR_CALU=TEMP;
end
%{
% MoveUpdateShow：Move身体 & Update工作空间 & Show
% 输入：Foot_index（走哪一步 double）, Step（走的步长 1*2 double）

function BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, Foot_index, Step)

BODY_FOR_CALU = BODY_FOR_CALU.Move(Foot_index, Step(1), Step(2), Step(3)); % 5 代表身体

if Foot_index == 5
    % 如果身体动
    % 局部坐标系的大小相应的也要变
    for i = 1:4
        BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x + Step(1);
        BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y + Step(2);
        BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down + Step(3);
        BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up + Step(3);
        
        BODY_FOR_CALU.interSpace(i,:) = BODY_FOR_CALU.interSpace(i,:) - Step(1:2);
    end
else % Foot_index = 1-4
    % 如果脚动
    BODY_FOR_CALU.Leg(Foot_index).map_x = BODY_FOR_CALU.Leg(Foot_index).map_x - Step(1);
    BODY_FOR_CALU.Leg(Foot_index).map_y = BODY_FOR_CALU.Leg(Foot_index).map_y - Step(2);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_down = BODY_FOR_CALU.Leg(Foot_index).zBoundry_down - Step(3);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_up = BODY_FOR_CALU.Leg(Foot_index).zBoundry_up - Step(3);
    
    BODY_FOR_CALU.interSpace(Foot_index,:) = BODY_FOR_CALU.interSpace(Foot_index,:) + Step(1:2);
end

if length(Step) == 6
%     BODY_FOR_CALU.RotateAngle = BODY_FOR_CALU.RotateAngle + [Step(4), Step(5), Step(6)];
    BODY_FOR_CALU.RotateAngle = Step(4:6);
    % 旋转身体并改变每一只脚在工作空间中的位置
    bodytemp = BODY_FOR_CALU;
    BODY_FOR_CALU = BODY_FOR_CALU.Rotate(Step(4), Step(5), Step(6));
    for i = 1:4
        % 身体顶点的偏移量，相当于脚向相反的方向运动
        deltaX = BODY_FOR_CALU.Body(15+i) - bodytemp.Body(15+i);
        deltaY = BODY_FOR_CALU.Body(19+i) - bodytemp.Body(19+i);
        deltaZ = BODY_FOR_CALU.Body(23+i) - bodytemp.Body(23+i);
        
        deltaX = round(deltaX / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
        deltaY = round(deltaY / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % 向6.25（工作空间精度）取整，保证能整除6.25
        
        BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x + deltaX;
        BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y + deltaY;
        BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down + deltaZ;
        BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up + deltaZ;
    end
end

% BODY_FOR_CALU.Body0 = BODY_FOR_CALU.Body;

Aminate_MoveBody(Foot_index, BODY_FOR_CALU);

end
%}