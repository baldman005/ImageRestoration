%% LAB 3

%% Exercise 1
clear; close all;

imser = newimar(5);
for i=1:5
    imser{i} = readim(['imser' int2str(i)]);
end

for i=1:5
    imser{i}
end

imser_av = newim(256,256);
for i=1:5
    imser_av = imser_av + 0.2*imser{i};
end
imser_av;

%%
imser_ft = newimar(5);
imser_abs = newimar(5);
imser_phase = newimar(5);
for i=1:5
    imser_ft{i} = ft(imser{i});
    imser_abs{i} = abs(imser_ft{i});
    imser_phase{i} = phase(imser_ft{i});
end

%%
cphase = imser_phase{2};

imser_new = newimar(5);
for i=1:5
    imser_new{i} = ift(imser_abs{i}*(cos(cphase) + j*sin(cphase)));
end

imser_new_av = newim(256,256);
for i=1:5
    imser_new_av = imser_new_av + 0.2*imser_new{i};
end
imser_new_av

%% Exercise 2
clear; close all;

a = readim('imser1');

%K = 5e-8;
%Snn = 1e-2;
%Sff = ft(autocorrelation(a));
%PSF = rr(a) <= 10;

%wiener(a,PSF,K,Snn,Sff)
b = uint16(a);
[J,NOISE] = wiener2(b,[4 4]);

a_wiener = dip_image(J)
unif(a)
gaussf(a)

%% Exercise 3
clear; close all;

a = readim('blurr1');
r = 7;
PSF = (rr(a) <= r)*((pi*r^2)^-1);

a_ft = ft(a);
PSF_ft = ft(PSF);

PSF = ift((PSF_ft)^-1);
PSF_ft = PSF_ft^-1;

for i=2:2
    for j=2:2
        for k=2:2
            if(i==1)
                f = 'spectral'
            else
                f = 'spatial'
            end
            if(j==1)
                s = 'spectral'
            else
                s = 'spatial'
            end
            if(k==1)
                t = 'spectral'
            else
                t = 'spatial'
            end
            wut = dip_convolveft(a,PSF,f,s,t);
            stretch(abs(wut));
        end
    end
end

a_rest = ift(a_ft*(PSF_ft));
stretch(abs(a_rest))

%% Exercise 4
clear;

a = readim('finger');
a_ft = ft(a);

b = newim(256,256);
for i=0:255
    for j=100:160
        if (j<=145 && j>= 115)
            b(i,j) = 1;
        end
    end
end

for i=2:4
    R = 15 + 10*(i-1);
    r = R-15;

    PSF = ((rr(a) <= R) - (rr(a)<= r));
    PSF = b*PSF;
    stretch(PSF)
    a_new = ift(PSF*a_ft)
end