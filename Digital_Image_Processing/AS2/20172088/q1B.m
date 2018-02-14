I = imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/image_blending_with_laplacian_pyramid/example3/im1.png');
I = imresize(I,[512,512]);
%% Gaussian Pyramid %%
Igp = double(I);
Sd = 20;
WinSize = 2;
No_gauss_pyramid = 8;
Img1{1} = (Igp);

for i = 1:No_gauss_pyramid
%  creating Gaussian filter
 %WinSize = 20;
 [X,Y] = meshgrid(-WinSize:WinSize);
 G = (1/(2*WinSize+1).^2).*exp((-X.^2 -Y.^2)/(Sd.^2));

 redChannel = Igp(:, :, 1);
 greenChannel = Igp(:, :, 2);
 blueChannel = Igp(:, :, 3);
 
 % Convolve with the filter
 redBlurred = conv2(redChannel, G,'same');
 greenBlurred = conv2(greenChannel, G, 'same');
 blueBlurred = conv2(blueChannel, G, 'same');
 
 % Downsampling by 2 
 IgpBlur = cat(3, redBlurred, greenBlurred, blueBlurred);
 IgpBlur = IgpBlur(1:2:size(IgpBlur,1),1:2:size(IgpBlur,2),:);
 Igp = IgpBlur;

 Img1{i+1} = (Igp);
end

