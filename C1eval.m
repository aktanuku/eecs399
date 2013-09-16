
function C1=C1eval(v,network)
%condition C1.

% am i my own root?
a=(v.Root==v.Id);

% am i my own parent?
b=(v.Parent==v.Id);

% is the distance to root 0?
c=(v.Distance==0);

% is the root higher than my own id?
d= (v.Root>v.Id);

% is my parent in my edge list?
e=sum(find((v.Parent==v.Edge_list)));

% is my parent's root equal to my root?
f=(v.Root==network(v.Parent).Root);

% is my distance equal to my parent's distance plus 1? are both greater
% than 0?
g=(v.Distance==network(v.Parent).Distance+1)&&(v.Distance>0)&&((network(v.Parent).Distance+1)>0);

%Check if your root is higher than the highest root
mxrt=v.Root;
h=1;
u=v;
for(i=1:length(v.Edge_list))
    ind=v.Edge_list(i);
    if(network(ind).Root>=mxrt)
        mxrt=network(ind).Root;
       
    end
end

if(v.Root>=mxrt)
    h=1;
else
    h=0;
end
    

C1=((a&&b&&c)||(d&&e&&f&&g))&&h;

end






