% En MATLAB Online (Linux), usa barras diagonales '/' o fullfile
ruta = fullfile('datos');

% 1. Cargar datos experimentales (CSV delimitado por comas)
data = readtable(fullfile(ruta, 'datos_1N4007_experimental.csv'));

% 2. Cargar VD_simulacion.csv (delimitado por ';', primeras dos columnas)
opts_VD = detectImportOptions(fullfile(ruta, 'VD_simulacion.csv'), 'Delimiter', ';');
opts_VD.SelectedVariableNames = opts_VD.VariableNames(1:2);
V_D_sim = readtable(fullfile(ruta, 'VD_simulacion.csv'), opts_VD);

% 3. Cargar ID_simulacion.csv (delimitado por ';', segunda columna multiplicada por 1000)
opts_ID = detectImportOptions(fullfile(ruta, 'ID_simulacion.csv'), 'Delimiter', ';');
opts_ID.SelectedVariableNames = opts_ID.VariableNames(2);
I_D_sim = readtable(fullfile(ruta, 'ID_simulacion.csv'), opts_ID);
I_D_sim_mA = I_D_sim{:, 1} * 1000;

%% Gráfica 1: Vs vs VD
figure;
plot(data.Vs, data.Vd, 'LineWidth', 1.5, 'DisplayName', 'Datos Experimentales');
hold on;
plot(V_D_sim{:, 1}, V_D_sim{:, 2}, '--', 'LineWidth', 1.5, 'DisplayName', 'Datos Simulados');
hold off;

xlabel('V_S [V]');
ylabel('V_D [V]');
title("Comparación experimental y teórica V_D vs V_S", "Diodo 1N4007");
legend('Location', 'best');
grid on;

%% Gráfica 2: VD vs ID
figure;
plot(data.Vd, data.ID, 'LineWidth', 1.5, 'DisplayName', 'Datos Experimentales');
hold on;
plot(V_D_sim{:, 2}, I_D_sim_mA, '--', 'LineWidth', 1.5, 'DisplayName', 'Datos Simulados');
hold off;

xlabel('V_D [V]');
ylabel('I_D [mA]');
title("Comparación experimental y teórica I_D vs V_D", "Diodo 1N4007");
legend('Location', 'best');
grid on;