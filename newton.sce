c = [500 ;400 ;200];
b = [5.3 ;5.5 ;5.8];
a = [0.004 ;0.006 ;0.009];
p_load = 975 ;
lambda = 2;
  p_initial = [300;250;150];
  p_sum = sum(p_initial(1) + p_initial(2) + p_initial(3));
  TC = 0;
  
  for i = 1:3
      L(i) = b(i) + 2*a(i)*p_initial(i);
  end
  
  dellambda = [L(1) - lambda; L(2) - lambda; L(3) - lambda; p_load - p_sum];
  G = 2*a;
  H = [G(1) 0 0 -1; 0 G(2) 0 -1; 0 0 G(3) -1; -1 -1 -1 0];
  M = inv(H);
  delp_power = -(M*dellambda);
  lambda_op = delp_power(4);
  
   for i = 1:3
      p_op(i) = p_initial(i) +  delp_power(i);
  end
  
  for i = 1:3
    TC=TC+(c(i)+b(i)*p_op(i)+a(i)*(p_op(i)^2));
  end
   printf("lambda optimal is : %2f\n",lambda_op );
    printf("p1 optimal is : %2f     p2 optimal is : %2f      p3 optimal is : %2f\n",p_op(1),p_op(2),p_op(3) );
    printf("Total cost is : %2f\n", TC);
