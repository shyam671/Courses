Io = (imread('Assign3_imgs/rectangle1.jpg'));
I = rgb2gray(Io);
%thresh1 = 0.4;%img3
thresh1 = 0.5;%img1
BW = edge(I,'canny',thresh1);
%figure,imshow(BW);

se = strel('disk',1);
BW = imdilate(BW,se);
%figure, imshow(BW);

BW2 = imfill(BW,'holes');
%figure,imshow(BW2);

se = strel('disk',6);
BW2 = imerode(BW2,se);
figure, imshow(BW2);