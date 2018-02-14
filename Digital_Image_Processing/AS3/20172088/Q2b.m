%Th1 = 0.4;Th2 = 6;I = imread('Assign3_imgs/Cricket1.jpeg');  %Img1
%Th1 = 0.4;Th2 = 10;I = imread('Assign3_imgs/Cricket2.jpeg'); %Img2 
%Th1 =0.1;Th2 =25;I = imread('Assign3_imgs/Cricket3.jpeg');   %Img3
%Th1 = 0.4;Th2 = 5;I = imread('Assign3_imgs/Cricket4.jpeg');   %Img4
Th1 = 0.05;Th2 = 25;I = imread('Assign3_imgs/Cricket5.jpeg'); %Img5

I = rgb2gray(I);
figure,subplottight(3,1,1), imshow((I));title('original');
BW = edge((I),'canny',Th1);

subplottight(3,1,2),imshow((BW));title('\color{magenta}Edge Map');
se = strel('line',2,0);
erodedBW = imerode(BW,se);
subplottight(3,1,3),imshow((BW-erodedBW));title('\color{magenta}Eroding horizontal Lines');
BW = BW-erodedBW;
CC = bwconncomp(BW);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = find(numPixels<Th2);

for i = 1:size(idx,2)
 BW(CC.PixelIdxList{idx(1,i)}) = 0;
end
figure,subplottight(3,1,1), imshow((BW));title('\color{magenta}Removing Small CC');
se = strel('disk',5);
dilatedI = imdilate(BW,se);
%figure, imshow(dilatedI);
dilatedI = imfill(dilatedI,'holes');
subplottight(3,1,2), imshow((dilatedI));title('\color{magenta}Dilation+Holefilling');
%figure, imshow(dilatedI);
se = strel('disk',5);
erodeI = imerode(dilatedI,se);
%figure, imshow(erodeI);
dilatedI = imfill(erodeI,'holes');
subplottight(3,1,3), imshow((dilatedI));title('\color{magenta}Erosion+Holefilling');
%figure, imshow(dilatedI);
