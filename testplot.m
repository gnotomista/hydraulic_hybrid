t=0:t_samp_d:length(speed_U)-1;

figure('Name','Speed cycle','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
%-------------------------------------------------------------------------%
hold on
plot(t,vehicle_speed.signals.values(:,1),'k','LineWidth',2)
plot(t,vehicle_speed.signals.values(:,2),'g','LineWidth',1.5)
plot(t,vehicle_speed.signals.values(:,3),'r','LineWidth',0.000001)
grid on
xlabel('t [s]')
ylabel('v [km/h]')