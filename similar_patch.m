function [x,y] = similar_patch(BW_colored,BW,patch_edge,alpha,ligne,colonne,x_pri,y_pri)

% Function computing the coordinates of the pixel centering the most
% similar patch to the patch phi_p

% BW_colored : presents the original image minus the mask
% BW : presents the mask image
% ligne : presents the vector containing abscissa of the front pixels
% colonne : presents the vector containing ordinates of the front pixels
% edge_patch : is the edge of the patch which is a square

% x : abscissa of the pixel centering the similar patch 
% y : ordinate of the pixel centering the similar patch

% Length of the big window surrounding the priority pixel
a_win = patch_edge*3;  
demi = round(patch_edge/2);

[x_pri,y_pri] = priority_pixel(BW_colored,BW,ligne,colonne,patch_edge,alpha)

% We generate a matrix that contains 2 at place of black pixels in the mask
phi_q = 2*ones(size(BW)); 
% We include the window whose length was defined above
phi_q(x_pri - round(a_win/2):x_pri+round(a_win/2),y_pri-round(a_win/2):y_pri+round(a_win/2))= BW(x_pri - round(a_win/2):x_pri+round(a_win/2),y_pri-round(a_win/2):y_pri+round(a_win/2));  

% Now we search the black pixels presenting pixels of the image source
% and located in the reducing window at the same time
[aa,bb]= find(phi_q==0);

%  We eliminate pixels having C(p) less than 1
vecteur = confidence(BW_colored,BW,aa,bb,patch_edge);
aaa= aa(vecteur==1);
bbb= bb(vecteur==1);

% Computing the vector distance between the priority pixel and pixels
% contained in the chosen window and having C(p) = 1
sum = 0;
for k=1:size(aaa,1)
    a= abs(aaa(k) - x_pri);
    b= abs(bbb(k) - y_pri);
    cond1 = aaa(k) - x_pri >= 0 ;
    cond2 = bbb(k) - y_pri >= 0;
    for i=(aaa(k) - demi):(aaa(k) + demi)
    for j = (bbb(k) - demi):(bbb(k) + demi)
        if (BW( cond1*(i-a)+ (cond1==0)*(i+a),cond2*(j-b)+(cond2==0)*(j+b))==0)
            x_i = cond1*(i-a)+ (cond1==0)*(i+a);
            y_i = cond2*(j-b)+(cond2==0)*(j+b) ;
            sum = sum + sqrt((x_i - aaa(k))^2 + (y_i - bbb(k))^2);
        end
    end 
    end
    distance(k) = sum;
    sum = 0;
end 

% pixel centering the patch which is the most similar to phi_p
x = aaa(find(distance-min(distance)==0));
y = bbb(find(distance-min(distance)==0));

end