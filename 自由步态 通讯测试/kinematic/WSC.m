function [XS YS WS_down WS_up] = WSC(j,TCjG,BODY_PARA,InitPoint)
%InitPoint初始点位置，在世界坐标系中
%TCjG 从腿坐标系到世界坐标系的变换
%修改一下 X Y的储存方式，XY全存，Z判断是否在工作空间内
%% 参数转化
% a1=BODY_PARA.Link_A(1);a2=BODY_PARA.Link_A(2);a3=BODY_PARA.Link_A(3);
% b1=BODY_PARA.Link_B(1);b2=BODY_PARA.Link_B(1);b3=BODY_PARA.Link_B(1);
% l1=BODY_PARA.Link_L(1);l2=BODY_PARA.Link_L(2);l3=BODY_PARA.Link_L(3);l4=BODY_PARA.Link_L(4);l1x=BODY_PARA.Link_L(5);
% p1=BODY_PARA.Link_P(1);p2x=BODY_PARA.Link_P(2);p2y=BODY_PARA.Link_P(3);p2z=BODY_PARA.Link_P(4);p3x=BODY_PARA.Link_P(5);p3y=BODY_PARA.Link_P(6);p3z=BODY_PARA.Link_P(7);
% theta_in=BODY_PARA.Angle(1);theta_m=BODY_PARA.Angle(2);theta_ex=BODY_PARA.Angle(3);theta_p=BODY_PARA.Angle(4);
% d=BODY_PARA.Link_D;
% alpha1_min=BODY_PARA.Lim_alpha(1,1);alpha1_max=BODY_PARA.Lim_alpha(1,2);alpha2_min=BODY_PARA.Lim_alpha(2,1);alpha2_max=BODY_PARA.Lim_alpha(2,2);alpha3_min=BODY_PARA.Lim_alpha(3,1);alpha3_max=BODY_PARA.Lim_alpha(3,2);
% beta1_min=BODY_PARA.Lim_beta(1,1);beta1_max=BODY_PARA.Lim_beta(1,2);beta2_min=BODY_PARA.Lim_beta(2,1);beta2_max=BODY_PARA.Lim_beta(2,2);beta3_min=BODY_PARA.Lim_beta(3,1);beta3_max=BODY_PARA.Lim_beta(3,2);
% gamma1_min=BODY_PARA.Lim_gama(1,1);gamma1_max=BODY_PARA.Lim_gama(1,2);gamma2_min=BODY_PARA.Lim_gama(2,1);gamma2_max=BODY_PARA.Lim_gama(2,2);gamma3_min=BODY_PARA.Lim_gama(3,1);gamma3_max=BODY_PARA.Lim_gama(3,2);
% phi1_min=BODY_PARA.Lim_phi(1,1);phi1_max=BODY_PARA.Lim_phi(1,2);phi2_min=BODY_PARA.Lim_phi(2,1);phi2_max=BODY_PARA.Lim_phi(2,2);phi3_min=BODY_PARA.Lim_phi(3,1);phi3_max=BODY_PARA.Lim_phi(3,2);
% phi1_initial=BODY_PARA.Init_phi(1);phi2_initial=BODY_PARA.Init_phi(2);phi3_initial=BODY_PARA.Init_phi(3);
% Q_transmech=BODY_PARA.Q_transmech;
% Q_Pritransmech=BODY_PARA.Q_Pritransmech;                                                                               
                                                                                                                                                                                      
%% 其他参数
total_layernum_z=100;% z方向的总层数(4的倍数)
total_layernum_y=240;
total_layernum_x=240;
% M_RGB=M_RGB_GEN(total_layernum); % 生成色值矩阵（由蓝到红）
% layernum=0; % 用于显示计算进度
X=[];Y=[];Z=[];

%% 开始遍历末端位置zF,xF,yF。基于Cj系\

%在实际的规划中，为了显示更加清晰，可以适当删除部分工作空间范围


% zFmin=-700 ;   zFmax=-300      ;   s_zF=(zFmax-zFmin)/total_layernum;
% yFmin=-500  ;   yFmax=500     ;   s_yF=(yFmax-yFmin)/total_layernum;
% xFmin= 0    ;   xFmax=1000    ;   s_xF=(xFmax-xFmin)/total_layernum;
zFmin=-200 ;   zFmax=240      ;   s_zF=(zFmax-zFmin)/total_layernum_z;
% yFmin=-1000  ;   yFmax=-400     ;   s_yF=(yFmax-yFmin)/total_layernum_y;
yFmin= InitPoint(2)-300    ;   yFmax=InitPoint(2)+300;    
xFmin= InitPoint(1)-220    ;   xFmax=InitPoint(1)+380;   
% s_xF=(xFmax-xFmin)/total_layernum_x;
itotal=0;%迭代变量以求得工作空间内点的总数，方便计算性能指标的离散点总数量，最后赋给ntotal

