%% 
% inputs

n_vect = 1:10;
x_0 = 1;
x_n = 3;

func = @(x) x./(x.^2 + 4);
%% 
% calculations

% variable to store results
results = {};

for n = n_vect
    trap = trapezoidal_rule_function(n, x_0, x_n, func);
    simp = simpson_rule_function(n, x_0, x_n, func);

    % append and merge or join 2 tables
    results{end+1} = innerjoin(...
        trap, simp, ...
        "Keys", [...
            "n", "x_0", "x_n", "true_value"...
        ]...
    );
end
%% 
% merge results

results = vertcat(results{:});
%% 
% reordering columns

results = results(:, [...
    "n", "h_trap", "h_simp", "x_0", "x_n", ...
    "true_value", "inter_trap", "inter_simp", ...
    "rel_error_trap", "rel_error_simp" ...
]);
%% 
disp(results);