function f2 = getf2(BODY_temp, x)

omiga2 = 2e-2;
if length(x) == 6
    x = x + [BODY_temp.Body(5) BODY_temp.Body(10) BODY_temp.Body(15) BODY_temp.RotateAngle(1:3)];
elseif length(x) == 3
    x = x + [BODY_temp.Body(5) BODY_temp.Body(10) BODY_temp.Body(15)];
end

Foot_in_global = [BODY_temp.Body(1:4)'; BODY_temp.Body(6:9)'; BODY_temp.Body(11:14)'; 1 1 1 1]; % 脚的位置
Apex_in_body = [BODY_temp.Body(16:19)'; BODY_temp.Body(20:23)'; BODY_temp.Body(24:27)'; 2 2 2 2] - repmat([BODY_temp.Body(5); BODY_temp.Body(10); BODY_temp.Body(15); 1],1,4); % 顶点的位置
Foot_in_Apex_Optimal = 1.0e+03 * ...
[   0.5593    0.5494   -0.2559   -0.1269
   -0.3640    0.4341    0.3011   -0.3423
   -1.2000   -1.2000   -1.2000   -1.2000
         0         0         0         0];
if length(x) == 3
    x(4:6) = [0,0,0];
end
f2 = norm(Foot_in_global - [eul2rotm([x(4), x(5), x(6)]), ...
    [x(1); x(2); x(3)]; 0 0 0 1] * Apex_in_body - Foot_in_Apex_Optimal,'fro');
f2 = omiga2 * f2;

end