m = size(Img1{1}, 1);
newI = Img1{1};
for i = 2 : numel(Img1)
    [q,p,~] = size(Img1{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Img1{i});
    newI = cat(2,newI,Img_{i});
end
%figure,imshow(uint8(newI));

%% Laplacian Pyramid

for i = 1:No_gauss_pyramid
 image = Img1{i+1};
 
 upsampled = zeros(2*size(image,1),2*size(image,2),3);
 upsampled(1:2:end,1:2:end,:) = image;
 upsampled(2:2:end,2:2:end,:) = image;
 upsampled(1:2:end,2:2:end,:) = image;
 upsampled(2:2:end,1:2:end,:) = image;
 
% WinSize = 20;
 [X,Y] = meshgrid(-WinSize:WinSize);
 G = (1/(2*WinSize+1).^2).*exp((-X.^2 -Y.^2)/(Sd.^2));
 
 redChannel = upsampled(:, :, 1);
 greenChannel = upsampled(:, :, 2);
 blueChannel = upsampled(:, :, 3);
 
 % Convolve with the filter
 redBlurred = conv2(redChannel, G,'same');
 greenBlurred = conv2(greenChannel, G, 'same');
 blueBlurred = conv2(blueChannel, G, 'same');
 Bupsampled = cat(3, redBlurred, greenBlurred, blueBlurred);
 Imglp1{i} = Img1{i} - Bupsampled;
end

m = size(Imglp1{1}, 1);
newI = Imglp1{1};
for i = 2 : numel(Imglp1)
    [q,p,~] = size(Imglp1{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Imglp1{i});
    newI = cat(2,newI,Img_{i});
end
figure, imshow(uint8(newI));
I1 = imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/image_blending_with_laplacian_pyramid/example3/im2.png');
I1 = imresize(I1,[512,512]);
%% Gaussian Pyramid %%
Igp = double(I1);
No_gauss_pyramid = 8;
Img2{1} = (Igp);

for i = 1:No_gauss_pyramid
%  creating Gaussian filter
 %WinSize = 20;
 [X,Y] = meshgrid(-WinSize:WinSize);
 G = (1/(2*WinSize+1).^2).*exp((-X.^2 -Y.^2)/(Sd.^2));

 redChannel = Igp(:, :, 1);
 greenChannel = Igp(:, :, 2);
 blueChannel = Igp(:, :, 3);
 
 % Convolve with the filter
 redBlurred = conv2(redChannel, G,'same');
 greenBlurred = conv2(greenChannel, G, 'same');
 blueBlurred = conv2(blueChannel, G, 'same');
 
 % Downsampling by 2 
 IgpBlur = cat(3, redBlurred, greenBlurred, blueBlurred);
 IgpBlur = IgpBlur(1:2:size(IgpBlur,1),1:2:size(IgpBlur,2),:);
 Igp = IgpBlur;

 Img2{i+1} = (Igp);
end

m = size(Img2{1}, 1);
newI = Img2{1};
for i = 2 : numel(Img2)
    [q,p,~] = size(Img2{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Img2{i});
    newI = cat(2,newI,Img_{i});
end
%figure,imshow(uint8(newI));

%% Laplacian Pyramid

for i = 1:No_gauss_pyramid
 image = Img2{i+1};
 
 upsampled = zeros(2*size(image,1),2*size(image,2),3);
 upsampled(1:2:end,1:2:end,:) = image;
 upsampled(2:2:end,2:2:end,:) = image;
 upsampled(1:2:end,2:2:end,:) = image;
 upsampled(2:2:end,1:2:end,:) = image;
 
 %WinSize = 20;
 [X,Y] = meshgrid(-WinSize:WinSize);
 G = (1/(2*WinSize+1).^2).*exp((-X.^2 -Y.^2)/(Sd.^2));
 
 redChannel = upsampled(:, :, 1);
 greenChannel = upsampled(:, :, 2);
 blueChannel = upsampled(:, :, 3);
 
 % Convolve with the filter
 redBlurred = conv2(redChannel, G,'same');
 greenBlurred = conv2(greenChannel, G, 'same');
 blueBlurred = conv2(blueChannel, G, 'same');
 Bupsampled = cat(3, redBlurred, greenBlurred, blueBlurred);
 Imglp2{i} = Img2{i} - Bupsampled;
end

m = size(Imglp2{1}, 1);
newI = Imglp2{1};
for i = 2 : numel(Imglp2)
    [q,p,~] = size(Imglp2{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Imglp2{i});
    newI = cat(2,newI,Img_{i});
end
figure, imshow(uint8(newI));

Im = imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/image_blending_with_laplacian_pyramid/example3/mask.png');
figure,imshow(Im);
% Im1 = zeros(size(Im));
% Im1(Im==1) = 255;
% Im = Im1;
Im = imresize(Im,[512,512]);
Im = cat(3, Im, Im, Im);
Igp = double(Im);
No_gauss_pyramid = No_gauss_pyramid -1;
Imgm{1} = Igp;

for i = 1:No_gauss_pyramid
%  creating Gaussian filter
 %WinSize = 20;
 [X,Y] = meshgrid(-WinSize:WinSize);
 G = (1/(2*WinSize+1).^2).*exp((-X.^2 -Y.^2)/(Sd.^2));

 redChannel = Igp(:, :, 1);
 greenChannel = Igp(:, :, 2);
 blueChannel = Igp(:, :, 3);
 
 % Convolve with the filter
 redBlurred = conv2(redChannel, G,'same');
 greenBlurred = conv2(greenChannel, G, 'same');
 blueBlurred = conv2(blueChannel, G, 'same');
 
 % Downsampling by 2 
 IgpBlur = cat(3, redBlurred, greenBlurred, blueBlurred);
 IgpBlur = IgpBlur(1:2:size(IgpBlur,1),1:2:size(IgpBlur,2),:);
 Igp = IgpBlur;

 Imgm{i+1} = (Igp);
end

m = size(Imgm{1}, 1);
newI = Imgm{1};
for i = 2 : numel(Imgm)
    [q,p,~] = size(Imgm{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Imgm{i});
    newI = cat(2,newI,Img_{i});
end
figure,imshow(uint8(newI));

%% Combination %%
for i = No_gauss_pyramid:-1:1
  Iblend{i} = (Imgm{i}.*Imglp1{i})./255 + ((255-Imgm{i}).*Imglp2{i})./255;
end
m = size(Iblend{1}, 1);
newI = Iblend{1};
for i = 2 : numel(Iblend)
    [q,p,~] = size(Iblend{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Iblend{i});
    newI = cat(2,newI,Img_{i});
end
figure,imshow(uint8(newI));
%% Collapse %%
for i= No_gauss_pyramid-1:-1:1
    size(Iblend{i})
    temp=imresize(uint8(Iblend{i+1}),[size(Iblend{i},1) size(Iblend{i},2)]);
    
    Iblend{i}=Iblend{i}+double(temp);
end
img=uint8(Iblend{1});
figure,imshow(img)




























