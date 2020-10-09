function [charcount,numberscount] = CountNumAndChars( propied,Xmid,xy_long,image )
    charcount=0;
    numberscount=0;
     
    [WIMG,HIMG,CIMG]=size(image);
    
    

    for object = 1:length(propied)
        X = floor(propied(object).BoundingBox(1)) ; 
        Y = floor( propied(object).BoundingBox(2)) ; 
        W = floor( propied(object).BoundingBox(3)) ; 
        H = floor(propied(object).BoundingBox(4)) ; 
        
          if (Xmid<X+5 && W>5 &&H>4&&H<30&&X<xy_long(2,1)&&(HIMG-(HIMG-Y)<25)&&(HIMG-H)>10)
            charcount=charcount+1;
      
          end

        if (Xmid>X&&X>xy_long(1,1)+5&&H>1&&(HIMG-(HIMG-Y)<25) )
            numberscount=numberscount+1;
        end   
    end

 