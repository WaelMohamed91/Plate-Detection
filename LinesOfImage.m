function [Lines] = LinesOfImage( cropimage )
     %egde detection 
      BW = edge(rgb2gray(cropimage), 'canny');
     % hough transform to detect the Lines of the Image.
      [H ,T ,R] = hough(BW);
      P  = houghpeaks(H, 4, 'threshold',graythresh(H));
      Lines = houghlines(BW, T, R, P);

 