function [map_x,map_y,map_body_bit]=walkBody_positionWS(TBG,TCB,F_G,Centroid,BODY_PARA,bodyMovement)  %��Ҫ����Ĳ�������������������任���� TCB TBG
%F_G��ʾ���S1����������ϵ�����꼯���ӵ�һ�е������зֱ��ʾ��1--4
%Centroid��ʾ��ʱ���������λ�ã���������ϵ����������й�����Χ����
%% ���в���
%���S1����������ϵ�Ĳ���
% deltaX=100/1000;
% deltaY=1000/1000;
% F_G(:,1)=[Rsp;0;0];F_G(:,2)=[0;Rsp;0];F_G(:,3)=[-Rsp;0;0];F_G(:,4)=[0;-Rsp;0];  % ��ʾF�����G
% F_G(1,:)=F_G(1,:)+deltaX;
% F_G(2,:)=F_G(2,:)+deltaY;



X_range=100;
Y_range=100;
Z_range=30;
% X_range=200;
% Y_range=200;
% Z_range=200;
%% ��������
X_total_layernum=80;% ����ʱΪ�˵�ͼͳһ���㣬ѡ��ֶ�ֵ���Ȳ�һ��Ϊ2.5
Y_total_layernum=80;
Z_total_layernum=20;
% M_RGB=M_RGB_GEN(total_layernum); % ����ɫֵ�����������죩
% layernum=0; % ������ʾ�������
X=[];Y=[];Z=[];

%% ��ʼ��������λ����Gϵ�����꣨xBG,yBG,zBG��
%�����ΧӦ�ôӼ�¼�����Ĳ�������ȡ�����ǹ̶������
%�����ռ���X��Y��Z�����ϵĳ���ԼΪ140��Z����ԼΪ140
%����Լ�����㷶Χ����߼����ٶȣ�ʵ���ϵ��λ�����˶�����̫����˿��ܲ���Ҫ����ȫ�������ռ䷶Χ����Z�᷽��ֻ��Ҫ����С��Χ�������п��ܸ��ݽ�����������ܵ��˶������������
% zBGmin=Centroid(3)-Z_range  ;  zBGmax=Centroid(3)+Z_range  ;   s_zBG=(zBGmax-zBGmin)/Z_total_layernum;
% yBGmin=Centroid(2)-Y_range  ;  yBGmax=Centroid(2)+Y_range  ;   s_yBG=(yBGmax-yBGmin)/Y_total_layernum;
% xBGmin=Centroid(1)-X_range/2  ;  xBGmax=Centroid(1)+X_range  ;   s_xBG=(xBGmax-xBGmin)/X_total_layernum;

% zBGmin=Centroid(3)-Z_range  ;  zBGmax=Centroid(3)+Z_range  ;   s_zBG=(zBGmax-zBGmin)/Z_total_layernum;
% yBGmin=Centroid(2)-Y_range  ;  yBGmax=Centroid(2)+Y_range  ;   s_yBG=(yBGmax-yBGmin)/Y_total_layernum;
% xBGmin=Centroid(1)-X_range/2  ;  xBGmax=Centroid(1)+X_range  ;   s_xBG=(xBGmax-xBGmin)/X_total_layernum;

zBGmin=Centroid(3)-Z_range  ;  zBGmax=Centroid(3)+Z_range  ;   s_zBG=(zBGmax-zBGmin)/Z_total_layernum;
yBGmin=Centroid(2)-Y_range  ;  yBGmax=Centroid(2)+Y_range  ;   s_yBG=(yBGmax-yBGmin)/Y_total_layernum;
xBGmin=Centroid(1)-X_range  ;  xBGmax=Centroid(1)+X_range  ;   s_xBG=(xBGmax-xBGmin)/X_total_layernum;
itotal=0;%������������ù����ռ��ڵ�������������������ָ�����ɢ������������󸳸�ntotal
count_time=0;

% for zBG = zBGmin : s_zBG : zBGmax
% 
%     for yBG = yBGmin : s_yBG : yBGmax
% 
%         disp([zBG yBG])
%         
%         for xBG = xBGmin : s_xBG : xBGmax
%             
%             count_time=count_time+1;
%             judge_YN=[];
% 
%             phi=0;psi=0;theta=0;
%             
%               value_walkBodyIK = walkBodyIK(xBG,yBG,zBG,F_G,TBG,TCB,BODY_PARA);
% 
%             if value_walkBodyIK == 1
%                itotal=itotal+1;
%                X(itotal)=xBG;Y(itotal)=yBG;Z(itotal)=zBG;
%             end
% 
%         end
%     end
% end
xBG = xBGmin : s_xBG : xBGmax;
yBG = yBGmin : s_yBG : yBGmax;
zBG = zBGmin : s_zBG : zBGmax;
%�߽��������
flag_down=0;
flag_up=zeros(1,3);
for i=1:length(xBG)
    for j=1:length(yBG)
%         disp([zBG yBG])
        
        for k=1:length(zBG)
            
            count_time=count_time+1;
            judge_YN=[];
            phi=0;psi=0;theta=0;
            
              value_walkBodyIK = walkBodyIK(xBG(i),yBG(j),zBG(k),F_G,bodyMovement,BODY_PARA);

            if value_walkBodyIK == 1
               itotal=itotal+1;
               X(itotal)=xBG(i);Y(itotal)=yBG(j);Z(itotal)=zBG(k);
%                WS(i,j,k)=zBG(k);
%                if flag_up==0&&flag_down==1
%                    %�޸�һ������ϱ߽������
%                    WS_up(i,j)=zBG(k)-Centroid(3);
%                    flag_up=1;
%                end
               if flag_down==0
                   Body_down(i,j)=zBG(k)-Centroid(3);
                   flag_down=1;
               end     
               flag_up=[i,j,zBG(k)];
            end
            %û��ȥ��ʼλ�ã���Ҫ�޸�
            map_x(i,j)=xBG(i)-Centroid(1);
            map_y(i,j)=yBG(j)-Centroid(2);

        end
        %��������ɺ����ñ��
        flag_down=0;
        if flag_up~=zeros(1,3)
            Body_up(flag_up(1),flag_up(2))=flag_up(3)-Centroid(3);
            flag_up=zeros(1,3);
        else
            Body_up(i,j)=0;
            Body_down(i,j)=0;
        end
    end
end

Body_down(~(Body_up >= bodyMovement(3)+0.1  &  Body_down <= -3)) = nan;
map_body_bit = ~isnan(Body_down);

ntotal=itotal;
RGB_layer=ceil(ntotal/4)*4;
M_RGB=M_RGB_GEN(RGB_layer); % ����ɫֵ�����������죩
hold on
% scatter3(X,Y,Z,10,M_RGB(1:length(X),:),'filled');

%% ����ά�Ĺ����ռ��������õ���ά��map

end
