function plotcube(varargin)
% PLOTCUBE - Display a 3D-cube in the current axes
%
%   PLOTCUBE(EDGES,ORIGIN,ALPHA,COLOR) displays a 3D-cube in the current axes
%   with the following properties:
%   * EDGES : 3-elements vector that defines the length of cube edges
%   * ORIGIN: 3-elements vector that defines the start point of the cube
%   * ALPHA : scalar that defines the transparency of the cube faces (from 0
%             to 1)
%   * COLOR : 3-elements vector that defines the faces color of the cube
%
% Example:
%   >> plotcube([5 5 5],[ 2  2  2],.8,[1 0 0]);
%   >> plotcube([5 5 5],[10 10 10],.8,[0 1 0]);
%   >> plotcube([5 5 5],[20 20 20],.8,[0 0 1]);

% Default input arguments
inArgs = { ...
    [10 56 100] , ... % Default edge sizes (x,y and z)
    [10 10  10] , ... % Default coordinates of the origin point of the cube
    .7          , ... % Default alpha value for the cube's faces
    [1 0 0]       ... % Default Color for the cube faces
    };

% Replace default input arguments by input values
inArgs(1:nargin) = varargin;
if nargin ~= 5
    inArgs{5} = inArgs{4}; % Default Color for the edge, equal to faces
end

originPoint = inArgs{2}; lenWidHig = inArgs{1};
alphaValue = inArgs{3}; faceColor = inArgs{4}; edgeColor = inArgs{5};

% Vertices:8个顶点，每一行存储(x,y,z)，共8行
% Faces:6个面，每一行存储连接哪几个顶点，长方体当然是4个，共6行
vertices = [originPoint; 
    originPoint + [lenWidHig(1) 0 0]; 
    originPoint + [0 lenWidHig(2) 0]; 
    originPoint + [lenWidHig(1) lenWidHig(2) 0];
    originPoint + [0 0 lenWidHig(3)]; 
    originPoint + [lenWidHig(1) 0 lenWidHig(3)]; 
    originPoint + [0 lenWidHig(2) lenWidHig(3)]; 
    originPoint + lenWidHig];
faces = [1 2 4 3;
    5 6 8 7;
    1 5 7 3
    1 2 6 5
    2 4 8 6
    3 4 8 7];

patch('faces',faces,'vertices',vertices,'facecolor',faceColor,'edgecolor',edgeColor,'facealpha',alphaValue);

end
