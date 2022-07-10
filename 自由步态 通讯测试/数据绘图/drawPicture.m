clear;clc;close all
dbstop if error

table_before = dlmread('data_before.txt');
table_after = dlmread('data_after.txt');

%%

SM1 = zeros(2,length(table_before));
SM1(1,:) = linspace(1,length(SM1),length(SM1)); % 第一行用来画图，第二行是SM数据

for i = 1:length(table_before)
    if table_before(43,i) ~= 5
        % pt, v1, v2
        if table_before(43,i) == 1 || table_before(43,i) == 3
            num1 = 2; num2 = 4;
        elseif table_before(43,i) == 2 || table_before(43,i) == 4
            num1 = 1; num2 = 3;
        end
        SM1(2,i-1) = getdistance([table_before(32,i-1),table_before(37,i-1),0], [table_before(num1,i-1),table_before(num1+5,i-1),0], [table_before(num2,i-1),table_before(num2+5,i-1),0]);
        SM1(2,i) = getdistance([table_before(32,i),table_before(37,i),0], [table_before(num1,i),table_before(num1+5,i),0], [table_before(num2,i),table_before(num2+5,i),0]);
    end
end

SM2 = zeros(2,length(table_after));
SM2(1,:) = linspace(1,length(SM2),length(SM2)); % 第一行用来画图，第二行是SM数据

for i = 1:length(table_after)
    if table_after(43,i) ~= 5
        % pt, v1, v2
        if table_after(43,i) == 1 || table_after(43,i) == 3
            num1 = 2; num2 = 4;
        elseif table_after(43,i) == 2 || table_after(43,i) == 4
            num1 = 1; num2 = 3;
        end       
        SM2(2,i-1) = getdistance([table_after(32,i-1),table_after(37,i-1),0], [table_after(num1,i-1),table_after(num1+5,i-1),0], [table_after(num2,i-1),table_after(num2+5,i-1),0]);
        SM2(2,i) = getdistance([table_after(32,i),table_after(37,i),0], [table_after(num1,i),table_after(num1+5,i),0], [table_after(num2,i),table_after(num2+5,i),0]);
    end
end

SM1(:,end) = []; SM2(:,end) = [];

F21 = zeros(2,length(table_before));
F21(1,:) = linspace(1,length(F21),length(F21));
% F21(2,:) = table_before(44,:);
F22 = zeros(2,length(table_after));
F22(1,:) = linspace(1,length(F22),length(F22));
% F22(2,:) = table_after(44,:);

num = 1;
for i = 1:length(F21)
    if table_before(44,i) ~= 0
        F21(2,num) = table_before(44,i);
        num = num + 1;
    end
end
F21(:,num:end) = [];
num = 1;
for i = 1:length(F22)
    if table_after(44,i) ~= 0
        F22(2,num) = table_after(44,i);
        num = num + 1;
    end
end
F22(:,num:end) = [];

%% process data
ratio1 = 5500 / length(SM1);
ratio2 = 5500 / length(SM2);
SM1(1,:) = SM1(1,:) * ratio1;
SM2(1,:) = SM2(1,:) * ratio2;

ratio1 = 5500 / length(F21);
ratio2 = 5500 / length(F22);
F21(1,:) = F21(1,:) * ratio1;
F22(1,:) = F22(1,:) * ratio2;

%%

hold on
xlabel('Movement(mm)');
ylabel('Stable Margin(mm)');
L_before = plot(SM1(1,:),SM1(2,:),'Color','blue','LineWidth',2,'LineStyle','--');
L_after = plot(SM2(1,:),SM2(2,:),'Color','red','LineWidth',2);
legend([L_before, L_after],'Before','After');
hold off

figure
hold on
xlabel('Movement(mm)');
ylabel('F2(mm)');
L2_before = plot(F21(1,:),F21(2,:),'Color','blue','LineWidth',2,'LineStyle','--');
L2_after = plot(F22(1,:),F22(2,:),'Color','red','LineWidth',2);
legend([L2_before, L2_after],'Before','After');
hold off