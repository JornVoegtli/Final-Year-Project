clear all
% fileID = fopen('acc_200hz.txt'); %Most files should be in csv format if not, uncomment lines 2, 3 and 5.
% A = fscanf(fileID, '%d');
A = csvread('a_c_2.txt');
% A_reshaped = reshape(A, 3, [])';
A_reshaped = A(:, 1:6); %This removes the select columns from the text file. Some may have additional information on the front, be aware!
% A_reshaped(:, 1) = A_reshaped(:, 1) - mean(A_reshaped(:, 1)); %Uncomment if you want the mean removed.
% A_reshaped(:, 2) = A_reshaped(:, 2) - mean(A_reshaped(:, 2));
% A_reshaped(:, 3) = A_reshaped(:, 3) - mean(A_reshaped(:, 3));
% A_reshaped(:, 4) = A_reshaped(:, 4) - mean(A_reshaped(:, 4));
% A_reshaped(:, 5) = A_reshaped(:, 5) - mean(A_reshaped(:, 5));
% A_reshaped(:, 6) = A_reshaped(:, 6) - mean(A_reshaped(:, 6));
 A_reshaped_a = A_reshaped(:, 1:3)./16.384; %Uncomment if accelerometer
 A_reshaped_g = A_reshaped(:, 4:6)./131; %Uncomment if gyroscope
% A_reshaped_m = A_reshaped./256; %Uncomment if magnetometer
%suffix determines magnetometer, accelerometer, gyro, different ones for easier printing
[t_g, sig_g] = allan(A_reshaped_g, 4, 10000); %(data, f, numofsamples)
[Pxx_g, f_g] = computePowerSpectralDensities(A_reshaped_g, 4); %(data, f)
[t_a, sig_a] = allan(A_reshaped_a, 4, 10000);
[Pxx_a, f_a] = computePowerSpectralDensities(A_reshaped_a, 4);
% [t_m, sig_m] = allan(A_reshaped, 50, 10000);
% [Pxx_m, f_m] = computePowerSpectralDensities(A_reshaped, 50);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Printing functions       %
% Uncomment as you please  %
% to get desired graphs.   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
loglog(f_g, Pxx_g(:, 1:3));
xlabel('Frequency (Hz)')
ylabel('Power')
title('PSD Plot - Gyro @4Hz')
legend('x axis', 'y axis', 'z axis');
grid on;

figure
loglog(f_a, Pxx_a(:, 1:3));
xlabel('Frequency (Hz)')
ylabel('Power')
title('PSD Plot - Accelerometer @4Hz')
legend('x axis', 'y axis', 'z axis');
grid on;

figure
loglog(t_a, sig_a(:,1:3).^2);
xlabel('Time Window, \tau (sec)')
ylabel('Allan Variance, m/s/h')
title('Allan Variance Plot - Accelerometer @4Hz');
legend('x axis', 'y axis', 'z axis');
grid on;

figure
loglog(t_g, sig_g(:,1:3).^2);
xlabel('Time Window, \tau (sec)')
ylabel('Allan Variance, deg/h')
title('Allan Variance Plot - Gyro @4Hz');
legend('x axis', 'y axis', 'z axis');
grid on;
%

% figure
% loglog(f_m, Pxx_m(:, 1:3));
% xlabel('Frequency (Hz)')
% ylabel('Power')
% title('PSD Plot - Magnetometer @20Hz')
% legend('x axis', 'y axis', 'z axis');
% grid on;
% 
% figure
% loglog(f_m, Pxx_m(:, 1:3));
% xlabel('Frequency (Hz)')
% ylabel('Power')
% title('PSD Plot - Magnetometer @20Hz')
% legend('x axis', 'y axis', 'z axis');
% grid on;
% 

% figure
% loglog(f_m, Pxx_m(:, 1:3));
% xlabel('Frequency (Hz)')
% ylabel('Power')
% title('PSD Plot - Kalman @20Hz');
% % legend('yaw-k', 'yaw', 'pitch', 'roll');
% grid on;
% 
% figure
% loglog(t_m, sig_m(:,1:3));
% xlabel('Time Window, \tau (sec)')
% ylabel('Allan Variance, deg/?Hz')
% title('Allan Variance Plot - Kalman @20Hz');
% % legend('yaw-kalman', 'yaw');%', 'pitch', 'roll');
% grid on;