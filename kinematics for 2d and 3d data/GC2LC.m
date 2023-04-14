function [NewData] = GC2LC(origin,RM,olddata)
%This function transforms the kinematic markers in global to local
%coordinate

%origin is a [rows ], that is the local origin data in global
%coordinate
%RM is the three axis matrix for local coordinate
%olddata the marker coodinate is a rows X 3 in global coordinate

for i=1:length(olddata(:,1,1));
TM=  [[1 0 0 0];[origin' squeeze(RM(1:3,1:3))']];

TMinv = inv(TM);
DP = [1 olddata(i,:)]'; %DP = [1 ap ml v]
DPtrans = TMinv*DP;
NewData(i,:)= DPtrans(2:4);
end; %
