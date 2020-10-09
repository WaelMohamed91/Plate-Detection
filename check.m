function [ output_args ] = check( image )
%________get Threshold to Convert to binary (Black and white )
threshold = graythresh(image);
imagen =~im2bw(image,threshold);
binaryImage = bwareaopen(imagen,1);

%_______________________________ get the  angle 
binaryImage = imfill(binaryImage , 'holes'); %fill object 
[labeledImage,Ne] = bwlabel(binaryImage);

%________ Gat All Angles To All Objects 
objects = regionprops(labeledImage, 'BoundingBox' , 'Orientation');

output_args = (objects(1).Orientation) ; 
end

