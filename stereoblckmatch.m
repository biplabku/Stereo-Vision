%% Stereo Vision project for computer Vision
%% author @Biplab das
clc;
clearvars;
% define your block size for checking the code
bsz = 3;
L = imread('view1.png');
R = imread('view5.png');
% gray scale conversion
L = rgb2gray(L);
R = rgb2gray(R);
L = im2double(L);
R = im2double(R);
[r, c] = size(L);
range = 75;
L = PadZero(L, bsz); 
R = PadZero(R, bsz); 
ssd2 = zeros(range, 1);
ssd2_ = zeros(range, 1);
Dmap_left = zeros(r, c);
Dmap_right = zeros(r, c);

%% for left image constant and carrying out search in right image
for i = 1:1:r
    for j = 1:1:c
        if(j < (range+1))
            new = j;
            for siter = 0:1:(new-1)
               temp_left = 0;
               for l = 0:1:bsz-1
                   for m = 0:1:bsz-1
                       temp_left = temp_left + (L(i + l, j + m) - R(i + l, j + m - siter))^2;   % view1 - view5       
                   end
               end
               ssd2(siter + 1,1) = temp_left; 
            end
            minval = min(ssd2); 
            [r1, c1] = find(ssd2==min(min(ssd2))); 
            minPos = (j) + r1(1); 
            Dmap_left(i, j) = abs(minPos - j);      
        else 
            for siter = 0:1:range-1
               temp1_left = 0;
               for l = 0:1:bsz-1
                   for m = 0:1:bsz-1
                       temp1_left = temp1_left + ( L(i + l, j + m) - R(i + l, j + m - siter))^2;   % view1 - view5     
                   end
               end
               ssd1(siter + 1, 1) = temp1_left ; 
            end
            [r0, c0] = find(ssd1==min(min(ssd1))); 
            minPos1 = j + r0(1); 
            Dmap_left(i, j) = abs(minPos1 - j); 
        end
    end
end


%% for right image constant and carrying out search in left image

for i = 1:1:r
    for j = 1:1:c
        if((c - j) >= range)
            for siter = 0:1:range-1
               temp_right = 0;
               for l = 0:1:bsz-1
                   for m = 0:1:bsz-1
                       temp_right = temp_right + (R(i + l, j + m) - L(i + l, j + m + siter))^2;       % view5 - view1
                   end
               end
               ssd2_(siter + 1,1) = temp_right; 
            end
            minval_ = min(ssd2_);  
            [r1_, c1_] = find(ssd2_==min(min(ssd2_)));
            minPos_ = (j) + r1_(1); 
            Dmap_right(i, j) = abs(minPos_ - j);    
        else  
            new = c - j; 
            for siter = 0:1:new - 1
               temp1_right = 0;
               for l = 0:1:bsz-1
                   for m = 0:1:bsz-1
                       temp1_right = temp1_right + ( R(i + l, j + m) - L(i + l, j +m+ siter))^2;  % view5 - view1             
                   end
               end
               ssd1_(siter + 1, 1) = temp1_right ;
            end
            [r0_, c0_] = find(ssd1_==min(min(ssd1_)));
            minPos1_ = j + r0_(1);
            Dmap_right(i, j) = abs(minPos1_ - j);
        end
    end
end
Dmap_left = uint8(Dmap_left);
Dmap_right = uint8(Dmap_right);
figure
imshow(Dmap_left)
figure
imshow(Dmap_right)

%% calculation of mean square error between the ground truth maps
Dtruthleft = uint8(imread('disp1.png'));
Dtruthright = uint8(imread('disp5.png'));
% values of minimum square error of the disparities between the ground
% truth and the disparity maps obtained according to us.
mstmp_left = immse(Dmap_left, Dtruthleft);
mstmp_right = immse(Dmap_right, Dtruthright);






