function cal2d = cal2d(directory)
% directory using '' --- for location either 1 for calibration frames or 2
%for global reference frames markers

b=readtext([directory],'\t');
b=b(11,:);
b=cell2mat(b);

vector=b(1,1:2)-b(1,3:4);
% calculate the distance between the two points using hypot as the scale
% factor, the distance in the real world should be 1 meter
scale=hypot(vector(1),vector(2));

cal2d=[scale b(1,4)];

end