function [Xmid,xy_long] = DrawLinesANDselectLargest( lines )
    %___select largest line.
    max_len = 0;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];

       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end
   %____return (X , Y , midpoint ) of the largest line  
    Xmid=(xy_long(1,1)-xy_long(2,1))/2;
   %___To Avoid The Negative Value From Sub 
    if (Xmid <0)
        Xmid=-1*Xmid;
    end    
    
