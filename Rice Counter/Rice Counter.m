% >> Question III : Rice Counter<<
%5735512155 Sig&Img_1/59


%  à¸ªà¹?à¸§à¸?à¸?à¸²à¸£à¸­à¹?à¸²à¸?à¸?à¹?à¸²à¸ à¸²à¸?
I = imread('rice.png');
%figure
subplot(231)
imshow(I),title('Original');


% à¸ªà¹?à¸§à¸?à¸?à¸²à¸£à¸—à¸³ threshold
thresholdValue = 120;
binaryImage = I > thresholdValue;
%figure
subplot(232)
imshow(binaryImage),title('Binary Image');


% à¸ªà¹?à¸§à¸?à¸?à¸²à¸£à¹?à¸ªà¹? filter à¹€à¸?à¸·à¹?à¸­à¸?à¸£à¸­à¸?à¹?à¸«à¹?à¸?à¹?à¸²à¸§à¸ªà¸²à¸£à¹€à¸«à¸¥à¸·à¸­à¹€à¹€à¸•à¹?à¸?à¸­à¸?
filtImage = imfill(binaryImage,'hole');
%figure
subplot(233)
imshow(filtImage),title('Filltered Binary Image');


% à¸ªà¹?à¸§à¸?à¸?à¸²à¸£à¸—à¸³ Erosion à¹€à¸?à¸·à¹?à¸­à¸¥à¸? noise à¸?à¸¸à¸”à¹€à¸¥à¹?à¸?à¹?à¹?à¸?à¸ à¸²à¸? 
se = strel('line',5,100);
erodeImage = imerode(filtImage,se);
%figure
subplot(234)
imshow(erodeImage),title('Erosed binaryImage');


% à¹?à¸ªà¹?  label à¹?à¸«à¹?à¸?à¹?à¸²à¸§à¸ªà¸²à¸£à¹€à¹€à¸•à¹?à¸¥à¸°à¹€à¸¡à¹?à¸”
labeledImage = bwlabel(erodeImage,8);
figure
%subplot(235)
imshow(labeledImage , []),title('Result');
impixelinfo


% à¹?à¸?à¹?à¸?à¸±à¸?à¸?à¹?à¸?à¸±à¸?  regionprops à¹€à¸?à¸·à¹?à¸­à¸¥à¸²à¸?à¹€à¸ªà¹?à¸?à¸?à¸­à¸?à¹€à¸¡à¸¥à¹?à¸”à¸?à¹?à¸²à¸§à¸ªà¸²à¸£
blobMeasurement = regionprops(labeledImage , I , 'all');

hold on
% à¹?à¸?à¹?à¸?à¸±à¸?à¸?à¹?à¸?à¸±à¸?  bwboundaries à¹€à¸?à¸·à¹?à¸­à¸—à¸³à¸?à¸²à¸£ trace à¹€à¸ªà¹?à¸?à¸?à¸­à¸?à¸ à¸²à¸? binary
boundaries = bwboundaries(erodeImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
       thisBoundary = boundaries{k};
       plot(thisBoundary(:,2) , thisBoundary(:,1) , 'y' , 'LineWidth' , 2);
   end
hold off


% à¸§à¸? loop à¹€à¸?à¸·à¹?à¸­à¹?à¸ªà¹?à¹€à¸¥à¸?à¹?à¸«à¹?à¹€à¸¡à¸¥à¹?à¸”à¸?à¹?à¸²à¸§à¸ªà¸²à¸£
% à¸ªà¹?à¸§à¸?à¸?à¸²à¸£à¸•à¸±à¹?à¸?à¸?à¹?à¸²à¸?à¹?à¸­à¸?à¸•à¹?à¹€à¹€à¸¥à¸°à¸£à¸°à¸¢à¸°à¸«à¹?à¸²à¸?à¸?à¹?à¸­à¸?à¸•à¹?
textFontSize = 10;
labelShiftX = -2;

numberOfBlobs = size(blobMeasurement , 1);
blobECD = zeros(1,numberOfBlobs);
fprintf(1,'Blob # Mean    Intensity     Area\n' );
>> for k =1 : numberOfBlobs
      thisBlobsPixels = blobMeasurement(k).PixelIdxList;
      meanGL = mean(I(thisBlobsPixels));
      blobArea = blobMeasurement(k).Area;
      blobPerimeter = blobMeasurement(k).Perimeter;
      blobCentroid = blobMeasurement(k).Centroid;
      blobECD(k) = sqrt(4* blobArea / pi);
      fprintf(1,'#%2d %17.1f %11.1f\n' , k ,meanGL , blobArea );
      text(blobCentroid(1) + labelShiftX , blobCentroid(2) , num2str(k) , 'FontSize' , textFontSize , 'FontWeight' , 'Bold','color','r');
   end


%à¸ªà¹?à¸§à¸?à¸?à¸²à¸£à¹?à¸ªà¸”à¸?à¸?à¹?à¸²
%à¹?à¸ªà¸”à¸?à¸?à¹?à¸²à¸—à¸µà¹?à¸?à¸±à¸?à¹€à¸¡à¸¥à¹?à¸”à¸?à¹?à¸²à¸§à¸ªà¸²à¸£à¹?à¸”à¹?à¹?à¸?à¸«à¸?à¹?à¹?à¸²à¸•à¹?à¸²à¸? workspace à¸?à¸­à¸? matlab
fprintf(1,'\n\n\n Total of Rice is %3d \n',k);


%à¹?à¸ªà¸”à¸?à¸?à¹?à¸²à¸—à¸µà¹?à¸?à¸±à¸?à¹€à¸¡à¸¥à¹?à¸”à¸?à¹?à¸²à¸§à¸ªà¸²à¸£à¹?à¸”à¹?à¹?à¸?à¸«à¸?à¹?à¹?à¸²à¸•à¹?à¸²à¸? pop-up
h = msgbox(sprintf('Total of Rice is %2.3g seeds.\n',k),'Program Result');
set(h, 'position', [100 440 250 100]);
ah = get( h, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 16,'color','b'); 


