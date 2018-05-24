load('cycles')


% Parametri di simulazione %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global t_samp t_samp_d
t_samp=1; %[s]
t_samp_d=1/5; %[s]


% Parametri del guidatore %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global Kd tau t_react
Kd=0.1;
tau=0.1;
t_react=0.1;


% Parametri generali %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global rho_air rho_fuel
rho_air=1.2; %[kg/m^3]
rho_fuel=720; %[kg/m^3]


% Parametri veicolo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global Cd Af m h_aero h l_f l_r f r_ROT eps_p gear_ratios
Cd=0.3; %[]
Af=2; %[m^2]
m=1200; %[kg]
h_aero=0.9; %[m]
h=0.8; %[m]
l_f=1; %[m]
l_r=1; %[m]
f=0.015; %[]
r_ROT=0.26; %[m]
eps_p=3; %[]
gear_ratios=[3.6 2.1 1.4 1 0.8]; %[,,,,]


% Parametri componenti idraulci %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global k p_ACC_0 p_SERB_0 V_ACC_0 V_SERB_0 p_ACC_MAX p_ACC_min p_SERB_MAX p_SERB_min CHARGE_p V_PM
k=1.4; %[]
p_ACC_MAX=350*10^5; %[Pa]
p_ACC_min=130*10^5; %[Pa]
p_ACC_0=240*10^5; %[Pa]
V_ACC_0=0.0323; %[m^3]
p_SERB_MAX=18*10^5; %[Pa]
p_SERB_min=6*10^5; %[Pa]
p_SERB_0=7.6*10^5; %[Pa]
V_SERB_0=0.0423; %[m^3]
CHARGE_p=0.7; %[Pa]
V_PM=45*10^(-6); %[m^3]


% Parametri componenti termici %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global n_ICE_min n_ICE_MAX n_TM_min n_TM_MAX T_MAX T_n_min T_n_MAX torque_curve n_ICE_etamax V_ICE alpha T_brake_MAX eps eta_mech
n_ICE_min=900; %[giri/min]
n_ICE_MAX=5500; %[giri/min]
n_TM_min=2500; %[giri/min]
n_TM_MAX=3500; %[giri/min]
T_MAX=150; %[Nm]
T_n_min=40; %[Nm]
T_n_MAX=60; %[Nm]
torque_curve=[n_ICE_min;(T_MAX-T_n_min)/(n_TM_min-n_ICE_min);n_TM_min;T_MAX;n_TM_MAX;(T_n_MAX-T_MAX)/(n_ICE_MAX-n_TM_MAX);n_ICE_MAX];
%[giri/min; Nm/(giri/min); giri/min; Nm; giri/min; Nm/(giri/min); giri/min]
n_ICE_etamax=2500; %[giri/min]
V_ICE=1400*10^(-6); %[m^3]
alpha=14.7; %[]
T_brake_MAX=200; %[Nm]
eps=2; %[]
eta_mech=0.8; %[]