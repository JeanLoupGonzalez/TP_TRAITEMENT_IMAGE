%//////////////PARTIE 1 FILTRE MEDIAN ET DECONVOLUTION/////////
img=double(imread("/MATLAB Drive/image_poteau.png"));
%on ne garde qu'une composante parmi les 3 couleurs
%pour avoir une matrice de dimension 2
img=img(:,:,1);

%on bruite l'image manuellement
img_bruitee=img;
S=size(img_bruitee);

% debut=550;
% pas=1;
% max=560;
% listeEQMbruit=[];
% listeEQMmedian=[];
% for n = debut:pas:max
%     for i = 1:n
%         %tire un pixel au hasard
%         x=round(rand(1)*(S(1)-1)+1);
%         y=round(rand(1)*(S(2)-1)+1);
%         %met ce pixel a 0
%         img_bruitee(x,y)=0;
%         %tire un pixel au hasard
%         x=round(rand(1)*(S(1)-1)+1);
%         y=round(rand(1)*(S(2)-1)+1);
%         %le met a 255
%         img_bruitee(x,y)=255;
%     end
% 
%     %calcul de l'EQM entre image originale et image bruitee
%     EQM=sum(sum((img-img_bruitee).^2))/(S(1)*S(2));
%     listeEQMbruit = [listeEQMbruit,EQM]
%     %fprintf('EQM entre image originale et image bruitee  = %d\n',EQM)
% 
%     % on applique un filtre médian sur l'image bruitée
%     % 
%     img_bruitee_filtre_median=img_bruitee;
%     for i = 1:S(1)-4
%         for j = 1:S(2)-4
%             % on recupere un vecteur colonne de 25 intensites triees
%             % par ordre croissant
%             vect_intensites_trie = sort(reshape(img(i:i+4,j:j+4),[],1));
%             % on remplace dans un copie de l'image bruitee le pixel au 
%             % centre de la sous matrice 5*5
%             % qu'on vient d(extraire par l'intensite mediane calculee
%             img_bruitee_filtre_median(i+2,j+2)= vect_intensites_trie(13);
%         end
%     end
% 
%     %calcul EQM entre image bruitee filtree par filtre median et img originale
%     EQM_median=sum(sum((img-img_bruitee_filtre_median).^2))/(S(1)*S(2));
%     listeEQMmedian = [listeEQMmedian,EQM_median]
%     %fprintf('EQM entre image originale et image bruitee filtree  = %d\n',EQM_median)
% end
% 
% %affiche l'image de base en niveaux de gris, non bruitée
% figure
% image(uint8(img));
% colormap(gray(256));
% 
% %affiche l'image bruitée
% figure
% image(uint8(img_bruitee));
% colormap(gray(256));
% 
% %affichage de cette image bruitee filtree par filtre median
% figure
% image(uint8(img_bruitee_filtre_median));
% colormap(gray(256));
% % on remarque que sur les bords de l'image (sur une bande 
% % de 4 pixels, l'image n'est pas filtree
% 
% %affiche les courbes EQM
% figure
% plot(listeEQMbruit)
% hold on
% plot(listeEQMmedian)
% hold off

%////////////////CONCLUSION/////////////////////////////////
%à partir de 556 pixels de bruit (environ),
%l'EQM du filtrage médian sur l'image bruitee est 
%inferieure à l'EQM de l'image bruitee
%---> il est donc intéressant de réaliser un filtrage médian
%sur une image bruitée à partir de 556 pixels de bruit environ
% 
% %//////////////PARTIE 2 : MASQUE FLOU////////////////////////
img2=double(imread("/MATLAB Drive/img_floue.png"));
%pour avoir matrice de dimension 2
img2=img2(:,:,1);
%un prend un filtre "assez" grand pr avoir un flou "prononcé"
%attention, on divise par taille_filtre^2
filtre_moyenne_passe_bas=ones(9)/81

%img de base
figure
image(uint8(img2))
colormap(gray(256));

%on réalise la convolution en gardant la taille de l'image convoluee
%intacte puis plot les 2 images
figure
img2_floutee=conv2(img2,filtre_moyenne_passe_bas,'same')
image(uint8(img2_floutee))
colormap(gray(256));

%masque flou
img_masque_flou=img2-img2_floutee;
figure
image(uint8(img_masque_flou))
colormap(gray(256));

%amplification de la partie nette
coeff=2;
img_amplifie_nette=img_masque_flou*coeff;
%report sur image de depart
img_apres_masque_flou=img2-img_amplifie_nette;
figure
image(uint8(img_apres_masque_flou))
colormap(gray(256));
