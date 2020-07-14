% Plot profiles
addpath(genpath('../../../fixPSlinestyle/'));
load pressure_displacement_profiles

fig=figure(); ax=axes();
set(fig,'paperpositionmode','auto');

% Plot initial condition
%[AX,H1,H2] = PLOTYY(...) returns the handles of the two axes created in
 %AX and the handles of the graphics objects from each plot in H1
 %and H2. AX(1) is the left axes and AX(2) is the right axes.
[axs,hi(1),hi(2)]=plotyy(initial.x,-initial.cp,initial.x,initial.disp);

% Don't delete lines already created
set(axs,'nextplot','add');

% Plot optimal solution
ho(1)=plot(axs(1),optimal.x,-optimal.cp);
ho(2)=plot(axs(2),optimal.x,optimal.disp);

% Set axes limits and ticks
% set(ax,'ytick',[]);
set(axs(1),'ylim',[-1.2,1.0],'ytick',-1.2:0.2:1.0,'box','off');
set(axs(2),'ylim',[-0.1,0.6],'ytick',-0.1:0.1:0.6,'box','off');

% Set plot colors
set(ho,'linewidth',2,'linestyle',':');
set(hi,'linewidth',2);

% Labels
xlabel(axs(1),'Distance along airfoil','interpreter','latex');
ylabel(axs(1),'$-C_p$','interpreter','latex');
ylabel(axs(2),'Distance transverse to airfoil','interpreter','latex');

% Legend
leg = legend([hi,ho],'Initial ($C_p$)','Initial (Shape)',...
                     'Optimal ($C_p$)','Optimal (Shape)');
set(leg,'interpreter','latex',...
    'Position',[0.1921875 0.36398431687128 0.3078125 0.263988095238095]);

% Save to eps and use fixPS
print(gcf,'-depsc2','Hwk1Prob3_weird');
fixPSlinestyle('Hwk1Prob3_weird.eps','Hwk1Prob3_better.eps');