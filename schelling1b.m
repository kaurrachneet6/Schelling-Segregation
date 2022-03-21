%Rachneet Kaur
%Inactive switching agents
function [contact susep] = schelling1b(lattice,dummylattice,toler,l_size)
figure
disp(lattice);
max = 500;
u_move = 0.2;
h_move = 1e-04;
contact = zeros(max,1);
tem = zeros(max,1);
susep = zeros(max,1);
visit = zeros(l_size);
for t=1:max
    s=0;
    c=0;
    s1=0;
    for i=1:l_size
        for j=1:l_size
            if (lattice(i,j)~=0)
                c=c+1;
                temp = opposite_frac(lattice,i,j, lattice(i,j));
                s=s+temp;
                s1=s1+(temp*temp);
            end
        end
    end
    contact(t)=2*s/c;
    tem(t) = s1/c;
    susep(t) = (tem(t)-(contact(t)*contact(t)))/ toler;
    xdist = randperm(l_size);
    ydist= randperm(l_size);
    for i=1:l_size
        for j=1:l_size
            x = xdist(mod(i+j,l_size)+1);
            y = ydist(j);
            if ( visit(x,y) == 0 && lattice(x,y) ~= 0 && dummylattice(x,y)~=3)
                frac = opposite_frac(lattice,x,y, lattice(x,y));
                if (frac > toler)
                    if ( rand(1)< u_move )
                        [newx,newy] = moveto(lattice,dummylattice,x,y,lattice(x,y),toler);
                        
                        if (newx ~= 0)
                            visit(x,y) = 1;
                            visit(newx,newy) = 1;
                            tmp = lattice(x,y);
                            
                            lattice(x,y) = lattice(newx,newy);
                            lattice(newx,newy) = tmp;
                        end
                    end
                else
                    if ( rand(1)< h_move )
                        [newx,newy] = moveto(lattice,dummylattice,x,y,lattice(x,y),toler);
                        if (newx ~= 0)
                            visit(x,y) = 1;
                            visit(newx,newy) = 1;
                            tmp = lattice(x,y);
                            
                            lattice(x,y) = lattice(newx,newy);
                            lattice(newx,newy) = tmp;
                        end
                    end
                end
            end
        end
    end
    disp(lattice);
    visit = zeros(l_size);
end
end
function disp(lattice)
imagesc(lattice);
colormap([1 1 1; 1 0 0; 0 0 1]);
title('Segregation model with deactivated switching agents');
pause(0.015);
end
function flag = in(lattice, x, y)
flag = 0;
l_size = length(lattice);
if (x >= 1 && y >= 1 && x <= l_size && y <= l_size)
    flag = flag+1;
end
end
function flag = allowed(lattice, x1, y1,x0,y0)
flag = 0;
if (x1 ~=x0 || y1 ~=y0)
    if (lattice(x1, y1) == 0)
        flag = flag+1;
    end
end
end
function [agent1,frac] = n_frac(lattice, x, y)
neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];
frac = 0;
agent1= 0;
count = 0;
for k=1:8
    n_x = x + neigh(k, 1);
    n_y = y + neigh(k, 2);
    if (in(lattice, n_x, n_y))
        if (lattice(n_x,n_y) ~= 0)
            count = count+1;
            if (lattice(n_x,n_y) == 1)
                agent1 = agent1+ 1;
            end
        end
    end
end
if (agent1 > 0)
    frac = agent1/ count;
end
end
function fr = opposite_frac(lattice,x,y,type)
[c,fr] = n_frac(lattice, x, y);
if (type == 1)
    fr = 1 - fr;
end
end
function r = neighbourhood(lattice, x, y, o)
h= o*2;
l = o*2-1;
first = [];
last = [];
r = [];
x1 = x - o;
y1 = y - o;
x2 = x1 + 2*o;
y2 = y1 + 2*o;
for i=0:h
    x3 = x1+i;
    if (in(lattice,x3,y1) && allowed(lattice, x3, y1, x, y))
        first = [first ; [x3,y1]];
    end
    if (in(lattice,x3,y2) && allowed(lattice, x3, y2, x, y))
        last = [last ; [x3,y2]];
    end
end
for i=1:l
    y3 = y1+i;
    if (in(lattice,x1,y3) && allowed(lattice, x1, y3, x, y))
        r = [r ; [x1,y3]];
    end
    if (in(lattice,x2,y3) && allowed(lattice, x2, y3, x, y))
        r = [r ; [x2,y3]];
    end
end
r = [first ; r ; last];
end
function [nx,ny] = moveto(lattice,dummylattice, x, y, color, delta)
nx = 0;
ny = 0;
flag = 0;
o = 1;
l_size = length(lattice);
maxo= abs(max([(x-l_size),(l_size-x),(y-l_size),(l_size-y)]));
while (~flag)
    neigh = neighbourhood(lattice, x,y,o);
    l_size = size(neigh,1);
    dist = randperm(l_size);
    for k=1:l_size
        nx = neigh(dist(k), 1);
        ny = neigh(dist(k), 2);
        f = opposite_frac(lattice,nx,ny,color);
        if (delta > f)
            if(dummylattice(nx,ny)~=3)
                flag = 1;
                continue;
            end
        end
    end
    o = o + 1;
    if ( o > maxo )
        nx = 0;
        ny = 0;
        flag= 1;
        continue;
    end
end
end
