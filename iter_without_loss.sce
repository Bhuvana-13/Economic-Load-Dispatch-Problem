c = [500;400;200];
b = [5.3;5.5;5.8];
a = [0.004;0.006;0.009];
pmin= [200;150;100];
pmax= [450;350;225];
p_load = 975 ;
lambda = 2;
dP = 1;
p = zeros(3,1);
iter = 0;
TC = 0;
while abs(dP)>0.0001
      iter = iter +1;
      if iter > 1;
          lambda = lambda*(1+dP/2);
      end
    for i=1:3
      p(i)=(lambda-b(i))/(2*a(i));
      if p(i) < pmin(i)
          p(i) = pmin(i);
      end
      if p(i) > pmax(i)
          p(i) = pmax(i);
      end
    end
    dP = (p_load-sum(p))/p_load;
end
for i = 1:3
 TC=TC+(c(i)+b(i)*p(i)+a(i)*(p(i)^2));
end
 printf("no:of iterations : %d\n",iter);
 printf("lambda optimal is : %2f\n",lambda );
 printf("p1 optimal is : %2f     p2 optimal is : %2f      p3 optimal is : %2f\n",p(1),p(2),p(3) );
  printf("Total cost is : %2f\n", TC);
