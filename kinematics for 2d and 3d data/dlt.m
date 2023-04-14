function ans=dlt(data1,data2)
% data1 are the known 3D coordinates 
% data 2 are the digitized 2D points
% ans is the 11 dlt parameters

for i=1:length(data1(:,1))
    mat1(i*2-1,1:3)=data1(i,:);
    mat1(i*2-1,4)=1;
    mat1(i*2-1,5:8)=0;
    mat1(i*2-1,9)=-data1(i,1)*data2(i,1);
    mat1(i*2-1,10)=-data1(i,2)*data2(i,1);
    mat1(i*2-1,11)=-data1(i,3)*data2(i,1);
    
    mat1(i*2,1:4)=0;
    mat1(i*2,5:7)=data1(i,:);
    mat1(i*2,8)=1;
    mat1(i*2,9)=-data1(i,1)*data2(i,2);
    mat1(i*2,10)=-data1(i,2)*data2(i,2);
    mat1(i*2,11)=-data1(i,3)*data2(i,2);
    
    mat2(i*2-1,1)=data2(i,1);
    mat2(i*2,1)=data2(i,2);
end

ans=inv((mat1'*mat1))*(mat1'*mat2);

    