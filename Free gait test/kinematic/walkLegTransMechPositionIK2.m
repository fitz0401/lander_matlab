function theta2 = walkLegTransMechPositionIK2(phi2_initial,alpha2,q1,q2,q3x,q3z,q4x,q4y,q4z,theta2_min,theta2_max)

eps = 0.0001;
i_Solution = 1;

%% 求theta3,存在多解可能，需讨论
A0 = 2*q1*q3x*sin(alpha2) - 2*q1*q3z*cos(alpha2)  + 2*q1*q4z;
B0 = -2*q1*q3x*cos(phi2_initial)*cos(alpha2) - 2*q1*q3z*cos(phi2_initial)*sin(alpha2) - 2*q1*q4x;
C0 = 2*q3x*q4x*cos(phi2_initial)*cos(alpha2) + 2*q3x*q4y*sin(phi2_initial)*cos(alpha2) -...
    2*q3z*q4z*cos(alpha2) + 2*q3z*q4x*cos(phi2_initial)*sin(alpha2) + 2*q3z*q4y*sin(phi2_initial)*sin(alpha2) + ...
    2*q3x*q4z*sin(alpha2)+ q1^2 - q2^2 + q3x^2 +q3z^2+q4x^2+q4y^2+q4z^2;
C0=-C0;

if abs(B0+C0)>=eps && A0^2+B0^2-C0^2<0 % 二次方程无解情形
   length_theta3_vector=0;
   theta2=[];
elseif abs(B0+C0)>=eps && A0^2+B0^2-C0^2>=0 % 二次方程有解情形
    theta3_vector_i = 0;
    for k=-2:2
        theta3_vector_i = theta3_vector_i+1;
        theta3_vector(theta3_vector_i) = 2*( atan( (A0+sqrt(A0^2+B0^2-C0^2)) / (B0+C0) ) + k*pi );
        theta3_vector(theta3_vector_i+5) = 2*( atan( (A0-sqrt(A0^2+B0^2-C0^2)) / (B0+C0) ) + k*pi );
    end
    
    theta2 = theta3_vector(theta3_vector>=theta2_min & theta3_vector<=theta2_max);
    if length(theta2)==1
        theta2 = theta2;
    else
        theta2 = [];
    end
    
else % 退化为一次方程求解
    theta3_vector_i = 0;
    for k=-2:2
        theta3_vector_i = theta3_vector_i+1;
        theta3_vector(theta3_vector_i) = 2*( atan( (C0-B0)/(2*A0) ) + k*pi );
    end
    theta2 = theta3_vector(theta3_vector>=theta2_min & theta3_vector<=theta2_max);
end


end