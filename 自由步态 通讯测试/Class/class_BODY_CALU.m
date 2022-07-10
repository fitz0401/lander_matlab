classdef class_BODY_CALU
    properties
        Body   %�����˲��������ĸ�����ǵ㡢�ĸ���˽ǵ�����ĵ�
        
        %BODY���ݵĴ洢��ʽ 1~4 ����X 6~9 ����Y 11~14 ����Z 16~19 �����X������ 20~23�����Y���� 
        %24~27 �����Z����  5 10 15��ʾ�������ĳ�ʼλ�õ�X Y Z����
        %28~31��ʾ�����ȵ����ĵ��x���꣬32��ʾ�����������ĵ�X����
        %33~36��ʾ�����ȵ����ĵ��Y���꣬37��ʾ�����������ĵ�Y����
        %38~41��ʾ�����ȵ����ĵ��Z���꣬42��ʾ�����������ĵ�Z����
        Body0
        Body_line
        TraceData  %���ӵĹ켣�����������������ͻ���Ĺ켣����
        Foot_height=15;
        NUM_trace=20;
        NUM_Step
        TCB %��������ϵ�뵥������ϵ�ı任����
        TBG %��������ϵ���������ϵ�ı任����
        T
        SM % �ȶ�ԣ��
        MassRatio % �����Ⱥ������ռ������
        RotateAngle = [0 0 0]%��������ľ��庬���Ӧ�ã�����
        RotateAngle_Boundry = [-0.1, -0.2, -0.05; 0.1, 0.2, 0.05]
        gradBoundry = 1 % ��ͼ�ݶȵ����Χ����������ݶȵĵ㲻�ܲ�
        Leg % ���ȵĹ����ռ�
%         Inteval = 6.25 % �����ռ�ľ���
        Inteval = 2.5 % �����ռ�ľ���
        WS_Data %��ͼ�õĹ����ռ�
        
        len_x = 1 % map_x����         ���ﳤ��ָ���ǣ���
        len_y = 1 % map_y����
        len_z = 1 % map_z����
        
        % �Զ���Ĺ��������ռ������ϵ��ÿֻ�ų�ʼλ�ö����������ϵԭ��
        interSpace % ��ʽ��4*2����
        BodySpace % ���幤���ռ�
