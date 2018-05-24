clc
clear all
close all

global fuel_consumption

global UH_C
UH_C=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametrizzazione del veicolo e dei componenti termici
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Cd Af m h_aero h l_f l_r f r_ROT eps_p gear_ratios
global n_ICE_min n_ICE_MAX n_TM_min n_TM_MAX T_MAX T_n_min T_n_MAX torque_curve n_ICE_etamax V_ICE eta_mech

param_Cd=[0.27;0.3;0.39];
param_Af=[1.8;2;2.5];
param_m=[1600;1200;2000];
param_h_aero=[0.6;0.9;1.2];
param_h=[0.5;0.8;1.1];
param_l_f=[1.1;1;1.3];
param_l_r=[1.3;1;1.5];
param_f=[0.016;0.015;0.015];
param_r_ROT=[0.4;0.26;0.3];
param_eps_p=[3.2;3;3];
param_gear_ratios=[3.2 2 1.2 0.9 0.7;
    3.6 2.1 1.4 1 0.8;
    3.9 2.5 1.6 1.1 0.9];
param_n_ICE_min=[900;900;900];
param_n_ICE_MAX=[7500;5500;5500];
param_n_TM_min=[2000;2500;2000];
param_n_TM_MAX=[5000;3500;4000];
param_T_MAX=[350;150;200];
param_T_n_min=[100;40;40];
param_T_n_MAX=[100;60;60];
param_torque_curve=[param_n_ICE_min(1),(param_T_MAX(1)-param_T_n_min(1))/(param_n_TM_min(1)-param_n_ICE_min(1)),param_n_TM_min(1),param_T_MAX(1),param_n_TM_MAX(1),(param_T_n_MAX(1)-param_T_MAX(1))/(param_n_ICE_MAX(1)-param_n_TM_MAX(1)),param_n_ICE_MAX(1);
    param_n_ICE_min(2),(param_T_MAX(2)-param_T_n_min(2))/(param_n_TM_min(2)-param_n_ICE_min(2)),param_n_TM_min(2),param_T_MAX(2),param_n_TM_MAX(2),(param_T_n_MAX(2)-param_T_MAX(2))/(param_n_ICE_MAX(2)-param_n_TM_MAX(2)),param_n_ICE_MAX(2);
    param_n_ICE_min(3),(param_T_MAX(3)-param_T_n_min(3))/(param_n_TM_min(3)-param_n_ICE_min(3)),param_n_TM_min(3),param_T_MAX(3),param_n_TM_MAX(3),(param_T_n_MAX(3)-param_T_MAX(3))/(param_n_ICE_MAX(3)-param_n_TM_MAX(3)),param_n_ICE_MAX(3)];
param_n_ICE_etamax=[3500;2500;2500];
param_V_ICE=[2000;1400;1600]*10^(-6);
param_eta_mech=[0.9;0.8;0.8];

C_H_param_vehicle=zeros(length(param_Cd),1);
C_NH_param_vehicle=zeros(length(param_Cd),1);

for i=1:length(param_Cd)
    
    settings
    
    Cd=param_Cd(i);
    Af=param_Af(i);
    m=param_m(i);
    h_aero=param_h_aero(i);
    h=param_h(i);
    l_f=param_l_f(i);
    l_r=param_l_r(i);
    f=param_f(i);
    r_ROT=param_r_ROT(i);
    eps_p=param_eps_p(i);
    gear_ratios=param_gear_ratios(i,:);
    n_ICE_min=param_n_ICE_min(i);
    n_ICE_MAX=param_n_ICE_MAX(i);
    n_TM_min=param_n_TM_min(i);
    n_TM_MAX=param_n_TM_MAX(i);
    T_MAX=param_T_MAX(i);
    T_n_min=param_T_n_min(i);
    T_n_MAX=param_T_n_MAX(i);
    torque_curve=param_torque_curve(i,:);
    n_ICE_etamax=param_n_ICE_etamax(i);
    V_ICE=param_V_ICE(i);
    eta_mech=param_eta_mech(i);
    
    sim('Hydraulic_Hybrid_automatic')
    
    C_H_param_vehicle(i)=100/mean(fuel_consumption.signals(1,1).values);
    C_NH_param_vehicle(i)=100/mean(fuel_consumption.signals(1,2).values);
    
