% This script solves the gravitional free-fall problem using the
% in-built ODE45 function

% d2y/dt2 = -g
% d2y/dt2 + 0*dy/dt + 0*y = -g
% y'' + 0*y' + 0*y = -g

% state vector
% x1 = y
% x2 = y'
% x3 = y'' We are not going to use it

% dx1/dt = x2
% dx2/dt = -g ----> dx2/dt = -g - 0*x2 - 0*x1

% X = [ ...
%       x1
%       x2
%     ];

function dXdt = free_fall_ODE(t, X)
    g = 9.81;

    x1 = X(1);   % y
    x2 = X(2);   % y'

    dXdt = [x2; g];
end
%%
tspan = [0, 10]; % or 0:0.1:10
% for t = 0, y(0) = 0 ----> height
% for t = 0, y'(0) = 0 ---> velocity
y(1) = 0;
y(2) = 0;

[t, Y] = ode45(@free_fall_ODE, tspan, y);
%%
tab = [t, Y];
tab = array2table( ...
    tab, "VariableNames", ["time", "height", "velocity"] ...
);
disp(tab)
%%
%%% Plot the solutions
tplot = linspace(0,10);

figure;

y_t = 0.5*9.81*tplot.^2;
plot(tplot,y_t,'r');
hold on;
xlabel('Time (seconds)');
ylabel('Displacement (m)');

y_numerical = Y(:,1); % height
plot(t,y_numerical,'bo');
hold off
%%
% This script solves the gravitional free-fall problem using the
% in-built ODE45 function

%%% User inputs
tspan = [0 10]; % time span (in seconds) for our solution
g = 9.81; % gravitational acceleration
u(1) = 0; % first initial condition
u(2) = 0; % second initial condition

%%% Solve ODE
[t,u] = ode45(@freeFallODE,tspan,[u(1); u(2)]);
%%
tab2 = [t, u];
tab2 = array2table( ...
    tab2, "VariableNames", ["time", "heighy", "velocity"] ...
);
disp(tab2)
%%
%%% Plot the solutions
tplot = linspace(0,10);

figure;

x_t = 0.5*g*tplot.^2;
plot(tplot,x_t,'r');
hold on;
xlabel('Time (seconds)');
ylabel('Displacement (m)');

x_numerical = u(:,1);
plot(t,x_numerical,'bo');
%%
% This function defines the ODE we want to solve with ODE45 in Matlab
function dudt = freeFallODE(t,u)

g = 9.81; % gravitational acceleration

dudt = [u(2); g];

end