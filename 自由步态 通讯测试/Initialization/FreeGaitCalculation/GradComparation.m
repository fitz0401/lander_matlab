% grad_comparation: 给定身体坐标，判断重心位置

function Num_Pos = GradComparation(BODY_FOR_CALU)
% 输出参数Body是一个10*n*m*p的矩阵，每一列都是五个点的坐标，初始时每一列相等

Num_Pos = strings(1,BODY_FOR_CALU.len_x,BODY_FOR_CALU.len_y);

% 所有的t都是逻辑矩阵
t_ACD = if_InTriangle(BODY_FOR_CALU.Body, 1, 3, 4);
t_BCD = if_InTriangle(BODY_FOR_CALU.Body, 2, 3, 4);
t_ABD = if_InTriangle(BODY_FOR_CALU.Body, 1, 2, 4);
t_ABC = if_InTriangle(BODY_FOR_CALU.Body, 1, 2, 3);
% 所有的D也是逻辑矩阵，若D<=SM则为正，反之则为假
D13 = find_Distance(BODY_FOR_CALU.Body, BODY_FOR_CALU.SM, 1, 3);
D24 = find_Distance(BODY_FOR_CALU.Body, BODY_FOR_CALU.SM, 2, 4);

Num_Pos(D13 & D24) = "OABCD";

Num_Pos(t_ACD & ~D13) = "OACD"; Num_Pos(t_BCD & ~D24) = "OBCD";
Num_Pos(t_ABD & ~D24) = "OABD"; Num_Pos(t_ABC & ~D13) = "OABC";

Num_Pos(t_ACD & t_BCD & ~D13 & ~D24) = "OCD"; Num_Pos(t_ACD & t_ABD & ~D13 & ~D24) = "OAD";
Num_Pos(t_ABD & t_ABC & ~D13 & ~D24) = "OAB"; Num_Pos(t_ABC & t_BCD & ~D13 & ~D24) = "OBC";
end