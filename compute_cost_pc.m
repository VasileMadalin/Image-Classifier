function [cost] = compute_cost_pc(points, centroids)
	%copiem in n numarul de puncte
	%copiem in d dimensiunea punctelor
	[n d] = size(points);
	[NC d] = size(centroids);
	cost = 0;
	for i = 1 : n   %calculam distanta minima de la fiecare 
			%punct la centroidul clusterului caruia ii apartine
		minn=10000000;       
		for p = 1 : NC
			%se calculeaza distanta euclidiana la patrat
			dist = 0;
			for j = 1 : d
				s = (centroids(p,j)-points(i,j));
            			dist = dist + s * s;
			endfor
			if (dist < minn) 
				minn = dist;
			endif
		endfor
		%se adauga distanta  la cost
		cost = cost + sqrt(minn);
	endfor
endfunction