zF = linspace(zFmin, zFmax, total_layernum_z+1);
yF = linspace(yFmin, yFmax, total_layernum_y+1);
xF = linspace(xFmin, xFmax, total_layernum_x+1);
% yF = yFmin:1*s_yF:yFmax;
% xF = xFmin:1*s_xF:xFmax;
% zF = zFmin:1*s_zF:zFmax;
% yF = yFmin:1*s_yF:yFmax;
% xF = xFmin:1*s_xF:xFmax;
% Point_C=inv(TCjG)*[xF;yF;zF;ones(1,length(xF))];

% for zF = zFmin:3*s_zF:zFmax
%     for yF = yFmin:1*s_yF:yFmax
%         for xF = xFmin:1*s_xF:xFmax
% X(400~1000)
% Z(-220~220)
% Y(-1000~-400)
WS=zeros(length(yF),length(xF),length(zF));
for j=1:length(yF)
    for i = 1:length(xF) 
        for k=1:length(zF)
            
            %             output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF,a1,b1,a2,b2,a3,b3,l1,l2,l3,l4,d,theta_in,theta_p,p1,p2x,p2y,p2z,p3x,p3y,p3z,...
            %                                                                                                 phi1_initial,phi2_initial,phi3_initial,phi1_min,phi1_max,phi2_min,phi2_max,phi3_min,phi3_max,...
            %                                                                                                 alpha1_min,alpha1_max,alpha2_min,alpha2_max,alpha3_min,alpha3_max,...
            %                                                                                                 beta1_min,beta1_max,beta2_min,beta2_max,beta3_min,beta3_max,...
            %                                                                                                 gamma1_min,gamma1_max,gamma2_min,gamma2_max,gamma3_min,gamma3_max,ksim);
            
            Point_C=inv(TCjG)*[xF(i);yF(j);zF(k);1];
            
            output_walkingPSP = walkLegExeMechPositionIK(Point_C(1),Point_C(2),Point_C(3),BODY_PARA);
            
            if isempty(output_walkingPSP)==0
                itotal=itotal+1;
                %                F_CjG = TCjG*[xF(i);yF(j);zF(k);1];
                %                X(itotal) = F_CjG(1)+0.26;
%                 XS(j,i) = xF(i);
%                 YS(j,i) = yF(j);
                
                if zF(k)==0  %作用是什么？？ 为了方便区分0点
                    WS(j,i,k) = pi;
                else
                    WS(j,i,k) = zF(k);
                end
            end
            XS(j,i) = xF(i);
            YS(j,i) = yF(j);
            

        end
    end
end
% XS(XS==0)=nan;
% YS(YS==0)=nan;
WS(WS==0)=nan;
WS(WS==pi)=0;
XS=XS-InitPoint(1);
YS=YS-InitPoint(2);
for j=1:length(XS(:,1))
    for i = 1:length(YS(1,:))
        
        [C,num]=min(abs(WS(j,i,:)-InitPoint(3)));  %找这一列距离足端点最近的Z值
%         if isnan(C)||C>=20%当C为nan说明这一列没有工作空间点
        if isnan(C)%当C为nan说明这一列没有工作空间点
            WS_up(j,i)=nan;
            WS_down(j,i)=nan;
        else
            for s=num:length(WS(j,i,:))
                if isnan(WS(j,i,s))||(~isnan(WS(j,i,s))&&(s==length(WS(j,i,:))))
%                     if WS(j,i,s-1)-InitPoint(3)>0
%从Z值最接近初始点的位置向Z轴正方向搜索，当到达边界时为上边界
                        WS_up(j,i)=WS(j,i,s-1)-InitPoint(3);
%                     else
%                         WS_up(j,i)=0;
%                     end
                    break;
                end

            end
            %         for k=1:length(zF)
            %             if
            %             locate=find(min(abs(WS(1,1,:)-InitPoint(3))))
            %         end
            for s=num:-1:1
                if isnan(WS(j,i,s))||(~isnan(WS(j,i,s))&&(s==1))
%                     if WS(j,i,s+1)-InitPoint(3)<0
%从Z值最接近初始点的位置向Z轴负方向搜索，当到达边界时为下边界
                        WS_down(j,i)=WS(j,i,s+1)-InitPoint(3);
%                     else
%                         WS_down(j,i)=0;
%                     end
                    break;
                end
            end
        end
    end
end
% ntotal=itotal;
% M_RGB_GEN_n=ceil(ntotal/4)*4;
% M_RGB=M_RGB_GEN(M_RGB_GEN_n); % 生成色值矩阵（由蓝到红）
% WS=[X;Y;Z;ones(1,itotal)];
% WORKSPACEfigure=scatter3(X,Y,Z,10,M_RGB(1:length(X),:),'filled');
YS=YS(end:-1:1,:);  %YS设置时上下颠倒了，这里按列做一下倒序
WS_up=WS_up(end:-1:1,:);
WS_down=WS_down(end:-1:1,:);
end