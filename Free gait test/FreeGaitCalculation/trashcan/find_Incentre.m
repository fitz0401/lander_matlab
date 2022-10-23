% Copyright 20190715 written by Li Zi-Yue

function incentre = find_Incentre(X1,X2,X3)
% X1=[0,0];
% X2=[3,0];
% X3=[2,5];
a=norm(X2-X3);
b=norm(X1-X3);
c=norm(X2-X1);
incentre=[(a*X1(1)+b*X2(1)+c*X3(1))/(a+b+c),(a*X1(2)+b*X2(2)+c*X3(2))/(a+b+c)];

% X=[X1(1),X2(1),X3(1),X1(1)];
% Y=[X1(2),X2(2),X3(2),X1(2)];
% plot(X,Y); hold on
% plot(incentre(1),incentre(2),'ro');
% axis equal
end