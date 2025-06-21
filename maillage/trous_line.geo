// ===============================
// Domaine rectangle 1000x800 m avec segments droits pour les puits
// ===============================

// Paramètres géométriques 
lc  = 25*2;      // maille globale
lc2 = 2.5*2;     // maille fine autour des puits
lc3 = 15*2;      // maille intermédiaire
L = 1000;        // longueur du rectangle
l = 800;         // largeur du rectangle

// Sommets du rectangle 
Point(0) = {0, 0, 0, lc};
Point(1) = {L, 0, 0, lc};
Point(2) = {L, l, 0, lc};
Point(3) = {0, l, 0, lc};
// Sommets des segments des puits (gauche)
Point(4) = {250, 300, 0, lc2};
Point(5) = {250, 500, 0, lc2};
Point(8) = {250, 400, 0, lc2};

// Sommets des segments des puits (droite)
Point(6) = {750, 300, 0, lc2};
Point(7) = {750, 500, 0, lc2};
Point(9) = {750, 400, 0, lc2};

// Point central
Point(10) = {500, 400, 0, lc3};

// Définition des lignes du rectangle 
Line(1) = {0, 1};
Line(2) = {1, 2};
Line(3) = {2, 3};
Line(4) = {3, 0};

// Segments des puits (gauche et droite)
Line(5) = {4, 8};   // puits gauche bas
Line(6) = {8, 5};   // puits gauche haut
Line(7) = {6, 9};   // puits droit bas
Line(8) = {9, 7};   // puits droit haut

// Boucle pour la surface principale
Line Loop(1) = {1, 2, 3, 4};
Ruled Surface(1) = {1};

// Insertion des segments dans la surface 
Line{5} In Surface {1};
Line{6} In Surface {1};
Line{7} In Surface {1};
Line{8} In Surface {1};
Point{10} In Surface {1}; // raffinement au centre

// Groupes physiques pour les conditions aux limites
Physical Surface(1) = {1};
Physical Line("PuitsInj") = {5, 6};
Physical Line("PuitsExt") = {7, 8};
Physical Line("bord") = {1, 2, 3, 4};