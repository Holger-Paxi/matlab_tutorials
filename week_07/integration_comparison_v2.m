close all; % close all current figure

% inputs
x_0 = 0;
x_n = 2;
even_num = 2;
n_vect = 2:even_num:20; % n can only be an even number
% function handle
func = @(x) exp(x);

% indices
ind_vect = 1:length(n_vect);

% store results
results = {};

% calculations
for ind = ind_vect

    trap = trapezoidal_n_divisions_function(...
        n_vect(ind), x_0, x_n, func ...
    );
    % trap.ind = ind;
    simp = simpson_n_divisions_function_v2( ...
        n_vect(ind), x_0, x_n, func ...
    );
    % simp.ind = ind;

    % merging/joining
    results{end+1} = innerjoin( ...
        trap, simp, ...
        "Keys", [...
            "n", "x_0", "x_n", "true_value"...
        ]...
    );

end

% merge results
results = vertcat(results{:});
% reordering columns
results = results(:, [...
    "n", "h_trap", "h_simp", "x_0", "x_n", ...
    "true_value", "inter_trap", "inter_simp", ...
    "rel_error_trap", "rel_error_simp" ...
]);

disp(results)

figure;
hold on
plot(results.n, results.inter_trap, 'r--o');
plot(results.n, results.inter_simp, 'g:s');
plot(results.n, results.true_value, 'b-');
legend("trapezoidal", "simpson", "true value");
title("numerical integration");
xlabel("number of divisions");
ylabel("results of integration");
grid on;
hold off

figure;
hold on
plot(results.n, results.inter_simp, 'g:s');
plot(results.n, results.true_value, 'b-');
legend("simpson", "true value");
title("numerical integration");
xlabel("number of divisions");
ylabel("results of integration");
grid on;
hold off

figure;
hold on
plot(results.n, results.rel_error_trap, 'r--o');
plot(results.n, results.rel_error_simp, 'g:s');
legend("trapezoidal error", "simpson error");
title("relative error of integration");
xlabel("number of divisions");
ylabel("relative error (%)");
grid on;
hold off