function ans_funAdg = funAdg( g1 , g2 )
% 注：此处的Adg基于（v,w）形式的速度旋量
switch nargin
    case 1
        [m , n] = size(g1);
        if (m==4) && (n==4)
            R = g1(1:3,1:3);
            p = g1(1:3,4);
            pHat = [   0       -p(3)      p(2);
                      p(3)       0       -p(1);
                     -p(2)      p(1)       0   ];
            ans_funAdg = [    R         pHat * R;
                          zeros(3,3)        R    ] ;
        else
            disp ('wrong！！！funAdg函数中，若输入1个参数，则必须是4*4的g矩阵！')
        end
        
    case 2
        [m_g1 , n_g1] = size(g1);
        [m_g2 , n_g2] = size(g2);
        if ( m_g1==3 ) && ( n_g1==3 ) && ( m_g2==3 ) && ( n_g2==1 )
            R = g1 ; p = g2 ;
            pHat = [   0       -p(3)      p(2);
                      p(3)       0       -p(1);
                     -p(2)      p(1)       0   ];
            ans_funAdg = [    R         pHat * R;
                          zeros(3,3)        R    ] ;
        else
            disp ('wrong！！！funAdg函数中，若输入2个参数，则第1个参数必须是3*3的R矩阵，第二个参数必须是3*1的p矩阵！')
        end
        
    otherwise
        disp ('wrong！！！funAdg函数中，输入变量有误！')

end