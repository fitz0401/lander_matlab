function theta3 = walkLegTransMechPositionIK3(phi3_initial,alpha3,q1,q2,q3x,q3z,q4x,q4y,q4z,theta3_min,theta3_max)

eps = 0.0001;
i_Solution = 1;

%% 求theta3,存在多解可能，需讨论
A0 = 2*q1*q3z*cos(alpha3) - 2*q1*q3x*sin(alpha3)  - 2*q1*q4z;
B0 = 2*q1*q3x*cos(phi3_initial)*cos(alpha3) + 2*q1*q3z*cos(phi3_initial)*sin(alpha3) - 2*q1*q4x;
C0 = 2*q3z*q4y*sin(phi3_initial)*sin(alpha3) - 2*q3z*q4x*cos(phi3_initial)*sin(alpha3) +...
    2*q3x*q4z*sin(alpha3) + 2*q3x*q4y*sin(phi3_initial)*cos(alpha3) - 2*q3x*q4x*cos(phi3_initial)*cos(alpha3) - ...
    2*q3z*q4z*cos(alpha3)+ q1^2 - q2^2 + q3x^2 +q3z^2+q4x^2+q4y^2+q4z^2;

if abs(B0+C0)>=eps && A0^2+B0^2-C0^2<0 % 二次方程无解情形
   length_theta3_vector=0;
   theta3=[];
elseif abs(B0+C0)>=eps && A0^2+B0^2-C0^2>=0 % 二次方程有解情形
    theta3_vector_i = 0;
    for k=-2:2
        theta3_vector_i = theta3_vector_i+1;
        theta3_vector(theta3_vector_i) = 2*( atan( (A0+sqrt(A0^2+B0^2-C0^2)) / (B0+C0) ) + k*pi );
        theta3_vector(theta3_vector_i+5) = 2*( atan( (A0-sqrt(A0^2+B0^2-C0^2)) / (B0+C0) ) + k*pi );
    end
    
    theta3 = theta3_vector(theta3_vector>=theta3_min & theta3_vector<=theta3_max);
    if length(theta3)==1
        theta3 = theta3;
    else
        theta3 = [];
    end
    
else % 退化为一次方程求解
    theta3_vector_i = 0;
    for k=-2:2
        theta3_vector_i = theta3_vector_i+1;
        theta3_vector(theta3_vector_i) = 2*( atan( (C0-B0)/(2*A0) ) + k*pi );
    end
    theta3 = theta3_vector(theta3_vector>=theta3_min & theta3_vector<=theta3_max);
end


end