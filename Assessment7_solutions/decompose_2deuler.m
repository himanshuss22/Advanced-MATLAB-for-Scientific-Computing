syms rho u v p e gamma c

% Define quantities
U = [rho;rho*u;rho*v;e];
V = [rho;u;v;p];
Fx = [rho*u; rho*u^2+p; rho*u*v; (e+p)*u];
Fy = [rho*v; rho*u*v; rho*v^2+p; (e+p)*v];

% Substitute expression for energy
U =subs(U ,e,p/(gamma-1)+rho*(u^2+v^2)/2);
Fx=subs(Fx,e,p/(gamma-1)+rho*(u^2+v^2)/2);
Fy=subs(Fy,e,p/(gamma-1)+rho*(u^2+v^2)/2);

% Compute jacobians
dUdV  = jacobian(U,V);
dFxdV = jacobian(Fx,V);
dFydV = jacobian(Fy,V);

% Find wave speed matrices
A = dUdV\dFxdV;
B = dUdV\dFydV;

% Before plugging into EVD, use expression for speed of sound
% Future simplification.
A = subs(A,gamma*p,rho*c^2)
B = subs(B,gamma*p,rho*c^2)

% Eigenvalue decomposition
[VA,DA] = eig(A)
[VB,DB] = eig(B)