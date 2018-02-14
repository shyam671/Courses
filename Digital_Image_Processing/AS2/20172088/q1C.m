I = imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/other_images/onion.png');
I = imresize(I,[32,32]);
N = 1;
figure
subplottight(1,5,1), imshow((I));title('original'); 
%% Linear Interp
image = double(I);
Scale = 1/2;
upsampled = zeros(2*size(image,1),2*size(image,2),3);
upsampled(1:2:end,1:2:end,:) = image;
for i = 2:2:size(upsampled,1)-1
    for j = 1:2:size(upsampled,2)-1
         upsampled(i,j,:) =  (upsampled(i-1,j,:) + upsampled(i+1,j,:))/2;
    end
end
for j = 2:2:size(upsampled,1)-1
    upsampled(:,j,:) = (upsampled(:,j-1,:) + upsampled(:,j+1,:))/2 ;
end
upsampled = upsampled(1:end-2,1:end-2,:);
subplottight(1,5,2),imshow(uint8(upsampled));title('Linear');
%% nn Interp
image = double(I);
for r = 1:N
 upsampled = zeros(2*size(image,1),2*size(image,2),3);
 upsampled(1:2:end,1:2:end,:) = image;
 upsampled(2:2:end,2:2:end,:) = image;
 upsampled(1:2:end,2:2:end,:) = image;
 upsampled(2:2:end,1:2:end,:) = image;
 image = upsampled;
end

subplottight(1,5,3),imshow(uint8(upsampled));title('Nearest Neighbour');
%% Bilinear Interp
image = double(I);
Scale = (1/2);
upsampled = zeros(2*size(image,1),2*size(image,2),3);
for i = 2:size(upsampled,1)-1
    for j = 2:size(upsampled,2)-1
        rf = i*Scale ; cf = j*Scale;
        ro = floor(rf); co = floor(cf);
        d_r = rf-ro ; d_c = cf - co;
        upsampled(i,j,:) = image(ro,co,:)*(1-d_r)*(1 - d_c) + image(ro + 1, co,:)*d_r*(1- d_c) ...
                         + image(ro,co + 1,:)*(1-d_r)*d_c + image(ro + 1,co + 1,:)*d_r*d_c;
    end
end
upsampled = upsampled(2:end-1,2:end-1,:);
subplottight(1,5,4),imshow(uint8(upsampled));title('Bilinear');
%% Bicubic Interp
image = double((I));
Scale = ((size(image,1))/(2*size(image,1)));
upsampled = zeros(2*size(image,1),2*size(image,2),3);
for i = 5:1:size(upsampled,1)-3
    for j = 5:1:size(upsampled,2)-3
        rf = i*Scale ; cf = j*Scale;
        r = floor(rf); c = floor(cf);
        d_r = rf-r ; d_c = cf - c;
        temp = 0;
        for m = -1:2
            for n = -1:2
             P_dr = 1/6*( (max(d_r-m+2,0)^3) -4*(max(d_r-m+1,0)^3) +6*(max(d_r-m,0)^3) -4*(max(d_r-m-1,0)^3));
             P_dc = 1/6*( (max(n-d_c+2,0)^3) -4*(max(n-d_c+1,0)^3) +6*(max(n-d_c,0)^3) -4*(max(n-d_c-1,0)^3));   
             temp = temp + image(r + m,c + n,:)*P_dr*P_dc;        
            end
        end
        upsampled(i,j,:) = temp;
    end
end
upsampled = upsampled(5:end-3,5:end-3,:);
subplottight(1,5,5),imshow(uint8(upsampled));title('Cubic');









