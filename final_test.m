clc
close all
f = imread ('image_test.png') ;
figure; imshow(uint8(f));
f = rgb2gray(f); % We are going to use gray images
f=double(f);
% Choice of the targer region
% c = [222 272 300 270 221 194];
% r = [21 21 75 121 121 75];
% BW = roipoly(f,c,r); 

% Choice of the target region BW
H = impoly;
pos = getPosition(H);
BW=roipoly(f,pos(:,1),pos(:,2));

% Generating original image minus the mask
BW_colored = f;
BW_colored(BW == 1)= 255;
figure, imshow(uint8(BW_colored));
superposition = BW_colored;

% In the mask image, roipoly sets pixels inside the region to 1 
% and pixels outside the region to 0.
figure, imshow(BW)

% Size of patch
patch_edge = 9;
demi = round(patch_edge/2);

% Normalization factor
alpha = 255;

while (1)
    front = edge(BW);
    [ligne,colonne] = find(front);
   
    % Arrest condition
    if (isempty(ligne))
        break;
    end
    
    % Computing priority for border'pixels 
    P = priority(BW_colored,BW,ligne,colonne,patch_edge,alpha);
    [x_pri,y_pri] = priority_pixel(BW_colored,BW,ligne,colonne,patch_edge,alpha);
    
    % Searching the suitable similar patch
    [x_similar1,y_similar1] = similar_patch(BW_colored,BW,patch_edge,alpha,ligne,colonne,x_pri,y_pri);
    
    % Copy pixels from similar patch to priority patch
    x_similar = x_similar1(1);
    y_similar = y_similar1(1);

    demi = round(patch_edge/2);
    a= abs(x_similar - x_pri);
    b= abs(y_similar - y_pri);
    cond1 = x_similar - x_pri >= 0 ;
    cond2 = y_similar - y_pri >= 0;
    image = BW_colored;
    mask  = BW;
    for i=(x_similar - demi):(x_similar + demi)
    for j = (y_similar - demi):(y_similar + demi)
        if (BW( cond1*(i-a)+ (cond1==0)*(i+a),cond2*(j-b)+(cond2==0)*(j+b))==1)
            BW_colored( cond1*(i-a)+ (cond1==0)*(i+a),cond2*(j-b)+(cond2==0)*(j+b))=BW_colored(i,j);
            mask( cond1*(i-a)+ (cond1==0)*(i+a),cond2*(j-b)+(cond2==0)*(j+b)) = 0;
        end
    end 
    end
    BW = mask;
    imshow(uint8(BW_colored));
 
end

imshow(uint8(BW_colored));
