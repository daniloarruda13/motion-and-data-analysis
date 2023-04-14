function [adt] = firstcentral(a,sf)
%This function uses a first central difference method
%to differente discrete data sampled at sf.

  [nr,nc]=size(a);
  twodt= 2/sf; 
  
%Forward Difference to calculate the first frame
  adt(1,:)= (a(2,:)-a(1,:))/(1/sf);
%Backward Difference to calculate the last frame
  adt(nr,:)= (a(nr,:)-a(nr-1,:))/(1/sf);
%Central difference method
  for r=2:nr-1
    adt(r,:)=(a(r+1,:)-a(r-1,:))/twodt;
  end; %for r
end