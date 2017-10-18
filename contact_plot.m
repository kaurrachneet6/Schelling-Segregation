function contact_plot
clear all
close all
clc
toler=0.3;
f=0.20;
N=30;
[grid1 dummygrid1] = initial_mesh(f,N);
a=tic
[contact1 susep1]=schelling1a(grid1, dummygrid1,toler,N) ;
time1=toc(a)
b=tic
[contact2 susep2]=schelling1b(grid1, dummygrid1,toler,N) ;
time2=toc(b)
c=tic
 [contact3 susep3]=schelling1c(grid1, dummygrid1,toler,N) ;
 time3=toc(c)
d=tic
[contact4 susep4]=schelling1d(grid1, dummygrid1,toler,N) ;
time4=toc(d)
t=1:500;
figure
plot (t,contact1', t,contact2',t,contact3',t,contact4');
legend('No switching (f=0)',' No switching (f=0.2)','Switching starts at t=0','Switching starts at t=250');
title('Assemble average of contact density in 4 simulation modes');
xlabel('Time Steps ---->')
ylabel('Assemble average of contact density')
end
