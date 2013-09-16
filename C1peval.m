function C1p=C1peval(v,network)

%% condition C1p.

% am i my own root?
a=(v.Root==v.Id);

% am i my own parent?
b=(v.Parent==v.Id);

% is the distance to root 0?
c=(v.Distance==0);

% is the root higher than my own id?
d= (v.Root>v.Id);

% is my parent in my edge list?
e=sum((v.Parent==v.Edge_list));

% is my parent's root equal to my root?
f=(v.Root==network(v.Parent).Root);

% is my distance equal to my parent's distance plus 1? are both greater
% than 0?
g=(v.Distance==network(v.Parent).Distance+1)&&(v.Distance>0)&&((network(v.Parent).Distance+1)>0);


%this is kinda wierd, reference paper for explination.
if(~isempty(v.Edge_list))
h=(v.Root)>=network(max(v.Edge_list)).Root;
else
h=(v.Root)>=0;
end

C1p=(a&&b&&c)||(d&&e&&f&&g);
end