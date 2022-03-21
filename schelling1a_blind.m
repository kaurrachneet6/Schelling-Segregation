%Rachneet Kaur
%No switching agents and moves are blind
function [contact susep] = schelling1a_blind(lattice,dummylattice,toler,l_size)
figure
disp(lattice);
max = 500;              % no. of time steps
visit= zeros(l_size);
contact = zeros(max,1);
tem = zeros(max,1);
susep = zeros(max,1);
u_move = 0.2;            % probability of moving if unhappy
h_move = 1e-04;           % probability of moving if happy
for t=1:max
    s=0;
    s1=0;
    c=0;
    for i=1:l_size
        for j=1:l_size
            if (lattice(i,j)~=0)
                c=c+1;
                temp = opposite_frac(lattice,i,j,lattice(i,j));
                s=s+temp;
                s1=s1+(temp*temp);
            end
        end
    end
    contact(t)=2*s/c;
    tem(t) = 2*s1/c;
    susep(t) = (tem(t)-(contact(t)*contact(t)))/ toler;
    xdist = randperm(l_size);
    ydist= randperm(l_size);
    for i=1:l_size
        for j=1:l_size
            x = xdist(mod(i+j,l_size)+1);
            y = ydist(j);
            if ( visit(x,y) == 0 && lattice(x,y) ~= 0)
                fr = opposite_frac(lattice,x,y,lattice(x,y));
                if (fr > toler)
                    if ( rand(1)< u_move )
                        [newx,newy] = moveto(lattice);
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
                        [newx,newy] = moveto(lattice);
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
title('Segregation model with no switching agents');
pause(0.015);
end
function flag = in(lattice, x, y)
flag = 0;
l_size = length(lattice);
if (x >= 1 && y >= 1 && x <= l_size && y <= l_size)
    flag = flag+1;
end
end
function [agent1,frac] = n_frac(lattice, x, y)
n = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];
frac = 0;
agent1 = 0;
count = 0;
for k=1:8
    n_x = x + n(k, 1);
    n_y= y + n(k, 2);
    if (in(lattice, n_x, n_y))
        if (lattice(n_x,n_y) ~= 0)
            count = count+1;
            if (lattice(n_x,n_y) == 1)
                agent1 = agent1 + 1;
            end
        end
    end
end
if (agent1 > 0)
    frac = agent1 / count;
end
end
function fr = opposite_frac(lattice,x,y,color)
[c,fr] = n_frac(lattice, x, y);
if (color == 1)
    fr = 1 - fr;
end
end
function [nx,ny] = moveto(lattice)
ka=0;
l_size= length(lattice);
for i=1:l_size
    for j=1:l_size
        if(lattice(i,j)==0)
            ka=ka+1;
            vac(ka,1)=i;
            vac(ka,2)=j;
        end
    end
end
r=randi([1,ka]);
nx = 0;
ny = 0;
flag = 0;
while (~flag)
    nx=vac(r,1);
    ny=vac(r,2);
    flag = 1;
    continue;
end
end
