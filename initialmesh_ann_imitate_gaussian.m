function [lattice dummylattice] = initialmesh_ann_imitate_gaussian(N,r1,delta,switch_ann)
vacant_frac = 0.15;
H=N/2;
agent1=0.5;
r2=r1+ delta;
sites=floor(switch_ann*N*N*(1-vacant_frac))
dummylattice=zeros(N);
i=1;
while(i<=sites)
    theta = 2*pi*rand(1);
d = delta*randn(1) +r1;
x=H+d*cos(theta);
y=H+d*sin(theta);
n_x = floor(x);
n_y=floor(y);
if ((n_x >=1 && n_x <=N)&&(n_y >=1 && n_y <=N) )
    if(dummylattice(n_x,n_y)==0)
    i=i+1;
  dummylattice(n_x,n_y)=3;  
    if (rand(1) > agent1) 
                    lattice(n_x,n_y) = 2;
                else
                    lattice(n_x,n_y) = 1;
    end
end
end
end
te = 1- (switch_ann)*(1-vacant_frac);
new_vacant= vacant_frac/te;
dist = randperm(N);
    for i=1:N
        x0 = dist(i);
        for j=1:N
            y0 = dist(j);
            if(dummylattice(x0,y0)~=3)
            if (rand(1) > new_vacant)
                if (rand(1) > agent1)
                    lattice(x0,y0) = 2;
                    dummylattice(x0,y0)=2;
                else
                    lattice(x0,y0) = 1;
                    dummylattice(x0,y0)=1;
                end
            else
                lattice(x0,y0)=0;
                dummylattice(x0,y0)=0;
        end
            end
    end
    end
end