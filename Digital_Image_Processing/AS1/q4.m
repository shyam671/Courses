I = imread('Assign1_imgs/stereo_pair.jpg');
figure,imshow(I);
I1 = I(1:size(I,1),1:size(I,2)/2);
I2 = I(1:size(I,1),1+size(I,2)/2:size(I,2));

%% Matlab standard code for extracting matching point in two images 
original = I1;
distorted = I2;
ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);
[featuresOriginal,validPtsOriginal] = ...
    extractFeatures(original,ptsOriginal);
[featuresDistorted,validPtsDistorted] = ...
    extractFeatures(distorted,ptsDistorted);
index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
%% Finding Homography
X =  matchedPtsOriginal.Location(1:matchedPtsDistorted.Count,1);
Y = matchedPtsOriginal.Location(1:matchedPtsDistorted.Count,2);

X_c = matchedPtsDistorted.Location(1:matchedPtsDistorted.Count,1);
Y_c = matchedPtsDistorted.Location(1:matchedPtsDistorted.Count,2);
num_points = matchedPtsDistorted.Count;


A = zeros(2*num_points,9);
for i = 1:num_points
    a1 = -X(i)*X_c(i); a2 = -Y(i)*X_c(i); a3 = -X_c(i);
    
    b1 = -X(i)*Y_c(i); b2 = -Y_c(i)*Y(i); b3 = -Y_c(i);
    
    t1 = [X(i),Y(i),1,0,0,0,a1,a2,a3];
    t2 = [0,0,0,X(i),Y(i),1,b1,b2,b3];
    
    A(2*i -1,:) = t1;
    A(2*i,:) = t2; 
end
B = transpose(A);
[U,S,V] = svd(B*A);
H = (reshape(U(:,9),3,3)');
%% Wraping the second image image 
Image = I(1:size(I,1),1+size(I,2)/2:size(I,2),:);
rImage = double(zeros(size(Image)));
for i = 1:size(Image,1)
    for j = 1:size(Image,2)        
           C = [ i ,j , 1]';
           NewC = H*C;
           NewX = round(NewC(1)/NewC(3));
           NewY = round(NewC(2)/NewC(3));
           if((NewX>0)&&(NewX<size(Image,1)))&&((NewY>0)&&(NewY<size(Image,2)))
               rImage(i,j,:) = I((NewX),(NewY),:);
           end                
    end
end
I(1:size(I,1),1+size(I,2)/2:size(I,2),:) = uint8(rImage);
figure,imshow(I);










