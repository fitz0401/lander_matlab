function cyPoint=Cycloid3D(Start_point,End_point,H,NUMCIR)    %���ϰ��߹켣����nurbs���߹滮�����׵õ����ʵĽ��ʱ�����ø��ϰ��߹켣
%SΪ������HΪ���ߣ�TΪһ����ʱ�䣬cyYΪ����켣��Y������cyXΪ����켣��X������tΪ��Ӧ��ʱ������



T=2;
S=norm(End_point-Start_point);
theta_Y=-asin((End_point(3)-Start_point(3))/S);

% Start_point2=Rotate(theta_Y,'Y')*Start_point';
theta_Z=asin((End_point(2)-Start_point(2))/sqrt((End_point(2)-Start_point(2))^2+(End_point(1)-Start_point(1))^2));
% Xstart=5356.25;
% (3500-3356.25000000000)
% Ystart=0;
% safeH=1.3;                                 %H����ȫϵ������ȫϵ��Խ�󣬹켣���ϰ����ཻ�ĸ���ԽС,�ɵ�
% % safeS=1.3;                                 %H����ȫϵ������ȫϵ��Խ�󣬹켣���ϰ����ཻ�ĸ���ԽС,�ɵ�
% [maxp,indexm]=max(boundry(2,:));           %ȡ��ߵ�
% [maxr,indexr]=max(boundry(1,:));
% [minl,indexl]=min(boundry(1,:));           %ȡ���Ҷ˵�滮����
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
