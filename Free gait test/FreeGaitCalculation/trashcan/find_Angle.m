function alpha = find_Angle(EndPos)

global BODY_FOR_CALU

alpha = atan2(EndPos(2) - BODY_FOR_CALU.Body(28,:), EndPos(1) - BODY_FOR_CALU.Body(23,:));

end