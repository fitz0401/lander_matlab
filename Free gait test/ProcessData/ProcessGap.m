function gapData = ProcessGap(Gap)

gapData = zeros(length(Gap),6);
for i = 1:length(Gap)
    gapData(i,1:3) = [Gap(i).RectangleInitial 0];
    gapData(i,4:6) = [Gap(i).RectangleLengthWidth sum(Gap(i).Height)]; % 因为Height中边界一定为0，所以取sum即求出高度
end

end