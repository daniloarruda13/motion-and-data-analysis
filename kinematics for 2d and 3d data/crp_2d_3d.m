
sf=59.97;  %This was the camera sample frequency
dostick2=2; % Boolean indicating whether an animated figure should be generated or not (1=yes, 2=no)

%This is the directory with the files to be analized: MQA files (video
%coordinates) and calibration frame coordinates (PEAK32)
dir='C:\Users\danil\Documents\GitHub\FOAinVolleyball\crp_2d_3d\files\';

%Importing the calibration frame in real-world coordinates
peak=xlsread([dir,'PEAK32.xlsx']); %#ok<XLSRD>
%3D Calibration
%Cal3d is a customized fuction that uses the calibration frame from two
%cameras, compares them to the real world frame, and transforms the 2D data
%from the cameras to 3D with a real world scale. The function returns the
%parameters and information about the global reference frame.

test110312020=cal3d([dir,'c1cal10.31.2020.mqa'],[dir,'c2cal10.31.2020.mqa'],peak);
test110312020b=cal3d([dir,'c1cal10.31.2020.b.mqa'],[dir,'c2cal10.31.2020.b.mqa'],peak);
test211142020=cal3d([dir,'c1cal11.14.2020.mqa'],[dir,'c2cal11.14.2020.mqa'],peak);
test312032020=cal3d([dir,'c1cal12.03.2020.mqa'],[dir,'c2cal12.03.2020.mqa'],peak);
test401302021=cal3d([dir,'c1cal1.30.2021.mqa'],[dir,'c2cal1.30.2021.mqa'],peak);
test401302021b=cal3d([dir,'c1cal1.30.2021b.mqa'],[dir,'c2cal1.30.2021b.mqa'],peak);
test501312021=cal3d([dir,'c1cal01.31.2021.mqa'],[dir,'c2cal01.31.2021.mqa'],peak);
test602062021=cal3d([dir,'c1cal02062021.mqa'],[dir,'c2cal02062021.mqa'],peak);
test702202021=cal3d([dir,'c1cal02202021.mqa'],[dir,'c2cal02202021.mqa'],peak);
test802272021=cal3d([dir,'c1cal02272021.mqa'],[dir,'c2cal02272021.mqa'],peak);


%Camera 3: 2D Calibration coordinates output=scale and marks on thefloor

test12D10312020=cal2d([dir,'c3cal10.31.2020.mqa']);
test22D11142020=cal2d([dir,'c3cal11.14.2020.mqa']);
test32D12032020=cal2d([dir,'c3cal12.03.2020.mqa']);
test42D1302021=cal2d([dir,'c3cal1.30.2021.mqa']);
test52D01312021=cal2d([dir,'c3cal01.31.2021.mqa']);
test62D02062021=cal2d([dir,'c3cal02062021.mqa']);
test72D02202021=cal2d([dir,'c3cal02202021.mqa']);
test82D02272021=cal2d([dir,'c3cal02272021.mqa']);

%With all the transformation needed, we can start analyzing the subjects
%data.
%A for loop was designed to bring files according to the following coding:

