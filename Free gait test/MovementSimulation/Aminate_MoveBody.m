% Aminate_MoveBody(TraceForMove,theta):根据给定的步态条件，输出动画
% 输入：FootIndex（迈的脚 double）,step（步长 double）,theta（转动角度 double）
% 无输出，会在屏幕上plot出动画（只走一个周期）
% 本函数开始运行时，BODY_FOR_CALU.Body中储存的已经是迈步结束的机器人状态点，BODY_FOR_MOVE中还储存这迈步开始时的状态点
% function BODY_FOR_CALU=Aminate_MoveBody(FootIndex, BODY_FOR_CALU)
function BODY_FOR_CALU = Aminate_MoveBody(FootIndex, BODY_FOR_CALU,BODY_PARA)
global BODY_FOR_MOVE
%BODY_FOR_MOVE包含参数Foot（4x3）:四足端点位置. BodyApex（4x3） 身体端点位置:
%COG（6x3）：四腿重心位置+身体+总中心？？（待定）. MassRatio（5x1）:四腿和身体的质量占比

deltaCOG = zeros(6,3);
if FootIndex < 5%四腿移动
    %计算得到本次迈步的步长
    step = [BODY_FOR_CALU.Body(FootIndex) BODY_FOR_CALU.Body(FootIndex+5) BODY_FOR_CALU.Body(FootIndex+10)] - BODY_FOR_MOVE.Foot(FootIndex,1:3);
    
    deltaCOG(FootIndex,:) = [BODY_FOR_CALU.Body(FootIndex+27) BODY_FOR_CALU.Body(FootIndex+32) BODY_FOR_CALU.Body(FootIndex+37)] - BODY_FOR_MOVE.COG(FootIndex,:);
    deltaCOG(6,:) = [BODY_FOR_CALU.Body(32) BODY_FOR_CALU.Body(37) BODY_FOR_CALU.Body(42)] - BODY_FOR_MOVE.COG(6,:);
    cyPoint = Cycloid3D(BODY_FOR_MOVE.Foot(FootIndex,1:3),[BODY_FOR_CALU.Body(FootIndex) BODY_FOR_CALU.Body(FootIndex+5) BODY_FOR_CALU.Body(FootIndex+10)],BODY_FOR_CALU.Foot_height,BODY_FOR_CALU.NUM_trace-1);
    TCj_tem=BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,FootIndex);
    cyPoint_tem=inv(TCj_tem)*[cyPoint;ones(1,length(cyPoint(1,:)))];
    cyPoint_tem=cyPoint_tem(1:3,:);
        BODY_FOR_CALU.TraceData((BODY_FOR_CALU.NUM_Step-1)*BODY_FOR_CALU.NUM_trace+1:BODY_FOR_CALU.NUM_Step*BODY_FOR_CALU.NUM_trace,1:12)=repmat(BODY_FOR_CALU.TraceData(end,:),BODY_FOR_CALU.NUM_trace,1);
        BODY_FOR_CALU.TraceData((BODY_FOR_CALU.NUM_Step-1)*BODY_FOR_CALU.NUM_trace+1:BODY_FOR_CALU.NUM_Step*BODY_FOR_CALU.NUM_trace,3*(FootIndex-1)+1:3*FootIndex)=cyPoint_tem';
%     BODY_FOR_CALU.TraceData((BODY_FOR_CALU.NUM_Step+1),1:5)=[2,FootIndex,[BODY_FOR_CALU.Body(FootIndex) BODY_FOR_CALU.Body(FootIndex+5) BODY_FOR_CALU.Body(FootIndex+10)]];
    BODY_FOR_CALU.NUM_Step=BODY_FOR_CALU.NUM_Step+1;
    %增加转换
elseif FootIndex == 5%身体移动
%     rotstep(:,:,1) = BODY_FOR_CALU.TBG*BODY_FOR_CALU.Body_line(:,:,1);
%     rotstep(:,:,2) = BODY_FOR_CALU.TBG*BODY_FOR_CALU.Body_line(:,:,2);
    rotstep = [BODY_FOR_CALU.Body(16:19) BODY_FOR_CALU.Body(20:23) BODY_FOR_CALU.Body(24:27)] - BODY_FOR_MOVE.BodyApex;  %计算身体运动前后的身体点集运动插值
    
    deltaCOG(1:4,:) = [BODY_FOR_CALU.Body(28:31) BODY_FOR_CALU.Body(33:36) BODY_FOR_CALU.Body(38:41)] - BODY_FOR_MOVE.COG(1:4,:);
    deltaCOG(5,:) = [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15)] - BODY_FOR_MOVE.COG(5,:);
    deltaCOG(6,:) = [BODY_FOR_CALU.Body(32) BODY_FOR_CALU.Body(37) BODY_FOR_CALU.Body(42)] - BODY_FOR_MOVE.COG(6,:);
    
    
    %BODY_FOR_CALU.TraceData中储存的都是世界坐标系下的足端数据，并且没有储存机身运动时的变化，这里在机身运动时，使用T的插值
