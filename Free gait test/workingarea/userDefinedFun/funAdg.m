function ans_funAdg = funAdg( g1 , g2 )
% ע���˴���Adg���ڣ�v,w����ʽ���ٶ�����
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
            disp ('wrong������funAdg�����У�������1���������������4*4��g����')
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
            disp ('wrong������funAdg�����У�������2�����������1������������3*3��R���󣬵ڶ�������������3*1��p����')
        end
        
    otherwise
        disp ('wrong������funAdg�����У������������')

end