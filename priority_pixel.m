function [x,y] = priority_pixel(image,BW,ligne,colonne,patch_edge,alpha)

% image : presents the original image minus the mask
% BW : presents the mask image
% ligne : presents the vector containing abscissa of the front pixels
% colonne : presents the vector containing ordinates of the front pixels
% edge_patch : is the edge of the patch which is a square
% alpha = 255 in general

% x : abscissa of the priority pixel
% y : ordinate of the priority pixel

P = priority(image,BW,ligne,colonne,patch_edge,alpha);
pri_max = max(P);
x_pri_max = ligne(P==pri_max); % abscissa vector of the priority pixel
y_pri_max = colonne(P==pri_max); % ordinate vector of the priority pixel

% We consider the first element of priority pixels vector

x = x_pri_max(1); % abscissa of the priority pixel
y = y_pri_max(1); % ordinate of the priority pixel

end