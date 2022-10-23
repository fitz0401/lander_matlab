function output = lieProduct(S1,S2)
    w1 = S1(1:3);
    w2 = S2(1:3);
    v1 = S1(4:6);
    v2 = S2(4:6);
    output = [cross(w1,w2); cross(w1,v2) + cross(v1,w2)];
end
