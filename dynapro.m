clc;
close all;
clearvars;

left = double(rgb2gray(imread('view1.png')));
right = double(rgb2gray(imread('view5.png')));

[rows, cols] = size(left);

occlusion = 20;

for r=1:rows
    C(1, 1) = 0;
    for i=2:cols
        C(i, 1) = i*occlusion;
    end
    for j=2:cols
        C(1, j) = i*occlusion;
    end
    z1 = left(r, :);
    z2 = right(r, :);
    for i=2:cols
        for j=2:cols
            min1 = C(i-1, j-1)+(z1(i)-z2(j))^2;
            min2 = C(i-1, j)+occlusion;
            min3 = C(i, j-1)+occlusion;
            cmin = min([min1, min2, min3]);
            C(i, j) = cmin;
            if(min1 == cmin)
                M(i, j) = 1;
            elseif(min2 == cmin)
                M(i, j) = 2;
            elseif(min3 == cmin)
                M(i, j) = 3;
            end
        end
    end
    p = cols;
    q = cols;
    while(p ~= 1 && q ~= 1)
        switch M(p, q)
            case 1
                disleft(r, p) = abs(p-q);
                disright(r, q) = abs(p-q);
                p = p-1;
                q = q-1;
            case 2
                disleft(r, p) = 0;
                p = p-1;
            case 3
                disright(r, q) = 0;
                q = q-1;
        end
    end
    clear C M
end

figure
imshow(uint8(disleft))

figure
imshow(uint8(disright))

%% MSE Calculation
ground1 = double(imread('disp1.png'));
ground2 = double(imread('disp5.png'));
c1 = 0;
c2 = 0;
s1 = 0;
s2 = 0;

for r = 1:rows
    for c = 1:cols
       if disleft(r, c) ~= 0
           s1 = s1+(disleft(r, c)-ground1(r,c))^2;
           c1 = c1+1;
       end
       if disright(r, c) ~= 0
           s2 = s2+(disright(r, c)-ground2(r,c))^2;
           c2 = c2+1;
       end
    end
end
% MSE left = 57.167254
% MSE right = 56.885550
fprintf('MSE left = %f\n', s1/c1);
fprintf('MSE right = %f\n', s2/c2);
