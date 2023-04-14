function output = RPA(data1,data2)

% calculate relative phase angle based on two phase angles

% the input of phase angle should have a range of 0 to 360

% the output of relative phase angle will have a range o -180 to 180.

    for n=1:length(data1)

        if (data1(n)>=data2(n))&&((data1(n)-data2(n))<=180)

            output(n)=data1(n)-data2(n);

        elseif (data1(n)>data2(n))&&((data1(n)-data2(n))>180)

            output(n)=-(360-(data1(n)-data2(n)));

        elseif (data2(n)>=data1(n))&&((data2(n)-data1(n))<=180)

            output(n)=-(data2(n)-data1(n));

        elseif (data2(n)>data1(n))&&((data2(n)-data1(n))>180)

            output(n)=(360-(data2(n)-data1(n)));

        end

    end

end