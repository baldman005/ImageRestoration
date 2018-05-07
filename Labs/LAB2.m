%% LAB 2

%% Exercise 1
clear; close all;

a = newim(256,256);
a(128,128) = 200

b = newim(256,256);
for i=0:255
    for j=0:255
        b(i,j) = 200;
    end
end
b
ft(a)
ft(b)

%% Exercise 2
clear; close all;

a = readim('trui');
b = dip_shift(a,[150 150],1);

a_ft = ft(a);
b_ft = ft(b);
abs(a_ft)
abs(b_ft)
phase(a_ft)
phase(b_ft)

%% Exercise 3
clear; close all;

a = readim('ketel');
a_ft = ft(a);
abs_ft = abs(a_ft);
phase_ft = phase(a_ft);

figure; plot(double(abs_ft(128,:)))
figure; plot(double(phase_ft(128,:)))

ift(a_ft)

%% Exercise 4
clear; close all;

a = readim('trui')
a_ft = ft(a);
abs_ft = abs(a_ft);
phase_ft = phase(a_ft);

b = ift(abs_ft)
c = ift(cos(phase_ft)+j*sin(phase_ft))

%% Exercise 5
clear; close all;

a = readim('pillbox');
a_ft = ft(a);
abs(a_ft);

A=zeros(4); A(4,4)=1; A=repmat(A,64,64);
b = a*A;
b_ft = ft(b);
abs(b_ft);

c_ft = b_ft*(a/255);
c = ift(c_ft)