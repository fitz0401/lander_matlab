function d1 = walkLegPrimaryTransMechPositionIK(alpha1,d2,d3,theta_t0,theta_d,theta_origin1)
%��֧��������������⺯����d2,d3,theta_t0,theta_dΪ����������alpha1Ϊ��֧��Rv1�ؽڵ�����������
theta_t1=theta_t0-theta_d-(pi/2-(theta_origin1+alpha1));
d1=sqrt(d2^2+d3^2-2*d2*d3*cos(theta_t1));
end