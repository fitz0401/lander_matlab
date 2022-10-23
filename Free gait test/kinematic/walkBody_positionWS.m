function [map_x,map_y,map_body_bit]=walkBody_positionWS(TBG,TCB,F_G,Centroid,BODY_PARA,bodyMovement)  %需要导入的参数：机构参数，两组变换矩阵 TCB TBG
%F_G表示球铰S1在世界坐标系的坐标集，从第一列到第四列分别表示腿1--4
%Centroid表示此时机身的质心位置（世界坐标系），方便进行工作范围计算
%% 固有参数
%球铰S1在世界坐标系的参数
% deltaX=100/1000;
% deltaY=1000/1000;
% F_G(:,1)=[Rsp;0;0];F_G(:,2)=[0;Rsp;0];F_G(:,3)=[-Rsp;0;0];F_G(:,4)=[0;-Rsp;0];  % 表示F相对于G
% F_G(1,:)=F_G(1,:)+deltaX;
% F_G(2,:)=F_G(2,:)+deltaY;



X_range=100;
Y_range=100;
Z_range=30;
% X_range=200;
% Y_range=200;
% Z_range=200;
%% 其他参数
X_total_layernum=80;% 计算时为了地图统一方便，选择分度值与腿部一样为2.5
Y_total_layernum=80;
Z_total_layernum=20;
% M_RGB=M_RGB_GEN(total_layernum); % 生成色值矩阵（由蓝到红）
% layernum=0; % 用于显示计算进度
X=[];Y=[];Z=[];

%% 开始遍历机身位置在G系中坐标（xBG,yBG,zBG）
%这个范围应该从记录的质心参数中提取，不是固定不变的
%工作空间在X，Y，Z方向上的长度约为140，Z方向约为140
%合理约束计算范围来提高计算速度；实际上单次机身的运动不会太大，因此可能不需要计算全部工作空间范围，如Z轴方向只需要计算小范围，甚至有可能根据接下来机身可能的运动方向进行缩减
% zBGmin=Centroid(3)-Z_range  ;  zBGmax=Centroid(3)+Z_range  ;   s_zBG=(zBGmax-zBGmin)/Z_total_layernum;
% yBGmin=Centroid(2)-Y_range  ;  yBGmax=Centroid(2)+Y_range  ;   s_yBG=(yBGmax-yBGmin)/Y_total_layernum;
% xBGmin=Centroid(1)-X_range/2  ;  xBGmax=Centroid(1)+X_range  ;   s_xBG=(xBGmax-xBGmin)/X_total_layernum;

% zBGmin=Centroid(3)-Z_range  ;  zBGmax=Centroid(3)+Z_range  ;   s_zBG=(zBGmax-zBGmin)/Z_total_layernum;
% yBGmin=Centroid(2)-Y_range  ;  yBGmax=Centroid(2)+Y_range  ;   s_yBG=(yBGmax-yBGmin)/Y_total_layernum;
% xBGmin=Centroid(1)-X_range/2  ;  xBGmax=Centroid(1)+X_range  ;   s_xBG=(xBGmax-xBGmin)/X_total_layernum;

zBGmin=Centroid(3)-Z_range  ;  zBGmax=Centroid(3)+Z_range  ;   s_zBG=(zBGmax-zBGmin)/Z_total_layernum;
yBGmin=Centroid(2)-Y_range  ;  yBGmax=Centroid(2)+Y_range  ;   s_yBG=(yBGmax-yBGmin)/Y_total_layernum;
xBGmin=Centroid(1)-X_range  ;  xBGmax=Centroid(1)+X_range  ;   s_xBG=(xBGmax-xBGmin)/X_total_layernum;
itotal=0;%迭代变量以求得工作空间内点的总数，方便计算性能指标的离散点总数量，最后赋给ntotal
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
%边界搜索标记
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
%                    %修改一下这个上边界的条件
%                    WS_up(i,j)=zBG(k)-Centroid(3);
%                    flag_up=1;
%                end
               if flag_down==0
                   Body_down(i,j)=zBG(k)-Centroid(3);
                   flag_down=1;
               end     
               flag_up=[i,j,zBG(k)];
            end
            %没减去初始位置，需要修改
            map_x(i,j)=xBG(i)-Centroid(1);
            map_y(i,j)=yBG(j)-Centroid(2);

        end
        %列搜索完成后重置标记
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
M_RGB=M_RGB_GEN(RGB_layer); % 生成色值矩阵（由蓝到红）
hold on
% scatter3(X,Y,Z,10,M_RGB(1:length(X),:),'filled');

%% 对三维的工作空间做处理，得到二维的map

end
