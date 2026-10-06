% Ruta de la carpeta de datos
ruta = fullfile('datos');

% 1. Cargar datos experimentales (delimitador estándar por comas)
data_exp = readtable(fullfile(ruta, 'datos_1N4733A_experimental.csv'));

% 2. Cargar datos simulados (delimitador punto y coma ';')
opts_sim = detectImportOptions(fullfile(ruta, '1n4733a_simulacion.csv'), 'Delimiter', ';');
data_sim = readtable(fullfile(ruta, '1n4733a_simulacion.csv'), opts_sim);

%% Gráfica: Vs vs Vout con línea de referencia Vz
figure;
plot(data_exp.Vs, data_exp.Vout, 'LineWidth', 1.5, 'DisplayName', 'Datos Experimentales');
hold on;
plot(data_sim.Vs, data_sim.Vout, '--', 'LineWidth', 1.5, 'DisplayName', 'Datos simulados');

% yline equivale a plt.axhline en matplotlib
yline(5.1, ':', 'Color', '#00A708', 'LineWidth', 1.5, 'DisplayName', 'V_z = 5.1 V');
hold off;

xlabel('V_s [V]');
ylabel('V_{out} [V]');
title('Curva de Regulación Zener (1N4733A)');
legend('Location', 'best');
grid on;

%% Filtrado por valores específicos y creación de la tabla
Vs2loc = [3.0, 5.0, 5.5, 6.5, 8.0];

% Filtramos las filas donde Vs coincide con los valores del vector
% (usando ismembertol para evitar pequeñas discrepancias de punto flotante)
filtro = ismembertol(data_sim.Vs, Vs2loc, 1e-5);
Vout_sim_table = data_sim(filtro, {'Vs', 'Vout'});

% Mostrar la tabla resultante en el Command Window
disp(Vout_sim_table);