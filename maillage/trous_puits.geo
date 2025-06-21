// ===============================
// Domaine rectangle 1000x800 m avec 2 puits ronds
// ===============================

Lx = 1000;      // longueur (x)
Ly = 800;       // largeur (y)
r_puits = 1;   // rayon des puits
dist_puits = 500; // distance entre les centres des puits
raffinement_puits = 0.5; // maille fine autour des puits
taille_max = 50;       // maille max ailleurs

// --- Sommets du rectangle ---
Point(1) = {0, 0, 0, taille_max};
Point(2) = {Lx, 0, 0, taille_max};
Point(3) = {Lx, Ly, 0, taille_max};
Point(4) = {0, Ly, 0, taille_max};

// Puits d'injection (gauche) 
x_inj = 0.5 * (Lx - dist_puits);
y_inj = Ly / 2;
Point(10) = {x_inj, y_inj, 0, raffinement_puits};
Point(11) = {x_inj + r_puits, y_inj, 0, raffinement_puits};
Point(12) = {x_inj, y_inj + r_puits, 0, raffinement_puits};
Point(13) = {x_inj - r_puits, y_inj, 0, raffinement_puits};
Point(14) = {x_inj, y_inj - r_puits, 0, raffinement_puits};
Circle(100) = {11, 10, 12};
Circle(101) = {12, 10, 13};
Circle(102) = {13, 10, 14};
Circle(103) = {14, 10, 11};
Curve Loop(110) = {100, 101, 102, 103};

// Puits d'extraction (droite)
x_ext = x_inj + dist_puits;
y_ext = y_inj;
Point(20) = {x_ext, y_ext, 0, raffinement_puits};
Point(21) = {x_ext + r_puits, y_ext, 0, raffinement_puits};
Point(22) = {x_ext, y_ext + r_puits, 0, raffinement_puits};
Point(23) = {x_ext - r_puits, y_ext, 0, raffinement_puits};
Point(24) = {x_ext, y_ext - r_puits, 0, raffinement_puits};
Circle(200) = {21, 20, 22};
Circle(201) = {22, 20, 23};
Circle(202) = {23, 20, 24};
Circle(203) = {24, 20, 21};
Curve Loop(210) = {200, 201, 202, 203};

// Bords du rectangle 
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};
Curve Loop(10) = {1, 2, 3, 4};

// Surface principale avec 2 trous (les puits)
Plane Surface(1) = {10, 110, 210};

// Raffinement autour des puits 
Field[1] = Distance;
Field[1].NodesList = {10, 20}; // centres des puits

Field[2] = Threshold;
Field[2].InField = 1;
Field[2].SizeMin = raffinement_puits; // fin autour des puits
Field[2].SizeMax = taille_max;        // grossier ailleurs
Field[2].DistMin = 2 * r_puits;
Field[2].DistMax = 10 * r_puits;

Background Field = 2;

// Groupes physiques pour les conditions aux limites 
Physical Surface("Reservoir") = {1};
Physical Curve("PuitsInj") = {100, 101, 102, 103};
Physical Curve("PuitsExt") = {200, 201, 202, 203};
Physical Line("bord") = {1, 2, 3, 4};