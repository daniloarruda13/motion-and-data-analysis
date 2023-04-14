% using the 11 DLT parameters and data from two cameras
% to reconstruct the 3D coordinate data
function results=Rec3D(para1,data1,para2,data2);

% para1 is the 11 DLT parameters for camera 1 in one row, the caculation
% of DLT is using the x first then y
% data1 is the digitized x and y coordinate from camera 1, it is two columns
% with mutiple rows as frames
% similar for para 2 and data 2, just for cameras 2

% the output is the 3D reconstruted data 
% with mutiple rows as frames 

for i=1:length(data1(:,1));
    matrix1=[(data1(i,1).*para1(9)-para1(1)) (data1(i,1).*para1(10)-para1(2))...
        (data1(i,1).*para1(11)-para1(3)); (data1(i,2).*para1(9)-para1(5))...
        (data1(i,2).*para1(10)-para1(6)) (data1(i,2).*para1(11)-para1(7));...
        (data2(i,1).*para2(9)-para2(1)) (data2(i,1).*para2(10)-para2(2))...
        (data2(i,1).*para2(11)-para2(3)); (data2(i,2).*para2(9)-para2(5))...
        (data2(i,2).*para2(10)-para2(6)) (data2(i,2).*para2(11)-para2(7));];
    matrix2=[(para1(4)-data1(i,1)); (para1(8)-data1(i,2));...
        (para2(4)-data2(i,1)); (para2(8)-data2(i,2))];
    results(i,:)=inv((matrix1'*matrix1))*(matrix1'*matrix2);
end
    