function result_TRotZ = funTRotZ(gama)

result_TRotZ = [ cos(gama)     -sin(gama)     0    0
                 sin(gama)      cos(gama)     0    0
                     0             0          1    0
                     0             0          0    1 ];

end