function diagrams_plotting


global t_samp speed_U
global vehicle_speed
global accum_press accum_vol serb_press serb_vol p_ACC_MAX p_ACC_min p_SERB_MAX p_SERB_min hyd_torque
global ICE_torque brake_torque gear
global fuel_consumption

t=0:t_samp:length(speed_U);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Speed cycle','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
%-------------------------------------------------------------------------%
plot(t,vehicle_speed(:,2))
grid on
xlabel('t [s]')
ylabel('v [km/h]')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Hybrid components','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
%-------------------------------------------------------------------------%
H1=subplot(3,2,1);
hold on
plot(t,accum_press(:,4))
plot(t,p_ACC_MAX*ones(length(speed_U)+1,1),'-r','LineWidth',2)
plot(t,p_ACC_min*ones(length(speed_U)+1,1),'-b','LineWidth',2)
grid on
xlabel('t [s]')
ylabel('p_a_c_c [Pa]')
%-------------------------------------------------------------------------%
H2=subplot(3,2,3);
plot(t,accum_vol(:,2))
grid on
xlabel('t [s]')
ylabel('V_a_c_c [m^3]')
%-------------------------------------------------------------------------%
H3=subplot(3,2,2);
hold on
plot(t,serb_press(:,4))
plot(t,p_SERB_MAX*ones(length(speed_U)+1,1),'-m','LineWidth',2)
plot(t,p_SERB_min*ones(length(speed_U)+1,1),'-c','LineWidth',2)
grid on
xlabel('t [s]')
ylabel('p_s_e_r_b [Pa]')
%-------------------------------------------------------------------------%
H4=subplot(3,2,4);
plot(t,serb_vol(:,2))
grid on
xlabel('t [s]')
ylabel('V_s_e_r_b [m^3]')
%-------------------------------------------------------------------------%
H5=subplot(3,2,5:6);
plot(t,hyd_torque(:,2))
grid on
xlabel('t [s]')
ylabel('T_h_y_d [Nm]')
%-------------------------------------------------------------------------%
title(H1,'Accumulator pressure [Pa]')
title(H2,'Accumulator volume [m^3]')
title(H3,'Reservoir pressure [Pa]')
title(H4,'Reservoir volume [m^3]')
title(H5,'Pump/Motor torque [Nm]')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Traditional components','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
%-------------------------------------------------------------------------%
IB1=subplot(3,2,1);
plot(t,ICE_torque.signals(1,1).values)
grid on
xlabel('t [s]')
ylabel('T_I_C_E^H [Nm]')
%-------------------------------------------------------------------------%
IB2=subplot(3,2,3);
plot(t,ICE_torque.signals(1,2).values)
grid on
xlabel('t [s]')
ylabel('T_I_C_E^N^H [Nm]')
%-------------------------------------------------------------------------%
IB3=subplot(3,2,2);
plot(t,brake_torque.signals(1,1).values)
grid on
xlabel('t [s]')
ylabel('T_B_R_A_K_E^H [Nm]')
%-------------------------------------------------------------------------%
IB4=subplot(3,2,4);
plot(t,brake_torque.signals(1,2).values)
grid on
xlabel('t [s]')
ylabel('T_B_R_A_K_E^N^H [Nm]')
%-------------------------------------------------------------------------%
IB5=subplot(3,2,5:6);
plot(t,gear(:,2))
grid on
xlabel('t [s]')
ylabel('g')
%-------------------------------------------------------------------------%
title(IB1,'ICE torque in hybrid configuration [Nm]')
title(IB2,'ICE torque in traditional configuration [Nm]')
title(IB3,'Brake torque in hybrid configuration [Nm]')
title(IB4,'Brake torque in traditional configuration [Nm]')
title(IB5,'Gear')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Fuel consumption','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
%-------------------------------------------------------------------------%
FC1=subplot(2,1,1);
hold on
plot(t,fuel_consumption.signals(1,1).values)
plot(t,mean(fuel_consumption.signals(1,1).values)*ones(length(speed_U)+1,1),'-g','LineWidth',2)
grid on
xlabel('t [s]')
ylabel('Fuel consum.^H [l/100km]')
%-------------------------------------------------------------------------%
FC2=subplot(2,1,2);
hold on
plot(t,fuel_consumption.signals(1,2).values)
plot(t,mean(fuel_consumption.signals(1,2).values)*ones(length(speed_U)+1,1),'-g','LineWidth',2)
grid on
xlabel('t [s]')
ylabel('Fuel consum.^N^H [l/100km]')
%-------------------------------------------------------------------------%
title(FC1,'Fuel consumption in hybrid configuration [l/100km]')
title(FC2,'Fuel consumption in traditional configuration [l/100km]')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C_H=100/mean(fuel_consumption.signals(1,1).values);
C_NH=100/mean(fuel_consumption.signals(1,2).values);

R_H=['  consumo ibrido = ',num2str(C_H),' km/l'];
R_NH=['  consumo NON ibrido = ',num2str(C_NH),' km/l'];

disp('                                        ')
disp('----------------------------------------')
disp(R_H)
disp('                                        ')
disp(R_NH)
disp('----------------------------------------')
disp('                                        ')


end