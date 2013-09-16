 function L=arena(p,n)

b=1;
while(b==1)

A=zeros(n);
coor=10*rand(n,3);
DIST_Mat=zeros(n);
for(i=1:length(coor))
    
    for(j=i+1:length(coor))
        
        DIST_Mat(i,j)=norm(coor(i,:)-coor(j,:))^-1;
        DIST_Mat(j,i)=norm(coor(i,:)-coor(j,:))^-1;
        
        %DIST_Mat
        
      % i
        
        
    end
end

for(i=1:length(coor))
    
    for(j=i+1:length(coor))
        
        if(DIST_Mat(i,j)<p)
            A(i,j)=1;
            A(j,i)=1;
        end
        
        
        
        
        
    end
end


        





    
   L= diag(sum(A))-A;
  % eig(L)
  if( length(find(eig(L)<0.00000001))==1)
      b=0;
  else
      b=1;
  end
  
end
    
end