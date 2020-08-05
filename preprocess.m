function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
	%adaugam la cale denumirea director-ului cu imagini cu pisici
	x = strcat(path_to_dataset, 'cats/');
	%adaugam la cale denumirea director-ului cu imagini fara pisici
	w = strcat(path_to_dataset, 'not_cats/');
	%se citeste denumirea pentru fiecare imagine 
	%si se adauga in "imgs" si "nimgs"
	imgs = getImgNames(x);
	nimgs = getImgNames(w);
	%se analizeaza cele doua cazuri
	%1.histograma este RGB:
	if (strcmp(histogram,'RGB') == 1)
		[n d] = size(imgs);
		[m e] = size(nimgs);
		y=zeros(n + m, 1);
		%se adauga in matricea X histograma corespunzatoare
		for i = 1 : n
			b = imgs(i,:);
			a = strcat(x,b);
			sol = rgbHistogram(a, count_bins);
			X(i, 1 : 3 * count_bins) = sol(1 : 3 * count_bins);
			%y(i) ia valorea 1 pentru imagine cu pisici
			y(i) = 1;
		endfor
		for i = 1 : m
			c = nimgs(i, :);
			a = strcat(w, c);
			sol = rgbHistogram(a, count_bins);
			X(i + n, 1 : 3 * count_bins) = sol(1 : 3 * count_bins);
			%y(i) ia valorea -1 pentru imagine cu pisici
			y(i + n) = -1;
		endfor
	endif
	%2.histograma este HSV
	if (strcmp(histogram,'HSV') == 1)
		[n d] = size(imgs);
		[m e] = size(nimgs);
		y=zeros(n + m, 1);
		%se adauga in matricea X histograma corespunzatoare
		for i = 1 : n
			b = imgs(i, :);
			a = strcat(x, b);
			sol = hsvHistogram(a, count_bins);
			X(i, 1 : 3 * count_bins) = sol(1 : 3 * count_bins);
			%y(i) ia valorea 1 pentru imagine cu pisici
			y(i) = 1;
		endfor
		for i = 1 : m
			c = nimgs(i, :);
			a = strcat(w, c);
			sol = hsvHistogram(a, count_bins);
			X(i + n, 1 : 3 * count_bins) = sol(1 : 3 * count_bins);
			%y(i) ia valorea -1 pentru imagine cu pisici
			y(i + n) = -1;
		endfor
	endif
endfunction

