
classdef mv_msgsResponse < ros.Message
    %mv_msgsResponse MATLAB implementation of msgs_packages/mv_msgsResponse
    %   This class was automatically generated by
    %   ros.internal.pubsubEmitter.
    %   Copyright 2014-2020 The MathWorks, Inc.
    properties (Constant)
        MessageType = 'msgs_packages/mv_msgsResponse' % The ROS message type
    end
    properties (Constant, Hidden)
        MD5Checksum = '6016345cd57c8634afed560eaaf81c72' % The MD5 Checksum of the message definition
        PropertyList = { 'IsFinish' } % List of non-constant message properties
        ROSPropertyList = { 'isFinish' } % List of non-constant ROS message properties
        PropertyMessageTypes = { '' ...
            } % Types of contained nested messages
    end
    properties (Constant)
    end
    properties
        IsFinish
    end
    methods
        function set.IsFinish(obj, val)
            validClasses = {'logical', 'numeric'};
            validAttributes = {'nonempty', 'scalar'};
            validateattributes(val, validClasses, validAttributes, 'mv_msgsResponse', 'IsFinish');
            obj.IsFinish = logical(val);
        end
    end
    methods (Static, Access = {?matlab.unittest.TestCase, ?ros.Message})
        function obj = loadobj(strObj)
        %loadobj Implements loading of message from MAT file
        % Return an empty object array if the structure element is not defined
            if isempty(strObj)
                obj = ros.msggen.msgs_packages.mv_msgsResponse.empty(0,1);
                return
            end
            % Create an empty message object
            obj = ros.msggen.msgs_packages.mv_msgsResponse(strObj);
        end
    end
end