%         stride = 100 % �����
        stride = 80 % �����
        % 4*3�ľ��󣬷ֱ��������Ϊ���ģ��ĸ����嶥���������˵�Ħ�x/y/z
        IdealLegLength
    end
    
   %��ӹ켣Ŀǰ�İ취�����޸�Move������show����
    
    methods
        function Robot = Move(Robot, num, stepX, stepY, stepZ)%�������˶�����
            %Robot�����˽ṹ��  num??  stepX, stepY, stepZ�ֱ�ΪX Y Z����Ĳ���
            %BODY�ľ������ݴ洢��ʽ������
            if num < 5
                Robot.Body(num,:,:) = Robot.Body(num,:,:) + stepX; % ����
                Robot.Body(num+5,:,:) = Robot.Body(num+5,:,:) + stepY; % ����
                Robot.Body(num+10,:,:) = Robot.Body(num+10,:,:) + stepZ; % ����
                
                Robot.Body(num+27,:,:) = (Robot.Body(num+15,:,:) + Robot.Body(num,:,:))/2; % �����ı仯
                Robot.Body(num+32,:,:) = (Robot.Body(num+19,:,:) + Robot.Body(num+5,:,:))/2; % �����ı仯
                Robot.Body(num+37,:,:) = (Robot.Body(num+23,:,:) + Robot.Body(num+10,:,:))/2; % �����ı仯
            elseif num == 5
                Robot.Body(5,:,:) = Robot.Body(5,:,:) + stepX; % �������ı仯
                Robot.Body(10,:,:) = Robot.Body(10,:,:) + stepY;
                Robot.Body(15,:,:) = Robot.Body(15,:,:) + stepZ;
                
                Robot.Body(16:19,:,:) = Robot.Body(16:19,:,:) + stepX; % ���嶥��仯
                Robot.Body(20:23,:,:) = Robot.Body(20:23,:,:) + stepY;
                Robot.Body(24:27,:,:) = Robot.Body(24:27,:,:) + stepZ;
                
                Robot.Body(28:31,:,:) = (Robot.Body(1:4,:,:) + Robot.Body(16:19,:,:))/2; % �����ı仯
                Robot.Body(33:36,:,:) = (Robot.Body(6:9,:,:) + Robot.Body(20:23,:,:))/2;
                Robot.Body(38:41,:,:) = (Robot.Body(11:14,:,:) + Robot.Body(24:27,:,:))/2;
            else
                error('Error in Foot/Body to move in calculation.');
            end
            Robot.Body(32,:,:) = Robot.Body(5,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(28,:,:) * Robot.MassRatio(1) + Robot.Body(29,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(30,:,:) * Robot.MassRatio(3) + Robot.Body(31,:,:) * Robot.MassRatio(4);
            Robot.Body(37,:,:) = Robot.Body(10,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(33,:,:) * Robot.MassRatio(1) + Robot.Body(34,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(35,:,:) * Robot.MassRatio(3) + Robot.Body(36,:,:) * Robot.MassRatio(4);
            Robot.Body(42,:,:) = Robot.Body(15,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(38,:,:) * Robot.MassRatio(1) + Robot.Body(39,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(40,:,:) * Robot.MassRatio(3) + Robot.Body(41,:,:) * Robot.MassRatio(4);
        end
        
        function Robot = Rotate(Robot, rx, ry, rz)
%             apex_in_body = [Robot.Body(16:19)'- Robot.Body(5); Robot.Body(20:23)'- Robot.Body(10); Robot.Body(24:27)'- Robot.Body(15)];
%             apex_in_body(4,:) = [1 1 1 1];
%             rotMat = [eul2rotm([rx, ry, rz]),[Robot.Body(5); Robot.Body(10); Robot.Body(15)];0,0,0,1];
%             apex_in_global = rotMat * apex_in_body; % ������global�µ����꣬ÿһ����һ������[x;y;z;1]
%             apex_in_global = apex_in_global'; % ������global�µ����꣬ÿһ����һ������[x,y,z,1]
%             
%             Robot.Body(16:19,:,:) = apex_in_global(:,1); % ���嶥��仯
%             Robot.Body(20:23,:,:) = apex_in_global(:,2);
%             Robot.Body(24:27,:,:) = apex_in_global(:,3);

            apex_in_body = [Robot.Body0(16:19)'- Robot.Body0(5); Robot.Body0(20:23)'- Robot.Body0(10); Robot.Body0(24:27)'- Robot.Body0(15)];
            apex_in_body_aftermove = eul2rotm([rx, ry, rz],'XYZ') * apex_in_body; % ������global�µ����꣬ÿһ����һ������[x;y;z;1]
            apex_in_body_aftermove = apex_in_body_aftermove';
            apex_in_global = apex_in_body_aftermove + repmat([Robot.Body(5), Robot.Body(10), Robot.Body(15)],[4,1]);
            % ������global�µ����꣬ÿһ����һ������[x,y,z]
            
            Robot.Body(16:19,:,:) = apex_in_global(:,1); % ���嶥��仯
            Robot.Body(20:23,:,:) = apex_in_global(:,2);
            Robot.Body(24:27,:,:) = apex_in_global(:,3);
            
            Robot.Body(28:31,:,:) = (Robot.Body(1:4,:,:) + Robot.Body(16:19,:,:))/2; % �����ı仯
            Robot.Body(33:36,:,:) = (Robot.Body(6:9,:,:) + Robot.Body(20:23,:,:))/2;
            Robot.Body(38:41,:,:) = (Robot.Body(11:14,:,:) + Robot.Body(24:27,:,:))/2;
            
            Robot.Body(32,:,:) = Robot.Body(5,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(28,:,:) * Robot.MassRatio(1) + Robot.Body(29,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(30,:,:) * Robot.MassRatio(3) + Robot.Body(31,:,:) * Robot.MassRatio(4);
            Robot.Body(37,:,:) = Robot.Body(10,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(33,:,:) * Robot.MassRatio(1) + Robot.Body(34,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(35,:,:) * Robot.MassRatio(3) + Robot.Body(36,:,:) * Robot.MassRatio(4);
            Robot.Body(42,:,:) = Robot.Body(15,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(38,:,:) * Robot.MassRatio(1) + Robot.Body(39,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(40,:,:) * Robot.MassRatio(3) + Robot.Body(41,:,:) * Robot.MassRatio(4);
        end
    end
end