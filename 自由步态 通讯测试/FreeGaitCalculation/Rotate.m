function R=Rotate(theta,mark)
switch mark
    case 'Z'
        R=[cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1];
    case 'Y'
        R=[cos(theta),0,sin(theta);0,1,0;-sin(theta),0,cos(theta)];
    case 'X'
        R=[1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
end

end