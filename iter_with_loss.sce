a = [500;400;200];
b = [5.3;5.5;5.8];
c = [0.004;0.006;0.009];
pmin = [200;150;100];
pmax = [450;350;225];
ploss = [0.00003;0.00009;0.00012]
p_load = 975 ;
lambda = 2;
dP = 1;
p = zeros(3,1);
iter = 0;
loss = 0;


while abs(dP)>.0001
    iter=iter+1;
    for i=1:3
      p(i)=(lambda-b(i))/(2*c(i));
    end
    dP=p_load-sum(p);
  if abs(dP)>0
    k=0;
    for i=1:3
      k=k+(1/(2*c(i)));
    end
  end
  dl=dP/k;
  lambda=lambda+dl;
end
 printf("no:of iterations : %d\n",iter);
 printf("lambda optimal is : %2f\n",lambda );
 printf("p1 optimal is : %2f     p2 optimal is : %2f      p3 optimal is : %2f\n",p(1),p(2),p(3) );
 printf("loss is : %2f\n",loss);
