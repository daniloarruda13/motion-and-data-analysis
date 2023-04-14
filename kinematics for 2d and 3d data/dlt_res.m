function anss=dlt_res(data1,data2,plot)
    % caculate the residues for dlt calibratino, data1 is the theoritical data position
    % data 2 is the reconstructed data position
    % plot the bar graph is plot is 1
    anss=sqrt(sum((data1-data2).*(data1-data2),2));
    
    if plot==1
        figure(1)
        plot3(data1(:,1),data1(:,2),data1(:,3),'ro','LineWidth',10,'MarkerSize',10)
        text(data1(:,1),data1(:,2),data1(:,3),['01';'02';'03';'04';'05';'06';'07';'08';'09';'10';...
            '11';'12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';'24';'25';'26';'27';'28';'29';'30';...
            '31';'32'])
        hold on
        plot3(data2(:,1),data2(:,2),data2(:,3),'bo','LineWidth',10,'MarkerSize',10)
        
        figure(2)
        bar(anss)
    end
    
end
