function T=TBG_Interpolation(T0,T1,i,time_gap)
% time_gap=1/50;
t=1:1/time_gap;
% v1=[0 5].';
% v2=[0 6].';
% v3=[0 7].';
q0=rotm2quat(T0(1:3,1:3));
q1=rotm2quat(T1(1:3,1:3));
Q=interp1([t(1),t(end)],[q0;q1],t);
Loca=interp1([t(1),t(end)],[T0(1:3,4),T1(1:3,4)].',t);
% Angle=interp1([t(1),t(end)],[[0;0;0],Eula.'].',t);
% UnitQuaternion(T0)
T=[quat2rotm(Q(i,:)),Loca(i,:).';0 0 0 1];

% Loca=interp1([t(1),t(end)].',[[0 0 0].',[5 5 5].'],t);
% Loca=interp1([t(1),t(end)],[T1(1:3,4),T0(1:3,4)],t);

% BODY_FOR_CALU.TBG=[eul2rotm(-BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX'),[Step(1);Step(2);Step(3)];0 0 0 1] * BODY_FOR_CALU.TBG; 
end