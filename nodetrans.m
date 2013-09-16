function [network0 changed]=nodetrans(v,network,ind)
vprev=v;
changed=0;
p=.8;
% in this code we carry out steps 1-8 of the algorithm: see paper for
% explination of each step
%% evaluate predicates
C1=C1eval(v,network);
C1p=C1peval(v,network);
C2p=C2peval(v,network);
C2=C2eval(v,C2p);
v.T=v.T+1;
changed=[0;0];
%% step 1

step1 = ~C1 && ~C1p;

if(step1)
    
    v.Root=v.Id;
    v.Parent= v.Id;
    v.Distance=0;
 changed(2)=1;
end


%% step 2
mxrt=v.Root;
k=0;
for(i=1:length(v.Edge_list))% find the maximum ID node in edge set
    if(network(v.Edge_list(i)).Root>mxrt)
        k=1;
        u=network(v.Edge_list(i));
       mxrt=u.Root;
    end
end  
step2 = C1p && k;

if(step2)
 v.Root=v.Id;
 v.Parent=v.Id;
 v.Distance=0;
v.Request=v.Id;
v.From=v.Id;
v.To=u.Id;
v.Direction='A';
changed(2)=2;

end

%% step 3
if(C1&&~C2)
    v.Request=[];
    v.From=[];
    v.To=[];%reset communication variables
    v.Direction=[];
    
   
changed(2)=3;
end


%% step 4
%if(rand()>p)packet failute probability
for(i=1:length(v.Edge_list))
    idx=v.Edge_list(i);
    w=network(idx);
   if(~isempty( (w.Direction)))% if w.direction is empty we cant procede with this step

    if(C1&&C2&&~C2p&&(w.To==v.Id)&&(w.Direction=='A')&&(w.Request==w.Id)&&(w.Id==w.Root)&&(w.Root==w.From))
      
        v.Request=w.Id;
        v.From=w.Id;
        v.To=v.Parent;
        v.Direction='A';
     changed(2)=4;
        break;
    end
   end
end

%% step 5

for(i=1:length(v.Edge_list))
   w= network(v.Edge_list(i));
   if(~isempty(w.Direction))
    if(C1&&C2&&~C2p&&(w.Parent == v.Id)&& (w.To == v.Id)&&(w.Direction == 'A'))
        v.Request=w.Request; 
        v.From=w.Id;
        v.To=v.Parent;
        v.Direction='A';
 changed(2)=5;
    end
   end
end


%% step 6


if(C1&&C2p&&(v.Root==v.Id)&&(v.Direction=='A'))
    
changed(2)=6;
    v.Direction='G';

end

%% step 7

u=network(v.Parent);
if(~isempty(u.Direction)&&(~isempty(v.Direction)))
if(C1&&C2p&&(v.To==v.Parent)&&(u.Direction=='G')&&(v.Direction=='A')&&(u.Request==v.Request)&&(u.From==v.Id))
    v.Direction='G';
changed(2)=7;
end
end


%% step 8

a=(v.Root==v.Id);
b=(v.From==v.Root);
if(v.Direction=='A')
    for(i=1:length(v.Edge_list))
        u=network(v.Edge_list(i));
        if(~isempty(u.Direction))
        if(~isempty(v.Request)&&~isempty(v.To)&&~isempty(v.From)&&~isempty(v.Direction)&&~isempty(u.Request)&&~isempty(u.To)&&~isempty(u.From)&&~isempty(u.Direction))
        if((u.Request==v.Request)&&(v.Root==v.Id)&&(u.Request==v.From)&&(v.From==v.Request)&&(u.From==v.Id)&&(u.Direction=='G')&&(v.To==u.Id))
       
            v.Parent=u.Id;
            v.Distance=u.Distance+1;
            v.Root=u.Root;
            v.To=[];
            v.From=[];
            v.Request=[];
            v.Direction=[];
            changed(2)=8;
        end
        end
        end
    end
end
%end


% this section is meant to check what steps were executed after running
% this algorithm not necessary for execution however
if((v.Parent==vprev.Parent)&&(v.Distance==vprev.Distance)&&(v.Root==vprev.Root))
    if(~isempty(v.Direction)&&~isempty(vprev.Direction))
        
        changed(1)=1;
        
    elseif(isempty(v.Direction)&&isempty(vprev.Direction))
        changed(1)=0;
    else
        changed(1)=1;
    end
        
 
else
    changed(1)=1;
end
    network0=network;
    network0(ind)=v;
    

        







