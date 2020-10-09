
function [propied] = BoundingImage( new )
 %___________get Threshold to Convert the Image to Binary Image.
    threshold = graythresh(new);
    imagen =~im2bw(new,threshold);
 %___________get the biggest object of the Image.
    imagen = bwareaopen(imagen,1);

 %___________get the Objects Of the biggest Object 
    [L,Ne]=bwlabel(imagen);
 %___________Measure properties of image regions
    propied=regionprops(L,'BoundingBox');
