lambda = 0;
no_units=6;
Pd=1450;
a=[0.0070 0.0095 0.0090 0.0090 0.0080 0.0075];
b=[7 10 8.5 11 10.5 12];
c=[240 200 300 150 200 120];
Pmax=[500 200 300 150 200 120];
Pmin=[100 50 80 50 50 50];
B=[ 0.000017 0.000012 0.000007 -0.000001 -0.000005 -0.000002
 0.000012 0.000014 0.000009 0.000001 -0.000006 -0.000001
 0.000007 0.000009 0.000031 0.000000 -0.000010 -0.000006
 -0.000001 0.000001 0.000000 0.000024 -0.000006 -0.000008
 -0.000005 -0.000006 -0.000010 -0.000006 0.000129 -0.000002
 -0.000002 -0.000001 -0.000006 -0.000008 -0.000002 0.000150 ];
itermax=1000;
epsilon=0.1;
alpha=2*a;
clc
Pg=zeros(no_units,1);
del_lambda=0.010;
tic;deltaP=10;iter=0;
EPd=Pd/no_units;
while abs(deltaP)>epsilon && iter< itermax
 iter=iter+1;
 for i=1:no_units
 sigma=B(i,:)*Pg-B(i,i)*Pg(i);
 Pg(i)=(1-(b(i)/lambda)-(2*sigma))/(alpha(i)/lambda+2*B(i,i));
 if Pg(i)<Pmin(i)
 Pg(i)=Pmin(i);
 end
 if Pg(i)>Pmax(i)
 Pg(i)=Pmax(i);
 end
 end
 P_loss=Pg'*B*Pg;
 Pt=sum(Pg);
 deltaP=Pt-Pd-P_loss;
 error(iter)=deltaP;
 if deltaP>0
 lambda=lambda-del_lambda; 
 end
 if deltaP<0
 lambda=lambda+del_lambda; 
 end
end
fprintf('\n ECONOMIC DISPATCH USING LAMBDA ITERATION METHOD\n');
if iter<itermax
 fprintf('\n Problem converged in %d iterations\n',iter);
else
 fprintf('\n Problem diverged in %d iterations\n',iter);
end
fprintf('\n Optimal Lambda = %g\n',lambda);
for i=1:no_units
 fprintf('\n Pgen(%d)=%g MW',i,Pg(i));
end
fprintf('\n Total Power Generation, P_total = %g MW\n',Pt);
fprintf('\n Total Power Demand = %g MW',Pd);
fprintf('\n Total Power Loss = %g MW',P_loss);
fprintf('\n\n Error= %g\n',deltaP);
Ft=0.0;
for i=1:no_units
 F(i)=c(i)+b(i)*Pg(i)+a(i)*Pg(i)*Pg(i);
 fprintf('\n Fuel cost of Gen.(%d)= %g Rs/Hr',i,F(i));
Ft=Ft+F(i);
end
fprintf('\n Total fuel cost= %g Rs/Hr\n',Ft);
runtime=toc;
fprintf('\n CPU time = %g sec.\n\n',runtime);

