
classdef gait_plan_msgs < ros.Message
    %gait_plan_msgs MATLAB implementation of lander/gait_plan_msgs
    %   This class was automatically generated by
    %   ros.internal.pubsubEmitter.
    %   Copyright 2014-2020 The MathWorks, Inc.
    properties (Constant)
        MessageType = 'lander/gait_plan_msgs' % The ROS message type
    end
    properties (Constant, Hidden)
        MD5Checksum = 'b401d108fe4e07f912067db7a9916b5e' % The MD5 Checksum of the message definition
        PropertyList = { 'CommandIndex' 'LegIndex' 'Foot1Motion' 'Foot2Motion' 'Foot3Motion' 'Foot4Motion' 'DataNum' 'Foot1TraceX' 'Foot1TraceY' 'Foot1TraceZ' 'Foot2TraceX' 'Foot2TraceY' 'Foot2TraceZ' 'Foot3TraceX' 'Foot3TraceY' 'Foot3TraceZ' 'Foot4TraceX' 'Foot4TraceY' 'Foot4TraceZ' } % List of non-constant message properties
        ROSPropertyList = { 'command_index' 'leg_index' 'foot1_motion' 'foot2_motion' 'foot3_motion' 'foot4_motion' 'data_num' 'foot1_trace_x' 'foot1_trace_y' 'foot1_trace_z' 'foot2_trace_x' 'foot2_trace_y' 'foot2_trace_z' 'foot3_trace_x' 'foot3_trace_y' 'foot3_trace_z' 'foot4_trace_x' 'foot4_trace_y' 'foot4_trace_z' } % List of non-constant ROS message properties
        PropertyMessageTypes = { '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            '' ...
            } % Types of contained nested messages
    end
    properties (Constant)
    end
    properties
        CommandIndex
        LegIndex
        Foot1Motion
        Foot2Motion
        Foot3Motion
        Foot4Motion
        DataNum
        Foot1TraceX
        Foot1TraceY
        Foot1TraceZ
        Foot2TraceX
        Foot2TraceY
        Foot2TraceZ
        Foot3TraceX
        Foot3TraceY
        Foot3TraceZ
        Foot4TraceX
        Foot4TraceY
        Foot4TraceZ
    end
    methods
        function set.CommandIndex(obj, val)
            validClasses = {'numeric'};
            validAttributes = {'nonempty', 'scalar'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'CommandIndex');
            obj.CommandIndex = int32(val);
        end
        function set.LegIndex(obj, val)
            validClasses = {'numeric'};
            validAttributes = {'nonempty', 'scalar'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'LegIndex');
            obj.LegIndex = int32(val);
        end
        function set.Foot1Motion(obj, val)
            validClasses = {'numeric'};
            val = val(:);
            validAttributes = {'vector', 'numel', 3};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot1Motion');
            obj.Foot1Motion = double(val);
        end
        function set.Foot2Motion(obj, val)
            validClasses = {'numeric'};
            val = val(:);
            validAttributes = {'vector', 'numel', 3};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot2Motion');
            obj.Foot2Motion = double(val);
        end
        function set.Foot3Motion(obj, val)
            validClasses = {'numeric'};
            val = val(:);
            validAttributes = {'vector', 'numel', 3};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot3Motion');
            obj.Foot3Motion = double(val);
        end
        function set.Foot4Motion(obj, val)
            validClasses = {'numeric'};
            val = val(:);
            validAttributes = {'vector', 'numel', 3};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot4Motion');
            obj.Foot4Motion = double(val);
        end
        function set.DataNum(obj, val)
            validClasses = {'numeric'};
            validAttributes = {'nonempty', 'scalar'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'DataNum');
            obj.DataNum = int32(val);
        end
        function set.Foot1TraceX(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot1TraceX');
            obj.Foot1TraceX = double(val);
        end
        function set.Foot1TraceY(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot1TraceY');
            obj.Foot1TraceY = double(val);
        end
        function set.Foot1TraceZ(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot1TraceZ');
            obj.Foot1TraceZ = double(val);
        end
        function set.Foot2TraceX(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot2TraceX');
            obj.Foot2TraceX = double(val);
        end
        function set.Foot2TraceY(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot2TraceY');
            obj.Foot2TraceY = double(val);
        end
        function set.Foot2TraceZ(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot2TraceZ');
            obj.Foot2TraceZ = double(val);
        end
        function set.Foot3TraceX(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot3TraceX');
            obj.Foot3TraceX = double(val);
        end
        function set.Foot3TraceY(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot3TraceY');
            obj.Foot3TraceY = double(val);
        end
        function set.Foot3TraceZ(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot3TraceZ');
            obj.Foot3TraceZ = double(val);
        end
        function set.Foot4TraceX(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot4TraceX');
            obj.Foot4TraceX = double(val);
        end
        function set.Foot4TraceY(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot4TraceY');
            obj.Foot4TraceY = double(val);
        end
        function set.Foot4TraceZ(obj, val)
            validClasses = {'numeric'};
            if isempty(val)
                % Allow empty [] input
                val = double.empty(0, 1);
            end
            val = val(:);
            validAttributes = {'vector'};
            validateattributes(val, validClasses, validAttributes, 'gait_plan_msgs', 'Foot4TraceZ');
            obj.Foot4TraceZ = double(val);
        end
    end
    methods (Static, Access = {?matlab.unittest.TestCase, ?ros.Message})
        function obj = loadobj(strObj)
        %loadobj Implements loading of message from MAT file
        % Return an empty object array if the structure element is not defined
            if isempty(strObj)
                obj = ros.msggen.lander.gait_plan_msgs.empty(0,1);
                return
            end
            % Create an empty message object
            obj = ros.msggen.lander.gait_plan_msgs(strObj);
        end
    end
end
