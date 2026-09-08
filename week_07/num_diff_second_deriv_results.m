% close all current open figures
close all

% inputs
x0 = 0.25;
h_vect = [0.25, 0.1, 0.01];
% h_vect = [0.01:0.01:0.1, 0.15:0.05:0.25];

% input function
syms x;
func = cos(pi.*x);

% store results
results = {};

% calculations
for h = h_vect

    tab = num_diff_second_deriv_function(...
        x0, h, func ...
    );

    % append tables
    results{end + 1} = tab;

end

% merge results
results = vertcat(results{:});
disp(results)

% save results to a file
save("results_var.mat", "results")
writetable(results, "results_table.csv")

% create and save figures
figure;
hold on;
plot(results.h, results.num_derv, 'c--o');
plot(results.h, results.true_value, 'g');
legend("2nd derivative", "true value")
title("2nd derivative vs steps")
xlabel("step h")
ylabel("numerical values")
grid on
hold off
% save figure
savefig(gcf, "figure_derivative.fig")
saveas(gcf, "figure_derivative.png")
saveas(gcf, "figure_derivative.pdf")

figure;
hold on
plot(results.h, results.err_derv, 'r:+')
legend("rel. error")
title("relative error vs steps")
xlabel("step h")
ylabel("error values (%)")
grid on;
hold off;
% save figure
savefig(gcf, "figure_error_derivative.fig")