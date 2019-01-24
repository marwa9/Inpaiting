function [P] = priority(image,BW,ligne,colonne,patch_edge,alpha)
% image : presents the original image minus the mask
% BW : presents the mask image
% ligne : presents the vector containing abscissa of the front pixels
% colonne : presents the vector containing ordinates of the front pixels
% edge_patch : is the edge of the patch which is a square
% alpha = 255 in general

C_p = confidence(image,BW,ligne,colonne,patch_edge);
D_p = data(BW,image,ligne,colonne,alpha);
P = C_p.*D_p;

end