% Example of coding: c2n1ai1
%first two letters either c1 or c2 (cameras)
%third letter is their level: either n (novice) or v (volleyball player)
%fourth letter is  the participant number 1 to n
%fifth order of the test either a = internal then external or b= external
%then internal
%sixth is the manipulated condition: c=control e=external i=internal
%seventh is the trial eg. 1,2,3,4 or 5
for cam=1:2
    for lev=1:3
        if lev==1
            level='n';
        elseif lev==2
            level='v';
        elseif lev==3
            level='c';
        end
        for par=1:32
            partt=[1 2 3 4 5 6 7 8 10 14 16 15 39 41 32 38 ...   % those were the participants used for the the paper/thesis.
                35 12 13 18 19 20 22 23 24 28 29 30 37 17 36 33]; %The other participants were not included because of inclusion criteria. (sex and experience)
            partt=partt(par);
            
            for ord=1:2
                if ord==1
                    order='a';
                elseif ord==2
                    order='b';
                end
                for con=1:3
                    if con==1
                        condition='c';
                    elseif con==2
                        condition='i';
                    elseif con==3
                        condition='e';
                        
                    end
                    for tri=1:5
                        
                        %Storing info about each individual to be exported
                        %later
                        Level=lev;
                        partticipant=par;
                        Order=ord;
                        Condition=con;
                        Trial=tri;
                                     
                        
                        %  Checking if file exists, otherwise just move on
                        %  to the next loop
                        %
                        if exist([dir, level num2str(partt) order condition num2str(tri) '.mqa'],'file')==2
                            file=1;
                        else
                            file=0;
                        end
                        
                        %file=isfile(['D:\OneDrive - University of Wyoming\OFFICIAL DATA COLECTION\MAXTRAQ FILES\' level num2str(par) order condition num2str(tri) '.mqa'])
                        if(file==0)
                            break
                        end
                        
                        %Importing 2D data first
                        twoD=readtext([dir, level num2str(partt) order condition num2str(tri) '.mqa'],'\t');
                        
                        
                        %extracting the score that was stored with the 2D
                        %coordinates
                        score=twoD(10,3);
                        score=cell2mat(score);
                        
                        %Extracting ball trajectory (x and y, time series
                        %data)
                        twoD=twoD(11:end,1:2);
                        ball=cell2mat(twoD);
                        
                        %Assigning transforming the data to real
                        %coordinates using the calibration recording. Since
                        %each data collection contains a different
                        %calibration recording, we have to determine what
                        %calibration recording was used for each
                        %participant.

                        if partt==1 || partt==2 || partt==3 || partt==4
                            ball=(ball/test12D10312020(1));
                            floorref=test12D10312020(2)/test12D10312020(1);
                        elseif partt==5 || partt==6 || partt==7|| partt==8|| partt==9
                            ball=(ball/test22D11142020(1));
                            floorref=test22D11142020(2)/test22D11142020(1);
                        elseif partt==10 || partt==11 || partt==12|| partt==13
                            ball=(ball/test32D12032020(1));
                            floorref=test32D12032020(2)/test32D12032020(1);
                        elseif partt==14 || partt==15 || partt==16|| partt==17|| partt==18 || partt==19 ||partt==20 || partt==21
                            ball=(ball/test42D1302021(1));
                            floorref=test42D1302021(2)/test42D1302021(1);
                        elseif partt==22 || partt==23
                            ball=(ball/test52D01312021(1));
                            floorref=test52D01312021(2)/test52D01312021(1);
                        elseif partt==24 || partt==25 || partt==26|| partt==27|| partt==28 || partt==29|| partt==30
                            ball=(ball/test62D02062021(1));
                            floorref=test62D02062021(2)/test62D02062021(1);
                        elseif partt==31 || partt==32 || partt==33|| partt==34|| partt==35 || partt==36|| partt==37
                            ball=(ball/test72D02202021(1));
                            floorref=test72D02202021(2)/test72D02202021(1);
                        elseif (partt==38) || (partt==39) || (partt==40)|| (partt==41)
                            ball=(ball/test82D02272021(1));
                            floorref=test82D02272021(2)/test82D02272021(1);  
                        end

                        % Importing data from camera 1 for 3D analysis
                        
                        d1=readtext([dir,'c1' level num2str(partt) order condition num2str(tri) '.mqa'],'\t','','','empty2zero');
                        contact=d1(11:end,25);    %This is column in which we tracked only the participant touched the ball to set
                        contact=cell2mat(contact);
                        d1=d1(11:end,1:24);
                        emptyc1=cellfun(@isempty,d1);
                        
                        if any(emptyc1(:))
                            error('Missing Data') %checking whether there is missing data.
                        end
                        d1=cell2mat(d1);

                        % read data from Camera 2 for 3D analysis%
                        
                        d2=readtext([dir,'c2' level num2str(partt) order condition num2str(tri) '.mqa'],'\t','','','empty2zero');    
                        d2=d2(11:end,:);
                        emptyc2=cellfun(@isempty,d2);
                        if any(emptyc2(:))
                            error('Missing Data') %checking whether there is missing data. 
                        end
                        
                        d2=cell2mat(d2); %Converting it to matrix to allow computations
                        
                        %Normalizing the data to 100 data points, this way
                        %it's possible to compare subjects
                        d1= imresize(d1,[100,24],'bilinear');
                        d2= imresize(d2,[100,24],'bilinear');
                        
                        %Assigning calibration frames
                        if partt < 4
                            b1=test110312020(1:11,1,4);
                            b2=test110312020(1:11,2,4);
                            aa=test110312020(1,1:3,3);
                            RM=test110312020(1:3,1:3,2);
                        elseif partt==4 && con==3
                            b1=test110312020b(1:11,1,4);
                            b2=test110312020b(1:11,2,4);
                            aa=test110312020b(1,1:3,3);
                            RM=test110312020b(1:3,1:3,2);
                        elseif partt==4 && con==1 || partt==4 && con==2
                            b1=test110312020(1:11,1,4);
                            b2=test110312020(1:11,2,4);
                            aa=test110312020(1,1:3,3);
                            RM=test110312020(1:3,1:3,2);
                        elseif partt > 4 || partt < 10
                            b1=test211142020(1:11,1,4);
                            b2=test211142020(1:11,2,4);
                            aa=test211142020(1,1:3,3);
                            RM=test211142020(1:3,1:3,2);
                        elseif partt > 9 || partt<14
                            b1=test312032020(1:11,1,4);
                            b2=test312032020(1:11,2,4);
                            aa=test312032020(1,1:3,3);
                            RM=test312032020(1:3,1:3,2);
                        elseif partt==14 || partt==15 || (partt==16 && con==1) || (partt==16 &&con==3 &&tri<2)
                            b1=test401302021(1:11,1,4);
                            b2=test401302021(1:11,2,4);
                            aa=test401302021(1,1:3,3);
                            RM=test401302021(1:3,1:3,2);
                            
                        elseif (partt==16 &&con==2) || (partt==16 && con==3 &&tri>2) || partt==17 ||partt==18 ...
                                || partt==19 || partt==20 || partt==21
                            b1=test401302021b(1:11,1,4);
                            b2=test401302021b(1:11,2,4);
                            aa=test401302021b(1,1:3,3);
                            RM=test401302021b(1:3,1:3,2);
                            
                        elseif partt==22 || partt==23
                            b1=test501312021(1:11,1,4);
                            b2=test501312021(1:11,2,4);
                            aa=test501312021(1,1:3,3);
                            RM=test501312021(1:3,1:3,2);
                            
                        elseif partt> 23 || partt<31
                            b1=test602062021(1:11,1,4);
                            b2=test602062021(1:11,2,4);
                            aa=test602062021(1,1:3,3);
                            RM=test602062021(1:3,1:3,2);
                            
                        elseif partt>30 ||  partt<38
                            b1=test702202021(1:11,1,4);
                            b2=test702202021(1:11,2,4);
                            aa=test702202021(1,1:3,3);
                            RM=test702202021(1:3,1:3,2);
                            
                        elseif partt>37 || partt<42
                            b1=test802272021(1:11,1,4);
                            b2=test802272021(1:11,2,4);
                            aa=test802272021(1,1:3,3);
                            RM=test802272021(1:3,1:3,2);
                        end
                        
                        %transforming the data from the two cameras to 3D
                        %coordinates
                        for i=1:length(d2(1,:))/2
                            markers(:,:,i)=Rec3D(b1,d1(:,2*i-1:2*i),b2,d2(:,2*i-1:2*i)); %#ok<SAGROW>
                        end
                        
                        %transforming the data to the local coordinate
                        %system, using the markers and the rotational
                        %matrix
                        for ii=1:length(markers(1,1,:))
                            new_markers(:,:,ii)=GC2LC(aa,RM,markers(:,:,ii)); %#ok<SAGROW>
                        end

                        %Filtering the 3D data
                        for i=1:12
                            new_markers(:,:,i)=filterdata(new_markers(:,:,i),sf,0,7.14,2,0);
                        end
                        %Filtering the 2D data
                        ball=filterdata(ball,sf,0,7.14,2,0);

                        %adding the height of the global points on the
                        %floor. The markers on the floor were a bit
                        %elevated. To compensate for that we are adding
                        %12cm to the y axis (up-down)
                        new_markers(:,3,:)=new_markers(:,3,:)+0.012;
                        
                        
                        %% ANALYSING the 2D data
                        
                        % %Time of the ball contact in %
                        %finding when the participant made contact with the
                        %ball
                        firstnumber=find(contact>0);      %this scans the column and finds when there is data (participant contacted the ball)
                        ballcontact=(firstnumber(1)/length(contact))*100;

                        
                        %calculating ball velocity at the release (using the first contact until 10th frame)
                        bv=firstcentral(ball,sf); %calculating velocity for x and y
                        bvv=sqrt((bv(1:end,1).^2+bv(1:end,2).^2)); %calculating resultant velocity
                        releasevelocity=max(bvv(1:10)); %getting the velocity at the release point
                        
                        %release angle
                        [junk,index]=max(bvv(1:15)); %getting the index that had the maximum velocity
                        releaseangle=rad2deg(-atan(bv(index,2)/bv(index,1))); %obtaining the angle at the same frame used in getting the max vel.
                        
                        % Highest point
                        %Getting the max Y frame (height) of the ball trajectory
                        %max Y value from the ball - a Y value from the floor (I digitized a point
                        %on the floor)
                        
                        %partticipants who set the ball out of the camera
                        %view. That means that we have empty cells that
                        %need to be populated
                        %We approximate the maximum ball height using
                        %projectile motion equations..
                        %(https://en.wikipedia.org/wiki/Projectile_motion)
                        if (partt==37) && (con==2) && (tri==2) %retrieving the trial that the ball went out of the camera view
                            highestpoint=heightset(ball(1,1),ball(1,2),releasevelocity,releaseangle)-floorref;
                        elseif (partt==37) && (con==2) && (tri==4)
                            highestpoint=heightset(ball(1,1),ball(1,2),releasevelocity,releaseangle)-floorref;
                        else
                            highestpoint=max(ball(1:end,2))-floorref;
                        end
                       

                        %% ANALYSING 3D DATA
                        
                        %Ball retention time (in sec)
                        rettime=sum((contact)~=0)/sf;
                        
                        %extracting and labeling the markers (R=Right and
                        %L=left)
                        RANKLE=new_markers(:,:,1);
                        RKNEE=new_markers(:,:,2);
                        hipr=new_markers(:,:,3);  %This will be further processed later
                        RSHOULDER=new_markers(:,:,4);
                        RELBOW=new_markers(:,:,5);
                        RWRIST=new_markers(:,:,6);
                        LANKLE=new_markers(:,:,7);
                        LKNEE=new_markers(:,:,8);
                        hipl=new_markers(:,:,9); %This will be further processed later
                        LSHOULDER=new_markers(:,:,10);
                        LELBOW=new_markers(:,:,11);
                        LWRIST=new_markers(:,:,12);
                        
                        %Instead of using the real digitizing point at the
                        %side of the hip, we are creating a mid point,
                        %which is more inside (1/4) that the real point
                        RHIP=(hipr*0.75)+(hipl*0.25);
                        LHIP=(hipl*0.75)+(hipr*0.25);
                        
                        %Just creating a net as reference when checking the
                        %animation
                        net1=repmat ([0 1 0],100,1);
                        net2=repmat ([0 -1 0],100,1);
                        net3=repmat ([0 1 2],100,1);
                        net4=repmat ([0 -1 2],100,1);
                        
                        %This generates an animation of the movement. 
                        if dostick2==1
                            StickFigure1([RANKLE LANKLE RKNEE LKNEE RELBOW LELBOW RWRIST LWRIST RHIP LHIP RSHOULDER LSHOULDER],...
                                [1,3;3,9;9,11;11,5;5,7;2,4;4,10;10,12;12,6;6,8;9,10;11,12],[],[],[1 0 0],[-1 1 -1 1 0 2],2);
                            StickFigure1([RANKLE LANKLE RKNEE LKNEE RELBOW LELBOW RWRIST LWRIST RHIP LHIP RSHOULDER LSHOULDER],...
                                [1,3;3,9;9,11;11,5;5,7;2,4;4,10;10,12;12,6;6,8;9,10;11,12],[],[],[0 1 0],[-1 1 -1 1 0 2],2);
                            StickFigure1([RANKLE LANKLE RKNEE LKNEE RELBOW LELBOW RWRIST LWRIST RHIP LHIP RSHOULDER LSHOULDER],...
                                [1,3;3,9;9,11;11,5;5,7;2,4;4,10;10,12;12,6;6,8;9,10;11,12],[],[],[],[-1 1 -1 1 0 2],2);

                        end
                        
                        
                        %% Creating vectors 


                        %creating unitvectors (magnitude =1) with the
                        %digitized markers

                        %Shank RIGHT
                        Rs=unitvec(RANKLE-RKNEE);
                        %Thigh RIGHT
                        Rt=unitvec(RKNEE-RHIP);
                        %Shank LEFT
                        Ls=unitvec(LKNEE-LANKLE);
                        %Thigh LEFT
                        Lt=unitvec(LHIP-LKNEE);
                        %Forearm RIGHT
                        Rf=unitvec(RWRIST-RELBOW);
                        %Upper Arm Right
                        Ra=unitvec(RELBOW-RSHOULDER);
                        %Forearm LEFT
                        Lf=unitvec(LWRIST-LELBOW);
                        %Upper Arm Left
                        La=unitvec(LELBOW-LSHOULDER);
                        %Shoulder
                        SHOULDERVEC=unitvec(RSHOULDER-LSHOULDER);
                        %Static Vector for shoulder  using the first frame. This vector is used as a
                        %reference to get the rotations
                        globaly=unitvec(repmat ([1 1 0],100,1)-repmat ([1 0 0],100,1));
                        vecshoudSTAT=repmat((SHOULDERVEC(1,:)),(length(SHOULDERVEC)),1);
                        %Hip
                        HIPVEC=unitvec(RHIP-LHIP);
                        %Static vector for hip using the first frame
                        hipvectorSTAT=repmat((HIPVEC(1,:)),(length(HIPVEC)),1);
                        
                        %% Getting angles
                        %This below requires Simulink 3D Animation.
                        %Right Knee angle
                        Rknee= TwoDangleNew(Rt,Rs);
                        ALLRknee(:,tri,con)=Rknee;      
                        %Left knee angle
                        Lknee= TwoDangleNew(Lt,Ls);
                        ALLLknee(:,tri,con)=Lknee;
                        %Right elbow angle
                        Relbow= TwoDangleNew(Ra,Rf);
                        ALLRelbow(:,tri,con)=Relbow;
                        %Left elbow angle
                        Lelbow= TwoDangleNew(La,Lf);
                        ALLLelbow(:,tri,con)=Lelbow;
                        %Shoulder rotation
                        shouldrot=TwoDangleNew(SHOULDERVEC,globaly);
                        ALLshouldrot(:,tri,con)=shouldrot;
                        hiprot=TwoDangleNew(HIPVEC,globaly);
                        ALLhiprot(:,tri,con)=hiprot;
                        angleelbowcontact=mean([Relbow(round(ballcontact),:) Lelbow(round(ballcontact),:)]);
                       
                        
                        %% Getting angular velocity
                        %Right Knee
                        Rkneevel=firstcentral(Rknee,sf);
                        ALLRkneevel(:,tri,con,par)=Rkneevel;
                        %Left Knee
                        Lkneevel=firstcentral(Lknee,sf);
                        ALLLkneevel(:,tri,con,par)=Lkneevel;
                        %Right Elbow
                        Relbowvel=firstcentral(Relbow,sf);
                        ALLRelbowvel(:,tri,con,par)=Relbowvel;
                        %Left Elbow
                        Lelbowvel=firstcentral(Lelbow,sf);
                        ALLLelbowvel(:,tri,con,par)=Lelbowvel;
                        %Shoulder rotation
                        shouldrotvel=firstcentral(shouldrot,sf);
                        ALLshouldrotvel(:,tri,con,par)=shouldrotvel;
                        %Hip Rotation
                        hiprotvel=firstcentral(hiprot,sf);
                        ALLhiprotvel(:,tri,con,par)=hiprotvel;
                        
                        %Getting  Phase Angle (see function for reference)
                        %Right Knee phase angle
                        RkneePA=PA(Rknee,Rkneevel);
                        %Left knee phase angle
                        LkneePA=PA(Lknee,Lkneevel);
                        %right elbow phase angle
                        RelbowPA=PA(Relbow,Relbowvel);
                        %left elbow phase angle
                        LelbowPA=PA(Lelbow,Lelbowvel);
                        %shoulder rotation phase angle
                        shoulderPA=PA(shouldrot,shouldrotvel);
                        %hip rotation phase angle
                        hipPA=PA(hiprot,hiprotvel);

                        
                        %% Technical cues
                        
                        %Right foot in front (positive=right foot in front)
                        %- distance in y from the other foot at ball's contact
                        anklesdistance=(RANKLE(round(ballcontact),2)-LANKLE(round(ballcontact),2));
                        
                        %Lower eye height difference between first and minimum hip in z
                        %How much the participant moved their hip down in
                        %relation to the maximum hip height
                        hipheight=(hipl(:,3)+hipr(:,3))/2;
                        lowerhip=hipheight(1) - min(hipheight);

                        %Follow through, displacement in Y after ball contact
                        %How much the participant moved forward after
                        %setting the ball?
                        hipy=(hipl(:,2)+hipr(:,2))/2;
                        followt=hipy(end)-hipy(round(ballcontact));

                        
                        %% Getting Continuous Relative Phases
                        
                        %Using the absolute value because we are not
                        %concerned with what segment is leading
                        %Right Knee and Left Knee
                        RLkneeCRP=abs(RPA(RkneePA,LkneePA));
                        %Right Elbow and Left Elbow
                        RLelbowCRP=abs(RPA(RelbowPA,LelbowPA));
                        %Right Knee and Right elbow
                        RkneeerelbowCRP=abs(RPA(RkneePA,RelbowPA));
                        %Left knee and left Elbow
                        LkneeelbowCRP=abs(RPA(LkneePA,LelbowPA));
                        %Hip and Shoulder rotations
                        hipshouldCRP=abs(RPA(hipPA,shoulderPA));
                        %Right and Left side CRP average
                        bothsidesCRP=mean([RkneeerelbowCRP' LkneeelbowCRP'],2);
                        
                        
                        
                        %%Putting all the data in matrices for exporting
                        %%them later
                        rightCRPall(:,tri,con,par)=RkneeerelbowCRP;
                        leftCRPall(:,tri,con,par)=LkneeelbowCRP;
                        rotationCRPall(:,tri,con,par)=hipshouldCRP;
                        elbowCRPall(:,tri,con,par)=RLelbowCRP;
                        kneeCRPall(:,tri,con,par)=RLkneeCRP;
                        bothsidesCRPall(:,tri,con,par)=bothsidesCRP;
                        
                        scoreall(:,tri,con,par)=score;
                        ballspeed(:,tri,con,par)=releasevelocity;
                        rangle(:,tri,con,par)=releaseangle;
                        highest(:,tri,con,par)=highestpoint;
                        ballcontactperc(:,tri,con,par)=ballcontact;
                        ballcontact2(:,tri,con,par)=min(firstnumber);
                        
                        levelall(:,tri,con,par)=Level;
                        partticipantall(:,tri,con,par)=partticipant;
                        orderall(:,tri,con,par)=Order;
                        conditionall(:,tri,con,par)=Condition;
                        trialall(:,tri,con,par)=Trial;
                        followtALL(:,tri,con,par)=followt;
                        lowerhipALL(:,tri,con,par)=lowerhip;
                        ankledistanceALL(:,tri,con,par)=anklesdistance;
                        angleelbowcontactALL(:,tri,con,par)=angleelbowcontact;
                        
                        
                    end
                end
            end
        end
    end
end
