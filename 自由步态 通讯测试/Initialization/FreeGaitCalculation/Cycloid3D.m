function cyPoint=Cycloid3D(Start_point,End_point,H,NUMCIR)    %复合摆线轨迹，当nurbs曲线规划不容易得到合适的结果时，采用复合摆线轨迹
%S为步长，H为步高，T为一步的时间，cyY为输出轨迹的Y向量，cyX为输出轨迹的X向量，t为对应的时间向量



T=2;
S=norm(End_point-Start_point);
theta_Y=-asin((End_point(3)-Start_point(3))/S);

% Start_point2=Rotate(theta_Y,'Y')*Start_point';
theta_Z=asin((End_point(2)-Start_point(2))/sqrt((End_point(2)-Start_point(2))^2+(End_point(1)-Start_point(1))^2));
% Xstart=5356.25;
% (3500-3356.25000000000)
% Ystart=0;
% safeH=1.3;                                 %H方向安全系数，安全系数越大，轨迹与障碍物相交的概率越小,可调
% % safeS=1.3;                                 %H方向安全系数，安全系数越大，轨迹与障碍物相交的概率越小,可调
% [maxp,indexm]=max(boundry(2,:));           %取最高点
% [maxr,indexr]=max(boundry(1,:));
% [minl,indexl]=min(boundry(1,:));           %取左右端点规划步长
% S=safeS*2*max([abs(boundry(1,indexm)-boundry(1,indexl)),abs(boundry(1,indexm)-boundry(1,indexr))]);
% H=safeH*boundry(2,indexm);
amount=NUMCIR;
t=0:T/amount:T;
fx=@(x)(S*(x./T-1/(2*pi)*sin(2*pi*x./T)));
fz=@(x)(H*(1/2-1/2*cos(2*pi*x./T)));
% dfx=@(x)(S/T*(1-cos(2*pi*x./T)));
% dfy=@(x)(H*pi/T*sin(2*pi*x./T));
% speedx=dfx(t);
% speedy=dfy(t);
fy=zeros(1,NUMCIR+1);
cyPoint=[fx(t);fy;fz(t)];
cyPoint=Rotate(theta_Z,'Z')*Rotate(theta_Y,'Y')*cyPoint;
cyPoint(1,:)=cyPoint(1,:)+Start_point(1);
cyPoint(2,:)=cyPoint(2,:)+Start_point(2);
cyPoint(3,:)=cyPoint(3,:)+Start_point(3);
end

% cyPoint=Cycloid3D([1,1,1],[2,2,2],1,30)
% plot3(cyPoint(1,:),cyPoint(2,:) ,cyPoint(3,:), 'Color','black'); 
% axis equal
