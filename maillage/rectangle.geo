// ===============================
// Domaine rectangle 1000x800 m avec segments droits pour les puits
// ===============================

// Paramètres géométriques 
lc  = 25*2;      // maille globale
lc2 = 2.5*2;     // maille fine autour des puits
lc3 = 15*2;      // maille intermédiaire
L = 500;        // longueur du rectangle
l = 5000;         // largeur du rectangle

// Sommets du rectangle 
Point(0) = {0, 0, 0, lc};
Point(1) = {L, 0, 0, lc};
Point(2) = {L, l, 0, lc};
Point(3) = {0, l, 0, lc};


// Définition des lignes du rectangle 
Line(1) = {0, 1};
Line(2) = {1, 2};
Line(3) = {2, 3};
Line(4) = {3, 0};



// Boucle pour la surface principale
Line Loop(1) = {1, 2, 3, 4};
Ruled Surface(1) = {1};


// Groupes physiques pour les conditions aux limites
Physical Surface("resorvoir") = {1};
Physical Line("PuitsInj") = {4};
Physical Line("PuitsExt") = {2};
Physical Line("bord") = {1, 3};