A=[1 1 1 1;7 6 5 4;42 30 20 12;210 120 60 24];

num = 1:4;
d = zeros(4);
for i=1:4
    for j=1:4
        Atemp = A;
        Atemp(i,:)=[];
        Atemp(:,j)=[];
        d(i,j) = det(Atemp);
    end
end