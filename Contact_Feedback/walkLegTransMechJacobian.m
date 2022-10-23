function JFK = walkLegTransMechJacobian(alpha3,theta3)
global phi3_initial q1 q3x q3z q4x q4y q4z
phi3=phi3_initial;
JFK = (  2*q1*q3z*cos(theta3)*cos(alpha3) - 2*q1*q3x*sin(theta3)*cos(phi3)*cos(alpha3) - 2*q1*q3x*cos(theta3)*sin(alpha3) - 2*q1*q3z*sin(theta3)*cos(phi3)*sin(alpha3) + 2*q1*q4x*sin(theta3) - 2*q1*q4z*cos(theta3)  )  /...
          (  ( 2*q3z*q4z+2*q1*q3z*sin(theta3)+2*q3x*q4x*cos(phi3)-2*q3x*q4y*sin(phi3)+2*q1*q3x*cos(theta3)*cos(phi3) )*sin(alpha3)  +  ...
             ( 2*q3x*q4z+2*q1*q3x*sin(theta3)+2*q3z*q4y*sin(phi3)-2*q3z*q4x*cos(phi3)-2*q1*q3z*cos(theta3)*cos(phi3) )*cos(alpha3)  );

%JIK = 1/JFK;

end