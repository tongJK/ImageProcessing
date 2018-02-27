% >> Question III : Rice Counter<<
%5735512155 Sig&Img_1/59


%  ส�?ว�?�?ารอ�?า�?�?�?าภา�?
I = imread('rice.png');
%figure
subplot(231)
imshow(I),title('Original');


% ส�?ว�?�?ารทำ threshold
thresholdValue = 120;
binaryImage = I > thresholdValue;
%figure
subplot(232)
imshow(binaryImage),title('Binary Image');


% ส�?ว�?�?าร�?ส�? filter เ�?ื�?อ�?รอ�?�?ห�?�?�?าวสารเหลือเเต�?�?อ�?
filtImage = imfill(binaryImage,'hole');
%figure
subplot(233)
imshow(filtImage),title('Filltered Binary Image');


% ส�?ว�?�?ารทำ Erosion เ�?ื�?อล�? noise �?ุดเล�?�?�?�?�?ภา�? 
se = strel('line',5,100);
erodeImage = imerode(filtImage,se);
%figure
subplot(234)
imshow(erodeImage),title('Erosed binaryImage');


% �?ส�?  label �?ห�?�?�?าวสารเเต�?ละเม�?ด
labeledImage = bwlabel(erodeImage,8);
figure
%subplot(235)
imshow(labeledImage , []),title('Result');
impixelinfo


% �?�?�?�?ั�?�?�?�?ั�?  regionprops เ�?ื�?อลา�?เส�?�?�?อ�?เมล�?ด�?�?าวสาร
blobMeasurement = regionprops(labeledImage , I , 'all');

hold on
% �?�?�?�?ั�?�?�?�?ั�?  bwboundaries เ�?ื�?อทำ�?าร trace เส�?�?�?อ�?ภา�? binary
boundaries = bwboundaries(erodeImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
       thisBoundary = boundaries{k};
       plot(thisBoundary(:,2) , thisBoundary(:,1) , 'y' , 'LineWidth' , 2);
   end
hold off


% ว�? loop เ�?ื�?อ�?ส�?เล�?�?ห�?เมล�?ด�?�?าวสาร
% ส�?ว�?�?ารตั�?�?�?�?า�?�?อ�?ต�?เเละระยะห�?า�?�?�?อ�?ต�?
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


%ส�?ว�?�?าร�?สด�?�?�?า
%�?สด�?�?�?าที�?�?ั�?เมล�?ด�?�?าวสาร�?ด�?�?�?ห�?�?�?าต�?า�? workspace �?อ�? matlab
fprintf(1,'\n\n\n Total of Rice is %3d \n',k);


%�?สด�?�?�?าที�?�?ั�?เมล�?ด�?�?าวสาร�?ด�?�?�?ห�?�?�?าต�?า�? pop-up
h = msgbox(sprintf('Total of Rice is %2.3g seeds.\n',k),'Program Result');
set(h, 'position', [100 440 250 100]);
ah = get( h, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 16,'color','b'); 


