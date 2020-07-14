% compress image with svd

% Filename
% fname = 'mandrill.jpeg';
fname = 'palm.png';

% SVD parameters
svd_options.type  = 'probabilistic';
svd_options.type  = 'classic';
svd_options.rank  = 50;
svd_options.power = 1;

% Decompose image via SVD
[U,s,V] = decompose_image_svd(fname,svd_options);
n = length(s);

% All ranks to consider
if strcmpi(svd_options.type,'classic')
    r = [5,10,15,20,25,50,100,200,min(size(U))];
elseif strcmpi(svd_options.type,'probabilistic')
    r = round(linspace(5,n,9))
end

% Singular value decay
sing_val_decay = 1-cumsum(s.^2)/sum(s.^2);
size(s)
% Compute low-rank approximations
fig=figure; 
set(fig,'position',[166,79,1038,703],...
    'paperpositionmode','auto');
for i = 1:length(r)
    if r(i) > n, continue, end;
    
    ax(i) = subplot(3,3,i);
    RGBr = reconstruct_trunc_svd(U,s,V,r(i));
        
    plot_image_rgb(RGBr,ax(i));
    title(['Compressed Image (r = ',num2str(r(i)),')']);
    set(ax(i),'xtick',[],'ytick',[]);
end
print(gcf,'-depsc2',['compress_palm_svd_',svd_options.type,...
                     '_rank',num2str(svd_options.rank),...
                     '_power',num2str(svd_options.power)]);

% Plot singular value decay
figure;
plot(sing_val_decay,'k-','linewidth',2);
set(gca,'yscale','log','ygrid','on','xgrid','on');
xlabel('Rank of Approximation');
ylabel('Singular Value Decay of RGB');
print(gcf,'-depsc2',['compress_palm_decay_',svd_options.type,...
                     '_rank',num2str(svd_options.rank),...
                     '_power',num2str(svd_options.power)]);