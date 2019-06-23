im = imread('C:\Users\Tong\Desktop\pic.jpg');
figure('name','Result'),subplot(331),imshow(im),title('Original');
GRAY = rgb2gray(im);
subplot(332),imshow(GRAY),title('Grayscale Image');
threshold = graythresh(GRAY);
BW = im2bw(GRAY, threshold);
subplot(333),imshow(BW),title('Image Binary');

BW = ~BW;
subplot(334),imshow(BW),title('Invert Binary')
stats = regionprops(BW,'Perimeter','Area','Centroid','BoundingBox');
subplot(335),imshow(BW)
hold on
Triangle = 0;
Cicle = 0;
Squre = 0;
for k =1 :length(stats)
    thisboundingbox=stats(k).BoundingBox;
    if stats(k).Area > 7000
        rectangle('Position',[thisboundingbox(1),thisboundingbox(2),thisboundingbox(3),thisboundingbox(4)],'EdgeColor','r','LineWidth',2)
    else
        rectangle('Position',[thisboundingbox(1),thisboundingbox(2),thisboundingbox(3),thisboundingbox(4)],'EdgeColor','b','LineWidth',2)
    end
    if stats(k).Perimeter^2/stats(k).Area > 17
        text(stats(k).Centroid(1),stats(k).Centroid(2),'Triangle','Color','r');
       
        Triangle = Triangle+1;           
    elseif stats(k).Perimeter^2/stats(k).Area < 13
        text(stats(k).Centroid(1),stats(k).Centroid(2),'Cicle','Color','b');
        Cicle = Cicle+1;
        else
         text(stats(k).Centroid(1),stats(k).Centroid(2),'Squre','Color','g');
         Squre = Squre+1;
    end
end
