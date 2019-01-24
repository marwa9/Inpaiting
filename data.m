function [D_p] = data(BW,BW_colored,ligne,colonne,alpha)
% BW_colored : presents the original image minus the mask
% BW : presents the mask image

% Gradient 
gradient_BW_x = BW_colored(:,2:end)- BW_colored(:,1:end-1);
gradient_BW_y = BW_colored(2:end,:)- BW_colored(1:end-1,:);

gradient_Ip_x = [];
gradient_Ip_y = [];

for i=1:length(ligne)
     gradient_Ip_x(i)= gradient_BW_x(ligne(i),colonne(i));
     gradient_Ip_y(i)= gradient_BW_y(ligne(i),colonne(i));
end

% The orthogonal of Gradient
% Orientation in the trigonometric direction
gradient_Ip_x_orth = (-1)* gradient_Ip_x;
gradient_Ip_y_orth = gradient_Ip_y;

% Normalisation
tmp = sqrt(gradient_Ip_x_orth.^2 + gradient_Ip_y_orth.^2);
gradient_Ip_x_orth = gradient_Ip_x_orth./tmp;
gradient_Ip_x_orth = gradient_Ip_x_orth./tmp;

% Smoothing the image : Convolution with the derived of gaussian filter
h = fspecial('gaussian',[10 10],20); % filtre moyenneur passe bas
image_lisse = imfilter(double(BW),h,'replicate');

gradient_BW_x1 = image_lisse(:,2:end)-image_lisse(:,1:end-1);
gradient_BW_y1 = image_lisse(2:end,:)-image_lisse(1:end-1,:);

% Normalisation
 tmp1 = sqrt(gradient_BW_x1(1:end-1,:).^2 + gradient_BW_y1(:,1:end-1).^2);
 
 gradient_BW_x1 = gradient_BW_x1(1:end-1,:)./tmp1;
 gradient_BW_y1 = gradient_BW_y1(:,1:end-1)./tmp1;

 gradient_Ip_x1 = [];
 gradient_Ip_y1 = [];

% Normal vector
n_p = zeros(size(BW));

% Selecting the pixels which belong to the border
for i=1:length(ligne)
     gradient_Ip_x1(i)= gradient_BW_x1(ligne(i),colonne(i));
     gradient_Ip_y1(i)= gradient_BW_y1(ligne(i),colonne(i));
end

grad_final = gradient_Ip_x1.*gradient_Ip_x_orth + gradient_Ip_y1.*gradient_Ip_x_orth;
D_p = (1/alpha)*abs(grad_final);

end