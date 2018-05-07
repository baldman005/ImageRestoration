%% LAB 1

%% Exercise 1 - Histogram
clear; close all;

a = readim('meta')
diphist(a,[]);
%b = readim('cermet')
%diphist(b,[]);
%c = readim('fl63x')
%diphist(c,[]);

%% Exercise 2 - Enhancement
clear; close all;

im = newimar(3);
im{1} = readim('meta');
im{2} = readim('maan');
im{3} = readim('ketel');

for i=1:3
   a = im{i}
   diphist(a,[]);
   b = stretch(a)
   diphist(b,[]);
   b = sqrt(a)
   diphist(b,[]);
   b = log(a)
   diphist(b,[]);
   b = hist_equalize(a)
   diphist(b,[]);
end

%% Exercise 3 - Gaussian Derivative Filters
clear; close all;

im = newimar(2);
im{1} = readim('qdna1');
im{2} = readim('meta');

for i=2:2
    a = im{i};
    %dx(a)
    %dy(a)
    %laplace(a,0.1)
    dxx(a)
    dyy(a)
    dxy(a)
end

%% Exercise 4 - Sharpening
clear; close all;

im = newimar(4);
im{1} = readim('meta');
im{2} = readim('unsharp');
im{3} = readim('blurr1');
im{4} = readim('qdna1');

sig = 0.1;
for i=3:3
    a = im{i}
    c = dxx(a,sig) + dyy(a,sig);
    b = dx(a,sig)+dy(a,sig);
    a - b
    a - c
end

%% Exercise 5 - Noise Suppresion
clear; close all;

im = newimar(3);
im{1} = readim('erika_noise');
im{2} = readim('speckle');
im{3} = readim('schema_noise');

a = im{1}
b = unif(a,3,'elliptic')
diphist(a,[]); diphist(b,[]);

%%
for i=1:3
    a = im{i}
    b = gaussf(a,0.5,'best')
    c = medif(a,3,'elliptic')
end

%% Exercise 6 - Binary Analysis 1

a = readim('indparts.tif');
b = a > 25;

bpropagation(newim(b,'bin'),b,0,2,1)

%% Exercise 7 - Binary Analysis 2
clear; close all;

a = readim('bubble.tif');
b = dilation(a,7,'elliptic');
iter = 4;

for i=1:(iter-1)
    b = dilation(b,7,'elliptic');
end;
c = stretch(a/b);

bin = ~(c > 175);

step = 1;
j = 0;
for i= 1:step:256
    j = j+1;
    bin_prev = bin;
    bin = opening(bin,i,'elliptic');
    dif = bin_prev - bin;
    der(j) = sum(dif(:));
    x(j) = i;
    if(j>1 && der(j) == 0 && der(j-1) ~= 0)
        break
    end
end

figure; plot(x,der);

%% Exercise 8 - Binary Analysis 3
clear; close all;

a = readim('lamps.tif');
a = stretch(a)

b = a > 70

stretch(dx(b)+dy(b))

%% Exercise 9 - Binary Analysis 4
clear; close all;

a = readim('components');
a = ~(a > 200);

% capacitors 
cap = opening(a,25,'elliptic');

a = ~(a - cap);
a = ~(bpropagation(newim(a,'bin'),a,0,2,1));

% current stabilizers
stab = opening(a,18,'elliptic');

a = a - stab;

%cilinder cap
cil = opening(a,11,'elliptic');

a = a - cil;

%transistor
tran = opening(a,9,'rectangular');

%resistors
a = a - tran

%% Exercise 10 - Binary Analysis 5
clear; close all;

a = readim('meta');

a = a > 180;

a = ~a;
bound = bpropagation(newim(a,'bin'),a,0,2,1);

a = a & ~bound;

a = opening(a)
opening(a,10,'elliptic')