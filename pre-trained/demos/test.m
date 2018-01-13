x1 = [0;tpr_scg];
y1 = [1;prec_scg];
x2 = [0;tpr_prcut];
y2 = [1;prec_prcut];

figure()
p = plot(x1,y1,x2,y2);
p(1).LineWidth = 2;
p(2).LineWidth = 2;
legend('SCG', 'PRcut');