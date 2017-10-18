function imitate_gaussiantoshow
clear all
close all
clc
toler=0.3;
N=100;
xpara = 0.3;
r1=N*xpara;
ypara =0.25;
f= 0.5;
delta=ypara*r1;
      %  r1=r2-delta;
c=zeros(6,1);
d=zeros(6,1);
for i=1:1       
[mesh1 dummymesh1] =initialmesh_ann_imitate_gaussian(N,r1,delta,f);
[contact2 susep2]=schelling1b_annulus_toshow(mesh1, dummymesh1,toler,N) ;
d(i)= contact2(500);
end
f
c'
d'
figure
plot (f,c','*-b',f,d','o-k');
legend('With activated switching agents','With deactivated switching agents');
title('contact dens. for diff. fractions of switching agents in annulus');
xlabel('fraction of switching agents inside annulus');
ylabel('Contact density at segreagted stage');    
end
