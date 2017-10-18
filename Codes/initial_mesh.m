%Rachneet Kaur
%IIT Delhi
function [grid dummygrid] = initial_mesh(f,N)
vacancies = 0.15;
agent1=0.5;
    indexes = randperm(N);
    for i=1:N
        x = indexes(i);
        for j=1:N
            y = indexes(j);
            if (rand(1) > vacancies)
                if (rand(1)>f)
                if (rand(1) > agent1)
                    grid(x,y) = 2;
                    dummygrid(x,y)=2;
                else
                    grid(x,y) = 1;
                    dummygrid(x,y)=1;
                end
                else 
                     dummygrid(x,y)=3;
                if (rand(1) > agent1) 
                    grid(x,y) = 2;
                else
                    grid(x,y) = 1;
                end
                end
            else
                grid(x,y)=0;
                dummygrid(x,y)=0;
        end
        end
    end
end
