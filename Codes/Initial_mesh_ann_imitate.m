function [lattice dummylattice] = Initial_mesh_ann_imitate(N,r1,delta,switch_ann)
H=N/2;
vacant_frac = 0.15;
agent1=0.5;
r2=r1+ delta;
    dist = randperm(N);
    for i=1:N
        x = dist(i);
        for j=1:N
            y = dist(j);
            if ((((x-H)*(x-H))+ ((y-H)*(y-H))) >= r1*r1) && ((((x-H)*(x-H))+ ((y-H)*(y-H))) <r2*r2)
                p=rand(1);
                if(p<switch_ann)
                 dummylattice(x,y)=3;
                if (rand(1) > agent1) 
                    lattice(x,y) = 2;
                else
                    lattice(x,y) = 1;
                end
                else 
                    if (p> vacant_frac)
                if (rand(1) > agent1)
                    lattice(x,y) = 2;
                    dummylattice(x,y)=2;
                else
                    lattice(x,y) = 1;
                    dummylattice(x,y)=1;
                end
                  else
                lattice(x,y)=0;
                dummylattice(x,y)=0;
                    end
                end
                else
            if (rand(1) > vacant_frac)
                if (rand(1) > agent1)
                    lattice(x,y) = 2;
                    dummylattice(x,y)=2;
                else
                    lattice(x,y) = 1;
                    dummylattice(x,y)=1;
                end
            else
                lattice(x,y)=0;
                dummylattice(x,y)=0;
        end
    end

    end
end
end
