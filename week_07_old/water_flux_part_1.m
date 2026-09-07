% clear, clc, close all

% conditions
% J_w = A_w*(pi_D*exp(-J_w/k) - pi_F*exp(J_w*K))
% f(J_w, pi_D, pi_F) = J_w - A_w*(pi_D*exp(-J_w/k) - pi_F*exp(J_w*K))
% f = @(J_w, pi_D, pi_F) J_w - A_w*(pi_D*exp(-J_w/k) - pi_F*exp(J_w*K));
% f = @(J_w) J_w - A_w*(pi_D*exp(-J_w/k) - pi_F*exp(J_w*K));

% inputs
k = 0.31;
K = 21;
A_w = 0.002;

pi_D = 25:5:50;
pi_F = 5;

% definition of results
J_w = zeros(size(pi_D));

% calculations
for iter = 1:length(pi_D)

    f = @(J_w) J_w - A_w* ...
        (pi_D(iter)*exp(-J_w/k) - pi_F*exp(J_w*K));
    J_w(iter) = fzero(f, 0.001);

end

% results:
% table & plot
% pi_D vs J_w

tab = table( ...
    pi_D', J_w', ...
    'VariableNames', ...
    ["pi_D (bar)" "J_w (m/h)"] ...
);

% plot(...
%     pi_D, J_w, ...
%     'Color', "r", ...
%     'LineStyle', "--", ...
%     'Marker', "o" ...
% )

plot(pi_D, J_w, "g--o");
title("Water Flux vs DSO Pressure");
xlabel("DSO Pressure (bar)");
ylabel("Water Flux (m/h)");
grid on;

disp(tab)