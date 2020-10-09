function [ list, plats] = checkNumOfPlats( image )
    grayimg=rgb2gray(image);
    e_img=edge(grayimg,'canny');
    d_img=imdilate(e_img,ones(5,5));
    BW2 = imfill(d_img,'holes');
    [l_img,numofplats]=bwlabel(BW2);
    
    I=image;
    
    if (numofplats>1)
        I1=I(1:(size(I,1)/2),1:(size(I,2)/2),:);

        I2=I(size(I,1)/2+1:size(I,1),1:(size(I,2)/2),:);

        I3=I(1:size(I,1)/2,size(I,2)/2+1:size(I,2),:);

        I4=I(size(I,1)/2+1:size(I,1),size(I,2)/2+1:size(I,2),:);
        
        list=cell(1000,1000,4);
        list{1}=I1;
        list{2}=I2;
        list{3}=I3;
        list{4}=I4;
    end 

    if (numofplats==1)
        I=image;
        list=cell(1000,1000,1);
        list{1}=I;
    end
    plats=numofplats;
    