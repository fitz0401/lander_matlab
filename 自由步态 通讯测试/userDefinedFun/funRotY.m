function result_RotY = funRotY(beta)

result_RotY = [ cos(beta)     0        sin(beta)
                   0          1           0
               -sin(beta)     0        cos(beta) ];

end