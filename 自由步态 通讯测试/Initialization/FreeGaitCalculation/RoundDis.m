% 把数字取整到dis(6.25)的倍数
function a = RoundDis(dis, a)
a = fix(a / dis) * dis;
end