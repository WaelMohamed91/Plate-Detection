
function [UperPartImage,LowerPartOfImage] = CropImage(image  )
  


   [w,h,c] = size(image);
   UperPartImage=imcrop(image,[0,-h/3,h,w]);% Crop the upper Part Of the Image 
   LowerPartOfImage=imcrop(image,[0,h/5,h,w]);% Crop the Lower Part Of the Image 

