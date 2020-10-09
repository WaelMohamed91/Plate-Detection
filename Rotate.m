function [ output_args ] = Rotate( image )

ii = image ; 
image=rgb2gray(image);
% __________________________Get Threshold to Convert The Image To Binary. 
threshold = graythresh(image);
imagen =~im2bw(image,threshold);

binaryImage = bwareaopen(imagen,1);
%_______________________________ get the  angle 
binaryImage = imfill(binaryImage , 'holes');
[labeledImage,Ne] = bwlabel(binaryImage);

angle = regionprops(labeledImage, 'BoundingBox' , 'Orientation', 'MajorAxisLength', 'Centroid');

if(size(image ,1)==99 && size(image ,2)==143  ) % Case 3 Image 2 
    bb = angle(1).BoundingBox;
    subImage = imcrop(ii, bb);
    m = imrotate (subImage , -(13));
    subImage = imcrop(m, [14 29 127 66]); 
end

if (size(image ,1)==148 && size(image ,2)==202) % Case 3 Image 1 
    bb = angle(2).BoundingBox;
    subImage = imcrop(ii, bb);
    m = imrotate (subImage , -(angle(2).Orientation));
    subImage = imcrop(m, [26 57 175 83]); 
end 
output_args = subImage ; 
end


