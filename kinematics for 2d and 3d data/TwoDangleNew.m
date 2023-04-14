%The vector should be a unit vector
function finalresults = TwoDangleNew(a,b);
    for i=1:length(a(:,1));
    results(i,:)=vrrotvec(a(i,:),b(i,:));  %This calculates the rotation between two vectors
    end
    finalresults=results(:,4)*180/pi;
end