binSize = 255;
Img = rgb2gray(imread('Assign1_imgs/q1a.jpg'));
wsize = 3;
figure,imshow(Img);
Img(size(Img,1):size(Img,1)+wsize,size(Img,2):size(Img,2)+wsize) = 0;
for row = 1:wsize:size(Img,1)-wsize 
    for col = 1:wsize:size(Img,2)-wsize 
        
        HistEQIm = zeros(wsize);
        I = Img(row:row+wsize-1,col:col+wsize-1);
        Image_histogram =hist(double(I(:)),binSize);
        Cumlative_sum=cumsum(Image_histogram/(size(I,1)*size(I,2)));
        for i=1:size(HistEQIm,1)
            for j=1:size(HistEQIm,2)
                HistEQIm(i,j)=round(Cumlative_sum(I(i,j)+1)*binSize);
            end
        end
        Img(row:row+wsize-1,col:col+wsize-1) = uint8(HistEQIm); 
    end
end
H = fspecial('gaussian');
Img = imfilter(Img,H,'replicate');
figure,imshow(Img);