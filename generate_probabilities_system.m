function [A, b] = generate_probabilities_system(rows)
	x = zeros(1, rows);%creeam un vector de lungime 
					   %rows care are pe fiecare pozitie valoarea 0
	%initializam matricea
	A = zeros(rows * (rows + 1) / 2, rows * ( rows + 1) / 2);
	%initializam vectorul
	b = zeros(rows * (rows + 1)/ 2, 1);
	for i = 1 : rows%adaugam in vector ultimul element de pe fiecare rand
		x(i) = i * (i + 1) / 2;
	endfor
	%gasim vecinii pentru fiecare element de pe fiecare rand
	for i = 1 : rows * (rows + 1) / 2; 
		ok = 0;
		for j = 1 : (rows)
			if ( i > x(j) )%verificam pe ce rand se gaseste fiecare element
				l = j + 1;
			endif
			if (i == x(j)) 
				ok = 1;%daca elementul se afla la sfarsitul unui rand 
				l = j;%trebuie analizat separat cazul
			endif
		endfor
		%a b1 c d e f sunt cei sase vecinii ai unui element
		%daca elementul se afla pe randul de jos sau 
		%pe marginea piramidei atunci 
		%unii dintre vecini vor avea valoarea 0,-1,-3 
		%sau -2,in functie de caz
		c = i - 1;
		d = i + 1;
		a = i - l;
		b1 = a + 1;
		e = i + l;
		f = e + 1;
		if (ok == 1)%daca elementul este la capat de rand(partea dreapta) 
					%vecinul din dreapta sus va avea valorea 0 
			b1 = 0;%si elementul de pe aceeasi linie dar la dreapata
					%(care nu face parte din piramida) va avea valorea -1 
			d = -1;
		endif
		if ( 1 + ( (l - 1) * l / 2) == i )
			a = 0;	%elementul de la capat de rand(partea stanga) 
					%va avea valorea 0
			c = -1;	%si elementul de pe aceeasi linie dar la stanga
					%(care nu face parte din piramida) va avea valorea -1
		endif 
		if ( l == rows )
			e = -3; %daca ne afla pe ultimul rand cei doi vecini 
					%vor avea valorea -3 respectiv -2
			f = -2;
		endif
		v = [a b1 c d e f];%adaugam toti vecinii intr-un vector
		k = 0;
		for p = 1 : 6 %calculam coeficientii
			if (v(p) >= 0) 
				k = k + 1;
			endif
			if (v(p) == -2) 
				k = k + 1;
				b(i, 1) = 1;%se adauga termenul liber in vectorul b
			endif
		endfor
		A(i, i) = k;%adaugam coeficientii in matrice
		for p = 1 : 6
			if( v(p) > 0 ) 
				A(i,v(p)) = -1 ;%adaugam coeficientii in matrice
			endif
  		endfor
	endfor
endfunction
