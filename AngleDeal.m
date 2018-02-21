clc
clear

excel_cell_position = 'A31:D31';
excel_address = 'G:\WORK\project\Robot\finger\analysis\matlab\Computer Vision\finger2\finger2.xlsx';
oriAngle = textread('angle.txt');
dataSize = size(oriAngle);
newAngle = zeros(dataSize);
newAngle(:,1) = oriAngle(:,1);
for i=1:(dataSize(1)-1)
    newAngle(i+1,2:4) = oriAngle(i+1,2:4)-oriAngle(1,2:4);
end
dlmwrite('newAngle.txt',newAngle,'delimiter','\t','newline','pc','-append');%加一个append参数即可
subplot(2,2,1)
plot(newAngle(:,2),newAngle(:,3))
title('关节1和关节2')
xlabel('关节1')
ylabel('关节2')
subplot(2,2,2)
plot(newAngle(:,3),newAngle(:,4))
title('关节2和关节3')
xlabel('关节2')
ylabel('关节3')
subplot(2,2,3)
plot(newAngle(:,2),newAngle(:,4))
title('关节1和关节3')
xlabel('关节1')
ylabel('关节3')
saveas(gcf,'线段图.png')

sizeAngle = size(newAngle);
figure
t1 = 0:0.5:max(newAngle(:,2));
t2 = 0:0.5:max(newAngle(:,3));
P12 = polyfit(newAngle(:,2),newAngle(:,3),3);
theta12_2 = polyval(P12,t1);
subplot(2,2,1);
plot(t1,theta12_2)
title('关节1和关节2')
xlabel('关节1')
ylabel('关节2')

P23 = polyfit(newAngle(:,3),newAngle(:,4),3);
theta23_3 = polyval(P23,t2);
subplot(2,2,2);
plot(t2,theta23_3)
title('关节2和关节3')
xlabel('关节2')
ylabel('关节3')

P13 = polyfit(newAngle(:,2),newAngle(:,4),3);
theta13_3 = polyval(P13,t1);
subplot(2,2,3);
plot(t1,theta13_3)
title('关节1和关节3')
xlabel('关节1')
ylabel('关节3')
saveas(gcf,'拟合图.png')

fun12 = ['fun12 = ',num2str(P12(1)),' x^3 + ',num2str(P12(2)),' x^2 + ',num2str(P12(3)),' x^1 + ',num2str(P12(4))];
dlmwrite('fun.txt',fun12,'delimiter','','newline','pc','-append')
fun13 = ['fun13 = ',num2str(P13(1)),' x^3 + ',num2str(P13(2)),' x^2 + ',num2str(P13(3)),' x^1 + ',num2str(P13(4))];
dlmwrite('fun.txt',fun13,'delimiter','','newline','pc','-append')
fun23 = ['fun23 = ',num2str(P23(1)),' x^3 + ',num2str(P23(2)),' x^2 + ',num2str(P23(3)),' x^1 + ',num2str(P23(4))];
dlmwrite('fun.txt',fun23,'delimiter','','newline','pc','-append')

header=cell(1,4);
header{1,1}='x^3';header{1,2}='x^2';header{1,3}='x';header{1,4}='常数';
xlswrite(excel_address,header,'fun12','A1:D1');
xlswrite(excel_address,P12,'fun12',excel_cell_position);
xlswrite(excel_address,header,'fun13','A1:D1');
xlswrite(excel_address,P13,'fun13',excel_cell_position);
xlswrite(excel_address,header,'fun23','A1:D1');
xlswrite(excel_address,P23,'fun23',excel_cell_position);