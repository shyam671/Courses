binSize = 256;
Img = rgb2gray(imread('Assign1_imgs/Q1_3.jpeg'));
%Img = imread('tire.tif');
wsize = 1;
figure,imshow(Img);
Img(size(Img,1):size(Img,1)+wsize,size(Img,2):size(Img,2)+wsize) = 0;
Img = double(Img);
for row = 1:size(Img,1)-wsize 
    row
    for col = 1:size(Img,2)-wsize 
        
        HistEQIm = zeros(wsize);
        I = Img(row:row+wsize-1,col:col+wsize-1);
        Image_histogram =hist(double(I(:)),binSize);
        Cumlative_sum=cumsum(Image_histogram/(size(I,1)*size(I,2)));
        Img(row+(wsize-1)/2,col+(wsize-1)/2) =  ((Cumlative_sum(I((wsize+1)/2,(wsize+1)/2)+1)*binSize));
    end
end
figure,imshow(uint8(Img));


binSize = 256;
Actual = rgb2gray(imread('Assign1_imgs/hist_equal2.jpg'));
Specified = rgb2gray(imread('Assign1_imgs/SaltPepperNoise.jpg'));
figure,imshow(Actual);
figure,imshow(Specified);
ActualImhist =hist(double(Actual(:)),binSize);
Actualcsum= cumsum(ActualImhist/(size(Actual,1)*size(Actual,2)))*binSize;

SpecifiedImhist =hist(double(Specified(:)),binSize);
Specifiedcsum= cumsum(SpecifiedImhist/(size(Specified,1)*size(Specified,2)))*binSize;

Mapping = zeros(binSize,1);

for i = 1:binSize
    [~,ind] = min(abs(Actualcsum(i) - Specifiedcsum));
    Mapping(i) = ind-1;
end

NewImage = Mapping(Actual + 1);
figure,imshow(uint8(NewImage));