end

figure('Name','Vehicle parametrization','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
plot([1;2;3],C_H_param_vehicle,'c',[1;2;3],C_NH_param_vehicle,'m')
set(gca,'XTick',[1 2 3]);
grid on
xlabel('Vehicle type {1: green, 2: yellow, 3: red}')
ylabel('Fuel economy [km/l]')
legend('Hybrid config.','Traditional config.')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametrizzazione dei componenti idraulici
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global p_ACC_0 p_SERB_0 V_ACC_0 V_SERB_0 p_ACC_MAX p_ACC_min p_SERB_MAX p_SERB_min

param_p_ACC_MAX=[300;350;400]*10^5;
param_p_ACC_min=[100;130;160]*10^5;
param_p_ACC_0=[200;240;280]*10^5;
param_V_ACC_0=[0.0305;0.0323;0.0388];
param_p_SERB_MAX=[15;18;21]*10^5;
param_p_SERB_min=[3;6;9]*10^5;
param_p_SERB_0=[3.8;7.6;11.3]*10^5;
param_V_SERB_0=[0.0423;0.0423;0.0425];

C_H_param_hydr=zeros(length(param_p_ACC_MAX),1);
C_NH_param_hydr=zeros(length(param_p_ACC_MAX),1);

for i=1:length(param_p_ACC_MAX)
    
    settings
    
    p_ACC_MAX=param_p_ACC_MAX(i);
    p_ACC_min=param_p_ACC_min(i);
    p_ACC_0=param_p_ACC_0(i);
    V_ACC_0=param_V_ACC_0(i);
    p_SERB_MAX=param_p_SERB_MAX(i);
    p_SERB_min=param_p_SERB_min(i);    
    p_SERB_0=param_p_SERB_0(i);    
    V_SERB_0=param_V_SERB_0(i);
        
    sim('Hydraulic_Hybrid_automatic')
    
    C_H_param_hydr(i)=100/mean(fuel_consumption.signals(1,1).values);
    C_NH_param_hydr(i)=100/mean(fuel_consumption.signals(1,2).values);
    
end

figure('Name','Hydraulic parametrization','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
plot([1;2;3],C_H_param_hydr,'c',[1;2;3],C_NH_param_hydr,'m')
set(gca,'XTick',[1 2 3]);
grid on
xlabel('Hydraulic components size {1: S, 2: M, 3: L}')
ylabel('Fuel economy [km/l]')
legend('Hybrid config.','Traditional config.')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametrizzazione del guidatore
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Kd tau t_react

param_Kd=[0.2;0.1;0.05];
param_tau=[0.1;0.1;0.1];
param_t_react=[0.05;0.1;0.2];

C_H_param_driver=zeros(length(param_Kd),1);
C_NH_param_driver=zeros(length(param_Kd),1);

for i=1:length(param_Kd)
    
    settings
    
    Kd=param_Kd(i);
    tau=param_tau(i);
    t_react=param_t_react(i);
            
    sim('Hydraulic_Hybrid_direct')
    
    C_H_param_driver(i)=100/mean(fuel_consumption.signals(1,1).values);
    C_NH_param_driver(i)=100/mean(fuel_consumption.signals(1,2).values);
    
end

figure('Name','Driver parametrization','NumberTitle','off','units','normalized','outerposition',[0 0 1 1])
plot([1;2;3],C_H_param_driver,'c',[1;2;3],C_NH_param_driver,'m')
set(gca,'XTick',[1 2 3]);
grid on
xlabel('Driver type {1: agitated, 2: normal, 3: relaxed}')
ylabel('Fuel economy [km/l]')
legend('Hybrid config.','Traditional config.')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%