%Rachneet Kaur
%IIT Delhi
function imitate_tolerchange
clear all
close all
clc
N=100;
xpara = 0.35;
r2=N*xpara;
ypara =0.5;
f= [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
toler = [ 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
delta=ypara*r2;
        r1=r2-delta;
c=zeros(10,1);
d=zeros(10,1);
for i=1:11    
[mesh1 dummymesh1] =Initial_mesh_ann_imitate(N,r1,delta,f(i));
 for j=1:10
[contact2 susep2]=schelling1b(mesh1, dummymesh1,toler(j),N) ;
[contact3 susep3]=schelling1c(mesh1, dummymesh1,toler(j),N) ;
c(j)= contact3(500);
d(j)= contact2(500);
 end
figure
plot (toler,c','*-b',toler,d','o-k');
legend('With activated switching agents','With deactivated switching agents');
title('contact dens. for diff. tolrances');
xlabel('tolerances');
ylabel('Contact density at segreagted stage'); 
end
end