I = imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/other_images/onion.png');
I = imresize(I,[512,512]);
%% Gaussian Pyramid %%
Igp = double(I);
Sd = 50;
No_gauss_pyramid = 5;
Img{1} = Igp;

for i = 1:No_gauss_pyramid
%  creating Gaussian filter
 WinSize = 2;
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

 Img{i+1} = Igp;
end

m = size(Img{1}, 1);
newI = Img{1};
for i = 2 : numel(Img)
    [q,p,~] = size(Img{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Img{i});
    newI = cat(2,newI,Img_{i});
end
figure,imshow(uint8(newI));

%% Laplacian Pyramid

for i = 1:No_gauss_pyramid
 image = Img{i+1};
 
 upsampled = zeros(2*size(image,1),2*size(image,2),3);
 upsampled(1:2:end,1:2:end,:) = image;
 upsampled(2:2:end,2:2:end,:) = image;
 upsampled(1:2:end,2:2:end,:) = image;
 upsampled(2:2:end,1:2:end,:) = image;
 
 WinSize = 2;
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
 Imglp{i} = Img{i} - Bupsampled;
end

m = size(Imglp{1}, 1);
newI = Imglp{1};
for i = 2 : numel(Imglp)
    [q,p,~] = size(Imglp{i});
    Img_{i} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),Imglp{i});
    newI = cat(2,newI,Img_{i});
end
figure, imshow(uint8(newI));



 