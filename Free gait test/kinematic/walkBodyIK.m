function value_walkBodyIK = walkBodyIK(xBG,yBG,zBG,F_G,bodyMovement,BODY_PARA)

% �����˶�ѧ���⣬������������г̣��Լ����˽¡��򸱵����ת��
% ע��Ϊ��߼����ԣ�l1,l2,l3,l4��Ϊ4*1ʸ��
psi=0;theta=0;phi=0;


d=BODY_PARA.Link_D;
h=BODY_PARA.Link_H;
C_B(:,1)=[d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  C_B(:,2)=[d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];
C_B(:,3)=[-d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C]; C_B(:,4)=[-d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  % ��ʾC�����B
for j=1:4
    
%     RCB(:,:,j)=[cos(pi/4+(j-1)*pi/2)  -sin(pi/4+(j-1)*pi/2)  0 ;
%         sin(pi/4+(j-1)*pi/2)   cos(pi/4+(j-1)*pi/2)  0 ;
%         0                     0                 1];
    RCB(:,:,j)=[cos(pi/4+(j-2)*pi/2)  -sin(pi/4+(j-2)*pi/2)  0 ;
        sin(pi/4+(j-2)*pi/2)   cos(pi/4+(j-2)*pi/2)  0 ;
        0                     0                 1];
    TCB(:,:,j)=[RCB(:,:,j)  C_B(:,j);0 0 0 1];%�ӵ��Ⱦ�����ϵ����������ϵ�ı任
end
% RBG=[cos(psi)*cos(theta)   cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi)    cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi)  ;
%      sin(psi)*cos(theta)   sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi)    sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi)  ;
%         -sin(theta)                       cos(theta)*sin(phi)                             cos(theta)*cos(phi)               ];
B_G=[xBG;yBG;zBG];  %B����Gϵ�е�����
angle=bodyMovement(4:6);
%�������飬���ֱ�ʾ��̬�ķ�������ȷ��
%�ı���̬�Թ����ռ�ûӰ�죿��ؼ��һ��ԭ��
TBG=[eul2rotm(angle(linspace(3,1,3)),'ZYX'),B_G;0 0 0 1];
% TBG=[RBG B_G;0 0 0 1];  %Bϵ��Gϵ�ı任����

%% �Ƶ�TBG
% % ��X����תphi����Y����תtheta����Z����תpsi
% RBG=[cos(psi)*cos(theta)   cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi)    cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi)  ;
%      sin(psi)*cos(theta)   sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi)    sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi)  ;
%         -sin(theta)                       cos(theta)*sin(phi)                             cos(theta)*cos(phi)               ];
% B_G=[xBG;yBG;zBG];  %������������ſ˱Ⱦ�����
% TBG=[RBG B_G;0 0 0 1];  %������������ſ˱Ⱦ�����
% 
% CB(:,1)=[d;0;-0.5*h+b3*cos(theta_in)]; CB(:,2)=[0;d;-0.5*h+b3*cos(theta_in)];
% CB(:,3)=[-d;0;-0.5*h+b3*cos(theta_in)]; CB(:,4)=[0;-d;-0.5*h+b3*cos(theta_in)];  % ��ʾC�����B

%% ����������
for j=1:4
%     RCB(:,:,j)=[cos((j-1)*pi/2)  -sin((j-1)*pi/2)  0 ;
%                       sin((j-1)*pi/2)   cos((j-1)*pi/2)  0 ;
%                               0                         0             1];
%     TCB(:,:,j)=[RCB(:,:,j)  CB(:,j);0 0 0 1];

    F_C(:,j)=[eye(3),zeros(3,1)] * inv(TBG*TCB(:,:,j)) * [F_G(:,j);1];    
    xF = F_C(1,j);
    yF = F_C(2,j);
    zF = F_C(3,j);
    
    
    phi1_initial=0;         phi2_initial=0;        phi3_initial=-pi; 
    alpha1_initial=0;     alpha2_initial=0;     alpha3_initial=0; 
 
    
    output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF,BODY_PARA);
%     output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF,a1,b1,a2,b2,a3,b3,l1(j),l2(j),l3(j),l4(j),d,theta_in,theta_p,p1,p2x,p2y,p2z,p3x,p3y,p3z,...
%                                                                                      phi1_initial,phi2_initial,phi3_initial,phi1_min,phi1_max,phi2_min,phi2_max,phi3_min,phi3_max,...
%                                                                                      alpha1_min,alpha1_max,alpha2_min,alpha2_max,alpha3_min,alpha3_max,...
%                                                                                      beta1_min,beta1_max,beta2_min,beta2_max,beta3_min,beta3_max,...
%                                                                                      gamma1_min,gamma1_max,gamma2_min,gamma2_max,gamma3_min,gamma3_max,ksim);
    %����ļ�����Լ򻯣�һ����һ���ȼ�����ռ������������������أ������������Ľ�
    if isempty(output_walkingPSP)
%        validity(j) = 1;
% %        i_row = 1; % �������ֵѡ���һ��⣬��Ҫ��һ���о�ѡ���о�
% %        alpha1(j) = output_walkingPSP(i_row,1) ;   beta1(j) = output_walkingPSP(i_row,2) ;   gamma1(j) = output_walkingPSP(i_row,3);   ksi1(j) = nan ;
% %        alpha2(j) = output_walkingPSP(i_row,4) ;   beta2(j) = output_walkingPSP(i_row,5);    gamma2(j) = output_walkingPSP(i_row,6);   ksi2(j) = nan ;
% %        alpha3(j) = output_walkingPSP(i_row,7);    beta3(j) = output_walkingPSP(i_row,8);    gamma3(j) = output_walkingPSP(i_row,9);   ksi3(j) = nan ;
%     else
        value_walkBodyIK=0;
        return
%        alpha1(j) = nan ; beta1(j) = nan ; gamma1(j) = nan ; ksi1(j) = nan ;
%        alpha2(j) = nan ; beta2(j) = nan ; gamma2(j) = nan ; ksi2(j) = nan ;
%        alpha3(j) = nan ; beta3(j) = nan ; gamma3(j) = nan ; ksi3(j) = nan ;
    end
end

value_walkBodyIK = 1;

end