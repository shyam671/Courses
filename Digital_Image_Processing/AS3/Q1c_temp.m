%thresh1 = 0.3;%Img3
%thresh1 = 0.5;%Img2
thresh1 = 0.3;%Img4
Io = (imread('Assign3_imgs/parabola4.jpg'));
Io = imresize(Io,[size(Io,1), size(Io,2)]);
I = rgb2gray(Io);
BW = edge(I,'canny',thresh1);
%figure,imshow(BW);
seH = strel('line',3,0);        
BWE = imerode(BW,seH);
seH = strel('line',3,90);
BWE2 = imerode(BW,seH);
%figure,imshow(BW-BWE-BWE2);
BW = BW-BWE;
seH = strel('disk',3);        
BWE = imdilate(BW,seH);
figure,imshow(BWE);









