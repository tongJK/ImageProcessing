clear;
I = imread('C:\Users\Tong\Desktop\cell.jpg');
figure,subplot(231),imshow(I),title('Original');

th = graythresh(I);
BW = ~im2bw(I,th);
subplot(232)
imshow(BW),title('Binary Image');

se1 = strel('line',4,0);
DL = imdilate(BW,se1);
subplot(233)
imshow(DL),title('Dilated Image');

se2 = strel('disk',3);
se3 = strel('disk',2);
ER = imclose(DL,se2);
ER = imerode(ER,se3);
subplot(234)
imshow(ER),title('Eroded Image');

FB = imfill(ER,'holes');
subplot(235)
imshow(FB),title('Filltered Binary Image');

se4 = strel('disk',3);
IR = imerode(FB,se4);
se5 = strel('disk',4);
PAD = imdilate(IR,se5);

bw_a = padarray(PAD,[1 1],1,'pre');
PAD = imfill(bw_a,'holes');
PAD = PAD(2:end,2:end);
subplot(236)
imshow(PAD),title('PAD Image');


imgTwoAdjacent = bwareaopen(PAD,5430); %figure, imshow(imgTwoAdjacent);
imgRemain1 = imsubtract(PAD,imgTwoAdjacent);        %figure, imshow(imgRemain1);
imgMedium = bwareaopen(imgRemain1,2280);                 %figure, imshow(imgMedium); 
imgSmall = imsubtract(logical(imgRemain1),imgMedium);   %figure, imshow(imgSmall);



[imgMedium,numMedium] = bwlabel(imgMedium); 
figure,subplot(331), imshow(imgMedium); 
title(['Large Single Cell: ' num2str(numMedium) '']);

[imgSmall,numSmall] = bwlabel(imgSmall); 
subplot(334), imshow(imgSmall); 
title(['Small Single Cell: ' num2str(numSmall) '']);

[imgTwoAdjacent,numTwoAdjacent] = bwlabel(imgTwoAdjacent); 
subplot(337), imshow(imgTwoAdjacent); 
title(['Couple Cell: ' num2str(numTwoAdjacent) '']);