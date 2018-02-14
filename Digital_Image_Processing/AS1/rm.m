% %% Bilateral Filtering
% I = double(rgb2gray(imread('Assign1_imgs/bell.jpg')));
% I = imresize(I,[size(I,1)/2 size(I,2)/2]);
% figure,imshow(uint8(I));
% sig_d = 3;sig_r = 50;
% Wsize = 2;
% for i = 1:size(I,1)-2*Wsize -1
%     for j = 1:size(I,2)-2*Wsize -1
%         W = zeros(2*Wsize+1);
%         midI = I(i+Wsize,j+Wsize);
%         midx = i+Wsize;
%         midy = j+Wsize;
%         i1 = 1;i2 = 1;
%         for x = i:i+2*Wsize
%             for y = j:j+2*Wsize
%                 W(i1,i2) = exp( -( ( (midx-x)^2 + (midy-y)^2 )/(2*sig_d^2) + (abs(I(midx,midy)-I(x,y))^2)/(2*sig_r^2)  ) );
%                 i2 = i2 + 1; 
%             end 
%             i1 = i1 + 1;
%             i2 = 1;
%         end
%          I(i+Wsize,j+Wsize) = sum(sum(I(i:i+2*Wsize,j:j+2*Wsize).*W))/sum(W(:));        
%        
%     end
% end
% figure ,imshow(uint8(I));