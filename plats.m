function [ listOfPlats,numofplats] = plats( image )
     [wimg,himg]=size(image);
    grayimg=rgb2gray(image);
    e_img=edge(grayimg,'canny'); %Edge Detection by canny 
    
    d_img=imdilate(e_img,ones(5,5)); % dilation for each plate 
    
    BW2 = imfill(d_img,'holes'); % fill each plate by white color
    
    [l_img,numofplats]=bwlabel(BW2); % return label image depend on number of objecy 
    
      listOfPlats=cell(wimg,himg,numofplats);
      
    propied=regionprops(l_img,'BoundingBox'); 
    
    for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',1)
    end
    for object=1:size(propied,1)
      
        X = floor(propied(object).BoundingBox(1)) ; 
        Y = floor( propied(object).BoundingBox(2)) ; 
        W = floor( propied(object).BoundingBox(3)) ; 
        H = floor(propied(object).BoundingBox(4)) ; 
        
        new=imcrop(image ,[X,Y,W,H]);
        listOfPlats{object}=new;
        
    end 
    
    
