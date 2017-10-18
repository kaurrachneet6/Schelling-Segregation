%Rachneet Kaur
%IIT Delhi
function contact_plot_ann
clear all
close all
clc
toler=0.3;
N=50;
r1=5;
delta =2.5;
[mesh1 dummymesh1] =Initial_mesh_ann(N,r1,delta);
 a=tic;
 [contact1 susep1]=schelling1a(mesh1, dummymesh1,toler,N) ;
 time1=toc(a)
b=tic;
[contact2 susep2]=schelling1b(mesh1, dummymesh1,toler,N) ;
time2=toc(b)
c=tic;
[contact3 susep3]=schelling1c(mesh1, dummymesh1,toler,N) ;
time3=toc(c)
d=tic;
[contact4 susep4]=schelling1d(mesh1, dummymesh1,toler,N) ;
time4=toc(d)
t=1:500;
figure
plot (t,contact1','k', t,contact2','b',t,contact3','r',t,contact4','g');
legend('No switching (f=0)',' No switching (f=0.2)','Switching starts at t=0','Switching starts at t=250');
title('Assemble average of contact density in 4 simulation modes');
xlabel('Time Steps ---->')
ylabel('Assemble average of contact density')
end