end

times = 0; % Aminate_ShowBody的调用次数。一个周期times = 1-30（身体走6段的情况下）

% time_gap = 0.2; % 这个数字不要随便改，因为牵扯到NURBS的取值点
time_gap = 1/BODY_FOR_CALU.NUM_trace; % 这个数字不要随便改，因为牵扯到NURBS的取值点
for time = 1:1/time_gap % 每次走time_gap * step，一共走1/time_gap次
    if FootIndex < 5
        %这里对迈步的起点和终点进行线性插值，方便动画呈现
        %         BODY_FOR_MOVE.Foot(FootIndex,1) = BODY_FOR_MOVE.Foot(FootIndex,1) + time_gap * step(1);
        %         BODY_FOR_MOVE.Foot(FootIndex,2) = BODY_FOR_MOVE.Foot(FootIndex,2) + time_gap * step(2);
        %         BODY_FOR_MOVE.Foot(FootIndex,3) = BODY_FOR_MOVE.Foot(FootIndex,3) + time_gap * step(3);
        BODY_FOR_MOVE.PreStep(FootIndex,1)= BODY_FOR_MOVE.Foot(FootIndex,1);
        BODY_FOR_MOVE.PreStep(FootIndex,2)= BODY_FOR_MOVE.Foot(FootIndex,2);
        BODY_FOR_MOVE.PreStep(FootIndex,3)= BODY_FOR_MOVE.Foot(FootIndex,3);
        BODY_FOR_MOVE.Foot(FootIndex,1) = cyPoint(1,time);
        BODY_FOR_MOVE.Foot(FootIndex,2) = cyPoint(2,time);
        BODY_FOR_MOVE.Foot(FootIndex,3) =  cyPoint(3,time);
        
        for k=1:4
            BODY_FOR_MOVE.TCjG(:,:,k)=BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,k);
            WS_Data(:,:,k)=BODY_FOR_CALU.TBG*BODY_FOR_CALU.WS_Data(:,:,k);
        end
        
    elseif FootIndex == 5
        BODY_FOR_MOVE.BodyApex = BODY_FOR_MOVE.BodyApex + time_gap * rotstep;
        T=TBG_Interpolation(BODY_FOR_MOVE.TBG,BODY_FOR_CALU.TBG,time,time_gap);       
        Body_line_G(:,:,1)=T*BODY_FOR_MOVE.Body_line(:,:,1);
        Body_line_G(:,:,2)=T*BODY_FOR_MOVE.Body_line(:,:,2);
        BODY_FOR_MOVE.BodyApex2(:,:,1) = [[Body_line_G(1,1,1);Body_line_G(1,2,1)],[Body_line_G(1,2,1);Body_line_G(1,3,1)],[Body_line_G(1,3,1);Body_line_G(1,4,1)],...
            [Body_line_G(1,4,1);Body_line_G(1,5,1)],[Body_line_G(1,5,1);Body_line_G(1,6,1)],[Body_line_G(1,6,1);Body_line_G(1,7,1)],...
            [Body_line_G(1,7,1);Body_line_G(1,8,1)],[Body_line_G(1,8,1);Body_line_G(1,1,1)],...
            [Body_line_G(1,1,2);Body_line_G(1,2,2)],[Body_line_G(1,2,2);Body_line_G(1,3,2)],[Body_line_G(1,3,2);Body_line_G(1,4,2)],...
            [Body_line_G(1,4,2);Body_line_G(1,5,2)],[Body_line_G(1,5,2);Body_line_G(1,6,2)],[Body_line_G(1,6,2);Body_line_G(1,7,2)],...
            [Body_line_G(1,7,2);Body_line_G(1,8,2)],[Body_line_G(1,8,2);Body_line_G(1,1,2)],...
            [Body_line_G(1,1,1);Body_line_G(1,1,2)],[Body_line_G(1,2,1);Body_line_G(1,2,2)],[Body_line_G(1,3,1);Body_line_G(1,3,2)],...
            [Body_line_G(1,4,1);Body_line_G(1,4,2)],[Body_line_G(1,5,1);Body_line_G(1,5,2)],[Body_line_G(1,6,1);Body_line_G(1,6,2)],...
            [Body_line_G(1,7,1);Body_line_G(1,7,2)],[Body_line_G(1,8,1);Body_line_G(1,8,2)]];
        BODY_FOR_MOVE.BodyApex2(:,:,2) = [[Body_line_G(2,1,1);Body_line_G(2,2,1)],[Body_line_G(2,2,1);Body_line_G(2,3,1)],[Body_line_G(2,3,1);Body_line_G(2,4,1)],...
            [Body_line_G(2,4,1);Body_line_G(2,5,1)],[Body_line_G(2,5,1);Body_line_G(2,6,1)],[Body_line_G(2,6,1);Body_line_G(2,7,1)],...
            [Body_line_G(2,7,1);Body_line_G(2,8,1)],[Body_line_G(2,8,1);Body_line_G(2,1,1)],...
            [Body_line_G(2,1,2);Body_line_G(2,2,2)],[Body_line_G(2,2,2);Body_line_G(2,3,2)],[Body_line_G(2,3,2);Body_line_G(2,4,2)],...
            [Body_line_G(2,4,2);Body_line_G(2,5,2)],[Body_line_G(2,5,2);Body_line_G(2,6,2)],[Body_line_G(2,6,2);Body_line_G(2,7,2)],...
            [Body_line_G(2,7,2);Body_line_G(2,8,2)],[Body_line_G(2,8,2);Body_line_G(2,1,2)],...
            [Body_line_G(2,1,1);Body_line_G(2,1,2)],[Body_line_G(2,2,1);Body_line_G(2,2,2)],[Body_line_G(2,3,1);Body_line_G(2,3,2)],...
            [Body_line_G(2,4,1);Body_line_G(2,4,2)],[Body_line_G(2,5,1);Body_line_G(2,5,2)],[Body_line_G(2,6,1);Body_line_G(2,6,2)],...
            [Body_line_G(2,7,1);Body_line_G(2,7,2)],[Body_line_G(2,8,1);Body_line_G(2,8,2)]];
        BODY_FOR_MOVE.BodyApex2(:,:,3) = [[Body_line_G(3,1,1);Body_line_G(3,2,1)],[Body_line_G(3,2,1);Body_line_G(3,3,1)],[Body_line_G(3,3,1);Body_line_G(3,4,1)],...
            [Body_line_G(3,4,1);Body_line_G(3,5,1)],[Body_line_G(3,5,1);Body_line_G(3,6,1)],[Body_line_G(3,6,1);Body_line_G(3,7,1)],...
            [Body_line_G(3,7,1);Body_line_G(3,8,1)],[Body_line_G(3,8,1);Body_line_G(3,1,1)],...
            [Body_line_G(3,1,2);Body_line_G(3,2,2)],[Body_line_G(3,2,2);Body_line_G(3,3,2)],[Body_line_G(3,3,2);Body_line_G(3,4,2)],...
            [Body_line_G(3,4,2);Body_line_G(3,5,2)],[Body_line_G(3,5,2);Body_line_G(3,6,2)],[Body_line_G(3,6,2);Body_line_G(3,7,2)],...
            [Body_line_G(3,7,2);Body_line_G(3,8,2)],[Body_line_G(3,8,2);Body_line_G(3,1,2)],...
            [Body_line_G(3,1,1);Body_line_G(3,1,2)],[Body_line_G(3,2,1);Body_line_G(3,2,2)],[Body_line_G(3,3,1);Body_line_G(3,3,2)],...
            [Body_line_G(3,4,1);Body_line_G(3,4,2)],[Body_line_G(3,5,1);Body_line_G(3,5,2)],[Body_line_G(3,6,1);Body_line_G(3,6,2)],...
            [Body_line_G(3,7,1);Body_line_G(3,7,2)],[Body_line_G(3,8,1);Body_line_G(3,8,2)]];
        %身体运动和不动时，导入的TCjG应该不同
        for k=1:4
            BODY_FOR_MOVE.TCjG(:,:,k)=T*BODY_FOR_CALU.TCB(:,:,k);
              WS_Data(:,:,k)=T*BODY_FOR_CALU.WS_Data(:,:,k);
              Foot_tem=BODY_FOR_MOVE.Foot(k,:);
              Foot_tem=inv(BODY_FOR_MOVE.TCjG(:,:,k))*[Foot_tem.';1];
              BODY_FOR_CALU.TraceData((BODY_FOR_CALU.NUM_Step-1)*BODY_FOR_CALU.NUM_trace+time,3*(k-1)+1:3*k)= reshape(Foot_tem(1:3),[1,3]);
              %身体运动时四足的数据，根据坐标系把 BODY_FOR_MOVE.Foot 变换并储存
        end
    else
        error('Error. Input of ami_Move must be foot character.');
    end
    % 身体矩形和脚末端已经动了，也已经计算了腿的重心，还需要计算总重心
    BODY_FOR_MOVE.COG = BODY_FOR_MOVE.COG + time_gap * deltaCOG;
    % 计算得到总重心后，可视化出来

    times = Aminate_ShowBody(FootIndex,times,BODY_PARA,WS_Data);
    
    
    pause(0.01); % 不用在子函数里等待，在这里统一暂停即可
end
if FootIndex==5
    BODY_FOR_CALU.NUM_Step=BODY_FOR_CALU.NUM_Step+1;
end
BODY_FOR_MOVE.TBG=BODY_FOR_CALU.TBG;
end
