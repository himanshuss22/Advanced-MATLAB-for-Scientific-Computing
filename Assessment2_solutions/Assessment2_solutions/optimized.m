% Script for solving linear advection equation
%% Setup problem
dlim = [0,1];
T = [0,1];
animate = false;

a = 1;
nx    = 1000;
nstep = ceil(nx*a);
dx = (dlim(2)-dlim(1))/(nx-1);
dt = (T(2)-T(1))/(nstep-1);

%% Define grid
x = linspace(dlim(1),dlim(2),nx)';

%% Define difference matrix
%give indices of diag and subdiag last index is first tow last column
rows = [1:nx,2:nx,1];
cols = [1:nx,1:nx-1,nx];
vals = (1/dx)*[ones(1,nx),-ones(1,nx)];
D1 = sparse(rows,cols,vals);

%% Time step
U = cos(2*pi*x);
for i = 1:nstep
    U = U - a*dt*D1*U;
    neg_ind = U < 0;
    
    if animate
        plot(x(neg_ind),U(neg_ind),'ro'); set(gca,'nextplot','add');
        plot(x(~neg_ind),U(~neg_ind),'ko'); set(gca,'nextplot','replacechildren'); drawnow;
    end
end