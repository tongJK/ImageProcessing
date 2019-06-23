% >> Question I : license plate<<
%5735512155 Sig&Img_1/59

%  ÊèÇ¹¡ÒÃÍèÒ¹¤èÒÀÒ¾
rgbImage = imread('C:\Users\Tong\Desktop\Coe #13\signal&Image Processing\Signal Assignment 59\v8301977-0.jpg');


% ´Ö§¤èÒ dimansion ¢Í§ÀÒ¾ÁÒãªé
[rows, columns, numberOfColorBands] = size(rgbImage);

subplot(2,3,1);
imshow(rgbImage),title('Original Image');


% Åº¢Íº»éÒÂ·ÐàºÕÂ¹.
rgbImage(1:25, :, :) = 255;
rgbImage(:, 1:20, :) = 255;
rgbImage(:, 670:end, :) = 255;
rgbImage(190:end, : , : ) = 255;

subplot(2,3,2);
imshow(rgbImage),title('Remove Edge');



% à»ÅÕèÂ¹ÃÙ»à»ç¹ binary
thresholdValue = 55;
binaryImage = rgbImage(:,:, 1) < thresholdValue | rgbImage(:,:, 2) < thresholdValue | rgbImage(:,:, 3) < thresholdValue;

subplot(2,3,3);
imshow(binaryImage),title('Binary Image');


% ãÊè filter à¾×èÍ¡ÃÍ§ÊèÇ¹à¡Ô¹
filledImage = imfill(binaryImage, 'holes');

subplot(2,3,4);
imshow(filledImage),title('Filled Binary Image');
drawnow;


% ãªé¿Ñ§¡ìªÑ¹ËÒàÊé¹¢Íº
[labeledImage numberOfBlobs] = bwlabel(filledImage);
measurements = regionprops(labeledImage, 'BoundingBox');
for k = 1 : numberOfBlobs
	x1 = measurements(k).BoundingBox(1);
	y1 = measurements(k).BoundingBox(2);
	width = measurements(k).BoundingBox(3);
	height = measurements(k).BoundingBox(4);
	x2 = x1 + width;
	y2 = y1 + height;	

	x1 = ceil(x1); 
	y1 = ceil(y1); 
	x2 = floor(x2); 
	y2 = floor(y2); 
	filledImage(y1:y2, x1:x2) = true;

	subplot(2,3,5);
	imshow(filledImage),title('Fill Binary Image');
end

figure
% áÊ´§¼ÅÅÑ¾¸ì
for k = 1 : numberOfBlobs
	x1 = measurements(k).BoundingBox(1);
	y1 = measurements(k).BoundingBox(2);
	width = measurements(k).BoundingBox(3);
	height = measurements(k).BoundingBox(4);
	subImage = imcrop(rgbImage, [x1 y1 width height]);
	
	subplot(2,4,k);
	imshow(subImage);
	caption = sprintf('Charactor digit:%d',k);
	title(caption);
end
