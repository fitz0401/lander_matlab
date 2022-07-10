% GenerateRandMat：生成随机矩阵
% 无输入，输出一个随机数组成的5*2 double array

function Mat = GenerateRandMat

Ax = 1100 + (1200-1000)*rand; Ay = -2400 + ((-2200)-(-2400))*rand;
Bx = 1000 + (1300-1000)*rand; By = 1000 + (1300-1000)*rand;
Cx = -2550 + ((-2250)-(-2550))*rand; Cy = 1100 + (1400-1100)*rand;
Dx = -2500 + ((-2100)-(-2500))*rand; Dy = -2500 + ((-2100)-(-2500))*rand;
Gx = -800 + ((-400)-(-800))*rand; Gy = -700 + ((-300)-(-700))*rand;

Mat = [Ax,Ay; Bx,By; Cx,Cy; Dx,Dy; Gx,Gy];