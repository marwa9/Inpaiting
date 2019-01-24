function [C_p] = confidence(image,BW,ligne,colonne,patch_edge)
% image : presents the original image minus the mask
% BW : presents the mask image
% ligne : presents the vector containing abscissa of the front pixels
% colonne : presents the vector containing ordinates of the front pixels
% edge_patch : is the edge of the patch which is a square

demi = round(patch_edge/2);
for i=1:length(colonne)
    matrice=zeros(size(image));
    % Cases of boundary' exceed
    a1 = (ligne(i)-demi<1);
    a2 = (ligne(i)+demi> size(BW,1));
    a3 = (colonne(i)-demi<1);
    a4 = (colonne(i)+demi >size(BW,2));
    matrice(a1+(a1==0)*(ligne(i)-demi):(a2==0)*(ligne(i)+demi)+ a2*end,a3 + (a3==0)*(colonne(i)-demi):(a4==0)*(colonne(i)+demi)+ a4*end)= BW(a1+(a1==0)*(ligne(i)-demi):(a2==0)*(ligne(i)+demi)+ a2*end,a3 + (a3==0)*(colonne(i)-demi):(a4==0)*(colonne(i)+demi)+ a4*end);
    C_p(i)= patch_edge^2 - sum(matrice(:));
end

C_p =(1/patch_edge^2)*C_p;

end