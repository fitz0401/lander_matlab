function d1 = walkLegPrimaryTransMechPositionIK(alpha1,d2,d3,theta_t0,theta_d,theta_origin1)
%主支链传动机构的求解函数，d2,d3,theta_t0,theta_d为机构参数，alpha1为主支链Rv1关节的驱动参数；
theta_t1=theta_t0-theta_d-(pi/2-(theta_origin1+alpha1));
d1=sqrt(d2^2+d3^2-2*d2*d3*cos(theta_t1));
end