function cal3d = cal3d(directorycal1,directorycal2,peak)

%Importing the data from camera one and arranging it appropriately for
%analysis
b=readtext([directorycal1],'\t');
b=b(11,:);
b=cell2mat(b);
c=b(1:64);
d=b(65:70);
c1=reshape(c,2,32)';
d11=reshape(d,2,3)';
%Importing the data from camera two and arranging it appropriately for
%analysis
b2=readtext([directorycal2],'\t');
b2=b2(11,:);
b2=cell2mat(b2);
c2=b2(1:64);
d2=b2(65:70);
c3=reshape(c2,2,32)';
d22=reshape(d2,2,3)';

%This function applies the direct linear transformation (DLT) to obtain the
%dlt parameters for posterior data transformation
camera1=dlt(peak,c1);
camera2=dlt(peak,c3);

%reconstruct the 3D locations of 32 calibration points using the parameters
TDcoordinate=Rec3D(camera1,c1,camera2,c3);

% calculate the calibration error, plot the true locations and calculated
% locations
res=dlt_res(peak,TDcoordinate,1);

% reconstruct the 3D location for the markers on the ground
RepoRC=Rec3D(camera1,d11,camera2,d22);


% extract each point - markers were positioned on the floor to serve as
% global reference frame
%aa= under the net - p1 , bb center - p2 and cc right p3
aa=RepoRC(1,:);
bb=RepoRC(2,:);
cc=RepoRC(3,:);

% calculate x, y, and z unit vectors for global reference frames using
% right-hand rule
x=unitvec(aa-bb);
mid=unitvec(cc-aa);
z=unitvec(cross(x,mid));
y=unitvec(cross(z,x));

% build marker reference frame using x, y, and z
RM(1,1:3)=x;
RM(2,1:3)=y;
RM(3,1:3)=z;

%adding all the relevant outputs to a matrix for posterior use.
emptymatrix=zeros([32 3 5]);
emptymatrix(1:3,1:3,1)=RepoRC;
emptymatrix(1:3,1:3,2)=RM;
emptymatrix(1:6,1:3,3)= [aa ; bb; cc; x; z; y];
emptymatrix(1:11,1,4)= camera1;
emptymatrix(1:11,2,4)= camera2;
emptymatrix(1:end,1,5)= res;

cal3d= emptymatrix;

end