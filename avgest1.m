function [newnet]= avgest1(v,network,ind)


children=0;
childvector=[];
numrep=0;

newnet=network;
for(i=1:length(v.Edge_list))
        idx=v.Edge_list(i);
        w=network(idx);
        
        if(w.Parent==v.Id)%is this node my child?
            children=children+1;
            
            if(w.reported==1)%does my child have all the data from it's children?
            numrep=numrep+1; 
            end
            
        end
end


if((numrep==children)||(children==0))% if i have all the information from my children I can report my cumlative average otherwise i cant  
    v.reported=1;
else
    v.reported=0;
end

if(v.reported==1)

v.cumtot=sum(v.tots)+v.input;

v.Nchild=0;


for(i=1:length(v.Edge_list))
    id=v.Edge_list(i);
    u=network(id);
    
    if(u.Parent==v.Id)
    v.Nchild=u.Nchild+v.Nchild;
    end
    
end

v.Nchild=v.Nchild+length(v.tots);



if(v.Id==v.Root)
   [ v.Nchild+1 (v.cumtot+v.input)];
    
  v.global_avg=(v.cumtot)/(v.Nchild+1);
    v.tots=[];
    v.cumtot=0;
else
    
wid=v.Parent;

w=network(wid);
v.global_avg=w.global_avg;
w.tots=[w.tots v.cumtot];
v.cumtot=0;
v.tots=[];

end








newnet(ind)=v;

if(v.Id~=v.Root)
newnet(w.Id)=w;
end


end
end
