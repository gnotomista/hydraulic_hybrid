%%%%% Hydraulic Hybrid Simulation %%%%%

clc
clear all
close all

%---1) Definizione parametri del sistema
settings

%---2) Run simulazione sistema
global UH_C
UH_C=1; % 1 per il ciclo urbano, 0 per quello extraurbano
sim('Hydraulic_Hybrid_automatic')

%---3) Visualizzazione risultati simulazione
global vehicle_speed
global accum_press accum_vol serb_press serb_vol hyd_torque
global ICE_torque brake_torque gear
global fuel_consumption
diagrams_plotting