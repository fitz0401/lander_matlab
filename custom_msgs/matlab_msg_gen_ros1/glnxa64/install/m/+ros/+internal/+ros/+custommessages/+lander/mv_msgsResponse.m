function [data, info] = mv_msgsResponse
%mv_msgs gives an empty data for lander/mv_msgsResponse
% Copyright 2019-2020 The MathWorks, Inc.
%#codegen
data = struct();
data.MessageType = 'lander/mv_msgsResponse';
[data.IsFinish, info.IsFinish] = ros.internal.ros.messages.ros.default_type('logical',1);
info.MessageType = 'lander/mv_msgsResponse';
info.constant = 0;
info.default = 0;
info.maxstrlen = NaN;
info.MaxLen = 1;
info.MinLen = 1;
info.MatPath = cell(1,1);
info.MatPath{1} = 'isFinish';
