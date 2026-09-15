%% 
% inputs

n_vect = 1:10;
x_0_vect = [-2, 1, 1];
x_n_vect = [2, 2, 3];

func_vect = {...
    @(x) (x.^3).*exp(x), ...
    @(x) x.*log(x), ...
    @(x) x./(x.^2 + 4) ...
};
%% 
% counter or indices to loop

ind_vect = 1:length(func_vect);
%% 
% calculations

% variable to store total results
tot_results = {};
for ind = ind_vect

    % temporary result
    results = {};
    % pick the function and inputs
    x_0 = x_0_vect(ind);
    x_n = x_n_vect(ind);
    func = func_vect{ind};

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

    % merge results into a single table
    results = vertcat(results{:});
    % reorder the columns
    results = results(:, [...
        "n", "h_trap", "h_simp", "x_0", "x_n", ...
        "true_value", "inter_trap", "inter_simp", ...
        "rel_error_trap", "rel_error_simp" ...
    ]);

    % store the results
    tot_results{end+1} = results;

end
%% 
% display results

for k = 1:numel(tot_results)
    disp(tot_results{k});
end