function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
	%adaugam la cale denumirea director-ului cu imagini cu pisici
	x = strcat(path_to_testset, 'cats/');
  %adaugam la cale denumirea director-ului cu imagini fara pisici
	y = strcat(path_to_testset, 'not_cats/');
  %se citeste denumirea pentru fiecare imagine 
	%si se adauga in "imgs" si "nimgs"
	imgs = getImgNames(x);
	nimgs = getImgNames(y);
  %se analizeaza cele doua cazuri
	%1.histograma este RGB:
	if (strcmp(histogram,'RGB') == 1)
		[n d] = size(imgs);
		[m d] = size(nimgs);
		nr1 = 0;
		nr2 = 0;
		for i = 1 : n
      %se copiaza in b denumirea imaginii
			b = imgs(i, :);
      %se apeleaza functia pentru histograma
			a = strcat(x, b);
			sol = rgbHistogram(a, count_bins);
			sol(3 * count_bins + 1) = 1;
			s1 = 0;
      %se calculeaza produsul scalar
			s1 = sol*w;
      %daca s este mai mare decat 0 atunci 
			%este o poza cu pisica
			if (s1 >= 0) 
				nr1 = nr1 + 1;
			endif
		endfor
		for i = 1 : m
      %se copiaza in t denumirea imaginii
			t = nimgs(i, :);
			d = strcat(y, t);
      %se apeleaza functia pentru histograma
			sol = rgbHistogram(d, count_bins);
			[l p]=size(w);
			sol(3 * count_bins + 1) = 1;
			s1 = 0;
      %se calculeaza produsul scalar
			s1 = sol * w;
      %daca s este mai mica decat 0 atunci 
			%este o poza fara pisica
			if(s1 < 0) 
				nr2 = nr2 + 1;
			endif
		endfor
		s = nr1 + nr2;
    %se caluculeaza procentul
		percentage = (s/(n+m));
	endif
  %2.histograma este HSV
	if (strcmp(histogram, 'HSV') == 1)
		[n d] = size(imgs);
		[m d] = size(nimgs);
		nr1 = 0;
		nr2 = 0;
		for i = 1 : n
      %se copiaza in b denumirea imaginii
			b = imgs(i, :);
			a = strcat(x, b);
      %se apeleaza functia pentru histograma
			sol = hsvHistogram(a, count_bins);
			sol(3 * count_bins + 1) = 1;
			s = 0;
      %se calculeaza produsul scalar
			s = sol*w;
      %daca s este mai mare decat 0 atunci 
			%este o poza cu pisica
			if(s >= 0) 
				nr1 = nr1 + 1;
			endif
		endfor
		for i = 1 : m
      %se copiaza in b denumirea imaginii
			t = nimgs(i, :);
			d = strcat(y,t);
      %se apeleaza functia pentru histograma
			sol = hsvHistogram(d, count_bins);
			sol(3 * count_bins + 1) = 1;
			s1 = 0;
      %se calculeaza produsul scalar
			s1 = sol * w;
      %daca s este mai mare decat 0 atunci 
			%este o poza fara pisica      
			if(s1 < 0) 
				nr2 = nr2 + 1;
			endif
		endfor
		s = nr1 + nr2;
    %se caluculeaza procentul
		percentage = (s/(n+m));
	endif
endfunction
