function Out_VectorHat=funVectorHat(In_VectorHat)

    [m,n] = size(In_VectorHat);
    if (m==3) && (n==1)
        Out_VectorHat=[       0            -In_VectorHat(3)      In_VectorHat(2);
                       In_VectorHat(3)            0             -In_VectorHat(1);
                      -In_VectorHat(2)      In_VectorHat(1)             0       ];
    else        
        disp('input is wrong ! ')
    end

end