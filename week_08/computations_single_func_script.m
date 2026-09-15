%% 
% inputs

n = 2;
x_0 = 1;
x_n = 3;

func = @(x) x./(x.^2 + 4);
%% 
% calculations

trap = trapezoidal_rule_function(n, x_0, x_n, func);
simp = simpson_rule_function(n, x_0, x_n, func);
%% 
% append and merge or join 2 tables

results = innerjoin(...
    trap, simp, ...
    "Keys", [...
        "n", "x_0", "x_n", "true_value"...
    ]...
);
%% 
% reordering columns

results = results(:, [...
    "n", "h_trap", "h_simp", "x_0", "x_n", ...
    "true_value", "inter_trap", "inter_simp", ...
    "rel_error_trap", "rel_error_simp" ...
]);

%% 
disp(results);
