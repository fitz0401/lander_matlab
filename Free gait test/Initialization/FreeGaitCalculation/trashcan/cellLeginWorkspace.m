% 只要(a,b)中元素存在(0,0)，这一项置true
function bit = cellLeginWorkspace(a, b)
bit = ~isempty(find((abs(a) <= BODY_FOR_CALU.Inteval/2 & abs(b) <= BODY_FOR_CALU.Inteval/2) == 1, 1));
% mapxy3d = abs(mapx3d) <= BODY_FOR_CALU.Inteval/2 & abs(mapy3d) <= BODY_FOR_CALU.Inteval/2;
end