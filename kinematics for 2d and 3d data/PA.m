function phaseangle=PA(position,velocity)


% position=position data in one dimension

% sf=sampling frequency

% reference: Hamill, A dynamical systems approach to lower extremity
% running injuries THIS IS WRONG
%THIS METHOD IS THE SAME AS DESCRIBED BY CHIU CHOU 2012 - Effect of walking 
%speed on inter-joint coordination differs between young and elderly adults
%Or Li emmerick and Hamill 1999

velocity2=velocity/max(abs(velocity));


position2=2*(position-min(position))/(max(position)-min(position))-1;

figure(1)
plot(position2,velocity2)

%This 57.3 is 360/2pi, this is a normalization procedure to have values
%between -180 and +180
for i=1:length(position);

    if position2(i)>0 & velocity2(i)>0

        phaseangle(i)=atan(velocity2(i)/position2(i)).*57.3;

    elseif position2(i)<0 & velocity2(i)>0

        phaseangle(i)=180+atan(velocity2(i)/position2(i)).*57.3;

    elseif position2(i)<0 & velocity2(i)<0

        phaseangle(i)=180-atan(velocity2(i)/position2(i)).*57.3;

    elseif position2(i)>0 & velocity2(i)<0

        phaseangle(i)=abs(atan(velocity2(i)/position2(i)).*57.3);

    end 

% phaseangle(i)=atan(velocity2(i)/position2(i)).*180/pi;

end


end