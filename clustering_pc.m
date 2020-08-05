function [centroids] = clustering_pc(points, NC)
	%copiem in n numarul de puncte
	%copiem in d dimensiunea punctelor
	[n d] = size(points);
	A = zeros(n,d);%in aceasta matrice se face suma elementelor
	B = zeros(n,d);%in aceasta matrice se numara fiecare punct
	centroids = zeros(NC,d);%matricea in care se afla centroizii
	for i = 1 : n
		a = mod(i,NC);
		if( a==0 ) 
			a = NC;
		endif
		%se creeaza matricea A
		%se creeaza matricea B
		A(a,1:d) = A(a,1:d) + points(i,1:d);
		B(a,1:d) = B(a,1:d) + 1;
	endfor
	%se creeaza centroizii
	for i = 1 : NC
		for j = 1 : d
			centroids(i,j) = A(i,j) / B(i,j);
		endfor
	endfor
	iteratii = 1;
	%se parcurge fiecare iteratie
	while (iteratii < 21)
		v = zeros(1, NC);
		MAT = zeros(NC, n);
		%se cauta punctele cele mai apropiate de fiecare centroid
		for i = 1 : n
			minn = 10000000;       
			for p=1:NC
				dist = 0;
				%se calculeaza distanta euclidiana(la patrat)
				for j = 1 : d
					s = (centroids(p,j) - points(i,j));
					dist = dist+s*s;
				endfor
				if (dist < minn) 
					minn = dist;
					k = p;
				endif
			endfor
			%creste numarul de puncte asociate fiecaruie centroid
			v(k) = v(k) + 1;
			%adaugam si punctul gasit intr-o matrice 
			MAT(k,v(k)) = i;
		endfor
  		cent = zeros(NC, d);
		for p = 1 : NC
			k = 0;
			%se caluleaza noua pozitie pentru fiecare centroid
			for i = 1 : v(p)
				cent(p,1:d)=cent(p,1:d)+points(MAT(p,i),1:d);
			endfor 
			if( v(p) != 0)
        			cent(p,1:d)=(cent(p,1:d))/v(p);
			endif
		endfor
		%creste iteratia
		iteratii = iteratii + 1;
		centroids = cent;
	endwhile
endfunction
