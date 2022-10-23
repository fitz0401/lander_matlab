% Aminate_MoveBody(TraceForMove,theta):���ݸ����Ĳ�̬�������������
% ���룺FootIndex�����Ľ� double��,step������ double��,theta��ת���Ƕ� double��
% �������������Ļ��plot��������ֻ��һ�����ڣ�
% ��������ʼ����ʱ��BODY_FOR_CALU.Body�д�����Ѿ������������Ļ�����״̬�㣬BODY_FOR_MOVE�л�������������ʼʱ��״̬��
% function BODY_FOR_CALU=Aminate_MoveBody(FootIndex, BODY_FOR_CALU)
function BODY_FOR_CALU = Aminate_MoveBody(FootIndex, BODY_FOR_CALU,BODY_PARA)
global BODY_FOR_MOVE
%BODY_FOR_MOVE��������Foot��4x3��:����˵�λ��. BodyApex��4x3�� ����˵�λ��:
%COG��6x3������������λ��+����+�����ģ�����������. MassRatio��5x1��:���Ⱥ����������ռ��

deltaCOG = zeros(6,3);
if FootIndex < 5%�����ƶ�
    %����õ����������Ĳ���
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
    %����ת��
elseif FootIndex == 5%�����ƶ�
%     rotstep(:,:,1) = BODY_FOR_CALU.TBG*BODY_FOR_CALU.Body_line(:,:,1);
%     rotstep(:,:,2) = BODY_FOR_CALU.TBG*BODY_FOR_CALU.Body_line(:,:,2);
    rotstep = [BODY_FOR_CALU.Body(16:19) BODY_FOR_CALU.Body(20:23) BODY_FOR_CALU.Body(24:27)] - BODY_FOR_MOVE.BodyApex;  %���������˶�ǰ�������㼯�˶���ֵ
    
    deltaCOG(1:4,:) = [BODY_FOR_CALU.Body(28:31) BODY_FOR_CALU.Body(33:36) BODY_FOR_CALU.Body(38:41)] - BODY_FOR_MOVE.COG(1:4,:);
    deltaCOG(5,:) = [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15)] - BODY_FOR_MOVE.COG(5,:);
    deltaCOG(6,:) = [BODY_FOR_CALU.Body(32) BODY_FOR_CALU.Body(37) BODY_FOR_CALU.Body(42)] - BODY_FOR_MOVE.COG(6,:);
    
    
    %BODY_FOR_CALU.TraceData�д���Ķ�����������ϵ�µ�������ݣ�����û�д�������˶�ʱ�ı仯�������ڻ����˶�ʱ��ʹ��T�Ĳ�ֵ
end

times = 0; % Aminate_ShowBody�ĵ��ô�����һ������times = 1-30��������6�ε�����£�

% time_gap = 0.2; % ������ֲ�Ҫ���ģ���Ϊǣ����NURBS��ȡֵ��
time_gap = 1/BODY_FOR_CALU.NUM_trace; % ������ֲ�Ҫ���ģ���Ϊǣ����NURBS��ȡֵ��
for time = 1:1/time_gap % ÿ����time_gap * step��һ����1/time_gap��
    if FootIndex < 5
        %����������������յ�������Բ�ֵ�����㶯������
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
        %�����˶��Ͳ���ʱ�������TCjGӦ�ò�ͬ
        for k=1:4
            BODY_FOR_MOVE.TCjG(:,:,k)=T*BODY_FOR_CALU.TCB(:,:,k);
              WS_Data(:,:,k)=T*BODY_FOR_CALU.WS_Data(:,:,k);
              Foot_tem=BODY_FOR_MOVE.Foot(k,:);
              Foot_tem=inv(BODY_FOR_MOVE.TCjG(:,:,k))*[Foot_tem.';1];
              BODY_FOR_CALU.TraceData((BODY_FOR_CALU.NUM_Step-1)*BODY_FOR_CALU.NUM_trace+time,3*(k-1)+1:3*k)= reshape(Foot_tem(1:3),[1,3]);
              %�����˶�ʱ��������ݣ���������ϵ�� BODY_FOR_MOVE.Foot �任������
        end
    else
        error('Error. Input of ami_Move must be foot character.');
    end
    % ������κͽ�ĩ���Ѿ����ˣ�Ҳ�Ѿ��������ȵ����ģ�����Ҫ����������
    BODY_FOR_MOVE.COG = BODY_FOR_MOVE.COG + time_gap * deltaCOG;
    % ����õ������ĺ󣬿��ӻ�����

    times = Aminate_ShowBody(FootIndex,times,BODY_PARA,WS_Data);
    
    
    pause(0.01); % �������Ӻ�����ȴ���������ͳһ��ͣ����
end
if FootIndex==5
    BODY_FOR_CALU.NUM_Step=BODY_FOR_CALU.NUM_Step+1;
end
BODY_FOR_MOVE.TBG=BODY_FOR_CALU.TBG;
end
