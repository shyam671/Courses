% %G = fspecial('gaussian',[3 3],5);
% A_o = im2double(rgb2gray(imread('Assign3_imgs/Cricket1.jpeg')));
% %A = imfilter(A,G,'same');
% BWA = edge(A_o,'canny',0.3);
% %BWA = bwdist(BWA);
% figure,imshow(A_o);
% 
% B_o = im2double(rgb2gray(imread('Assign3_imgs/Cricket1_temp.jpeg')));
% %B = imfilter(B,G,'same');
% BWB = edge(B_o,'canny',0.3);
% %BWB = bwdist(BWB);
% % figure,imshow(BWB,[]);
% A = BWA;
% B = BWB;
% corr_map = zeros([size(A,1),size(A,2)]);
% 
% 
% 
% for i = 1:2:size(A,1)-size(B,1)
%     i
%     for j = 1:2:size(A,2)-size(B,2)
%        corr_map(i+size(B,1),j+size(B,2)) = corr2(A(i:i+size(B,1)-1,j:j+size(B,2)-1),B);
%     end
% end
% [row,col] = find(corr_map>0);
% hold on
% plot(row,col, 'r*');

% %Find the maximum value
% maxpt = max(corr_map(:));
% [x,y]=find(corr_map==maxpt);
% 
% %Display the image from the template
% figure,imagesc(B1);title('Target Image');colormap(gray);axis image
% 
% grayA = rgb2gray(A1);
% Res   = A;
% Res(:,:,1)=grayA;
% Res(:,:,2)=grayA;
% Res(:,:,3)=grayA;
% 
% Res(x:x+size(B,1)-1,y:y+size(B,2)-1,:)=A1(x:x+size(B,1)-1,y:y+size(B,2)-1,:);
% 
% figure,imagesc(Res);
% I = imread('Assign3_imgs/Cricket2.jpeg');
% BW = edge(rgb2gray(I),'canny',0.4);
% 
% se = strel('disk',5);
% dilatedI = imdilate(BW,se);
% figure, imshow(dilatedI);
% dilatedI = imfill(dilatedI,'holes');
% figure, imshow(dilatedI);
% he = imread('Assign3_imgs/Cricket1.jpeg');
% he = imresize(he,[500,500]);
% cform = makecform('srgb2lab');
% lab_he = applycform(he,cform);
% ab = double(lab_he(:,:,2:3));
% nrows = size(ab,1);
% ncols = size(ab,2);
% ab = reshape(ab,nrows*ncols,2);
% 
% nColors = 2;
% % repeat the clustering 3 times to avoid local minima
% % Ikm = Km2(he,nColors); 
% % imshow(Ikm,[]), title('image labeled by cluster index');
% [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','cosine', ...
%                                       'Replicates',10);
% pixel_labels = reshape(cluster_idx,nrows,ncols);
% imshow(pixel_labels,[]), title('image labeled by cluster index');
% 
%A = imread('Assign3_imgs/Cricket1.jpeg');
%I = imresize(I,[500,500]);
% imshow(A);
% [centers, radii, metric] = imfindcircles(I,[2 20]);
% viscircles(centers, radii,'EdgeColor','b');  