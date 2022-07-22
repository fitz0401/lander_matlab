function [data, info] = gait_feedback_msgsResponse
%gait_feedback_msgs gives an empty data for lander/gait_feedback_msgsResponse
% Copyright 2019-2020 The MathWorks, Inc.
%#codegen
data = struct();
data.MessageType = 'lander/gait_feedback_msgsResponse';
[data.IsFinish, info.IsFinish] = ros.internal.ros.messages.ros.default_type('logical',1);
[data.Foot1Position, info.Foot1Position] = ros.internal.ros.messages.ros.default_type('double',3);
[data.Foot2Position, info.Foot2Position] = ros.internal.ros.messages.ros.default_type('double',3);
[data.Foot3Position, info.Foot3Position] = ros.internal.ros.messages.ros.default_type('double',3);
[data.Foot4Position, info.Foot4Position] = ros.internal.ros.messages.ros.default_type('double',3);
info.MessageType = 'lander/gait_feedback_msgsResponse';
info.constant = 0;
info.default = 0;
info.maxstrlen = NaN;
info.MaxLen = 1;
info.MinLen = 1;
info.MatPath = cell(1,5);
info.MatPath{1} = 'isFinish';
info.MatPath{2} = 'foot1_position';
info.MatPath{3} = 'foot2_position';
info.MatPath{4} = 'foot3_position';
info.MatPath{5} = 'foot4_position';
