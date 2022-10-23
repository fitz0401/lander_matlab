function result_RotX = funRotX(alpha)

result_RotX = [ 1       0            0
                0   cos(alpha)  -sin(alpha)
                0   sin(alpha)   cos(alpha) ];

end