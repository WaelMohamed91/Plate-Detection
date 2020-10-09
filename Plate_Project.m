function [ Numbers , Chars , color , Governorate , Vehicle ] = Plate_Project( image_Path )
 image = imread(image_Path);
 [list, numofplats]= plats( image ); % return Number of plates of image and return the plates 
 %Create List of NumbersOfDigites , Chars , color , Governorate , Vehicle
 color = cell(numofplats);
 Chars = cell(numofplats);
 Numbers = cell(numofplats);
 Governorate =cell(numofplats);
 Vehicle = cell(numofplats);
 
%**********************************************************************
for i=1 :numofplats
    image=list{i};
   
    %__________Check if this Image is Rotated or Not     
    [ww,hh]=size(image);
    plate_is_rotated=0;
    c= check (image);
    if c > 13
      image = Rotate(image);
      image = imfill(image , 'holes'); 
      plate_is_rotated=1;
    end 
    
         
        
    [UperPartImage,LowerPartOfImage]=CropImage(image);
    
     % make median Filter to make the image more clearer 
    if plate_is_rotated==1 && numofplats>1||plate_is_rotated==1 
    
        R = LowerPartOfImage(:,:,1);
        G = LowerPartOfImage(:,:,2);
        B = LowerPartOfImage(:,:,3);
        LowerPartOfImage(:,:,1) = medfilt2(R);
        LowerPartOfImage(:,:,2) = medfilt2(G);
        LowerPartOfImage(:,:,3) = medfilt2(B);

    
    end 

    %**********************************************************
    
    Lines =LinesOfImage(LowerPartOfImage); %using hough transform 
    
    [Xmid,xy_long]=DrawLinesANDselectLargest(Lines); 

    
    propied = BoundingImage( LowerPartOfImage );
    

%/////////////////////Numbers && Chars COUNT /////////////////  

    [charcount,numberscount]=CountNumAndChars(propied,Xmid,xy_long,LowerPartOfImage);
    Chars{i} = num2str(charcount) ;
    Numbers{i} = num2str(numberscount) ; % convert number to string 
 
    fprintf('%i\n', charcount)
    fprintf('%i\n', numberscount)
    ch=charcount+numberscount;
if (ch==6&&numberscount==3)
   fprintf(' __Cairo__ \n');
   Governorate{i} = 'Cairo';
   
end    
if (ch==6&&numberscount==4)
   fprintf(' __Giza__ \n');
   Governorate {i}= 'Giza';
end    
if (ch==7&&numberscount==4)
   fprintf(' __Other Governorate__ \n');
   Governorate{i} = 'Other Governorate';
end
   
%     %______________________________ colors
 
    UperPartImage=imresize(UperPartImage,[ww,hh]); 

    
    % Take Point in the middel to Knew the Color of the Upper Part of the Image  
    xcolor=floor(ww/2+10);
    ycolor=floor(hh/2);
    % Copy the Color From the Three Channels 
    reed =UperPartImage (xcolor,ycolor,1);
    greeen = UperPartImage(xcolor,ycolor,2) ;
    bluue = UperPartImage(xcolor,ycolor,3); 
    
    if reed >= 0 && reed <100
        if greeen >= 0 && greeen <150 
            if bluue > 70||bluue==2 && bluue <= 255
                fprintf('Light BLUE\n');
                Vehicle{i} = 'Owners Cars' ;
                color{i}= 'Light BLUE'; 
                fprintf('Owners Cars\n');
                fprintf('********************************\n')
                continue;
            end 
        end 
    end 
  

 
     if reed >= 120 && reed <=255 
        if greeen >= 0 &&greeen<30
            if bluue > 0 &&greeen<30
                fprintf('Red\n')
                color{i}= 'Red';
                Vehicle{i} = 'Transport' ;
                fprintf('Transport\n')
                fprintf('********************************\n')
                continue;
            end 
        end 
     end 

    if reed > 40 && reed <=250
        if greeen >= 40 && greeen <=250
            if bluue >=40 && bluue <= 250
                   fprintf('GRAY\n')
                   color {i}= 'GRAY';
                   Vehicle{i} = 'Government Cars';
                   fprintf('Government Cars\n')
                   fprintf('********************************\n')
                    continue;
            end
       
        end 
  
        
    end
end
end

