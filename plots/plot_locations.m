load('results_20-Nov-2022_20-37-56.mat');
set_default_plot;
sample = 3;
s = results{sample};
plot(s.AP(:,1), s.AP(:,2), 'bs', DisplayName='AP'); 
hold on
plot(s.UE(:,1), s.UE(:,2), 'rx', DisplayName='UE'); 
plot(s.Target(:,1), s.Target(:,2), 'ko', DisplayName='Target'); 
grid on
xlim([-10, 110])
ylim([-10, 60])
legend