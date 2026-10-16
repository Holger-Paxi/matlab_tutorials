classdef newton_raphson_script_1 < matlab.apps.App

    % Used to locate and load the app's XML configuration file
    properties (Access = public, Constant)
        AppConfigFilename = './newton_raphson_script_1.xml'; % File path to the app configuration file containing component layout and settings
    end

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        answer                          matlab.ui.control.Label
        UITable                         matlab.ui.control.Table
        sym_dfunc                       matlab.ui.control.Label
        sym_func                        matlab.ui.control.Label
        error_msg                       matlab.ui.control.Label
        closeButton                     matlab.ui.control.Button
        resetButton                     matlab.ui.control.Button
        executeButton                   matlab.ui.control.Button
        equation                        matlab.ui.control.EditField
        equationLabel                   matlab.ui.control.Label
        maxnumberiterations             matlab.ui.control.NumericEditField
        maxnumberiterationsLabel        matlab.ui.control.Label
        errortolerance                  matlab.ui.control.NumericEditField
        errortoleranceLabel             matlab.ui.control.Label
        initialguess                    matlab.ui.control.NumericEditField
        initialguessLabel               matlab.ui.control.Label
        OutputsLabel                    matlab.ui.control.Label
        InputsLabel                     matlab.ui.control.Label
        NewtonRaphsonMethondLabel       matlab.ui.control.Label
        UIAxes_convergence              matlab.ui.control.UIAxes
        UIAxes_func                     matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods

        % Button pushed function: executeButton
        function executeButtonPushed(app, event)
            p0 = app.initialguess.Value;
            tol = app.errortolerance.Value;
            max_iter = app.maxnumberiterations.Value;
            func = str2func(app.equation.Value);

            [p, iter, results, func_sym, dfunc_sym, msg] = ...
                newton_raphson_function(...
                p0, tol, max_iter, func ...
            );

            app.error_msg.Text = msg;
            app.answer.Text = sprintf("root = %f; at iteration = %d", p, iter);
            app.sym_func.Interpreter = 'latex';
            app.sym_func.Text = ['$f(x) = ' latex(func_sym) '$'];
            app.sym_dfunc.Interpreter = 'latex';
            app.sym_dfunc.Text = ['$f''(x) = ' latex(dfunc_sym) '$'];

            app.UITable.Data = results;
            app.UITable.ColumnName = [...
                "iter", "p0", "p", "f_p0", "df_p0", "f_p"...
            ];
            fplot(app.UIAxes_func, func)
            yline(app.UIAxes_func, 0, ':')
            plot(app.UIAxes_convergence, results.iter, abs(results.p - results.p0))
        end

        % Button pushed function: resetButton
        function resetButtonPushed(app, event)
            app.initialguess.Value = 1;
            app.errortolerance.Value = 1e-5;
            app.maxnumberiterations.Value = 100;
            app.equation.Value = "@(x) x.^2 - 4.*x + 4 - log(x)";

            app.error_msg.Text = "";
            app.answer.Text = "";
            app.sym_func.Text = "";
            app.sym_dfunc.Text = "";

            app.UITable.Data = [];
            app.UITable.ColumnName = [];
            cla(app.UIAxes_func)
            cla(app.UIAxes_convergence)
        end

        % Button pushed function: closeButton
        function closeButtonPushed(app, event)
            delete(app)
        end
    end

    % App creation
    methods (Access = public)

        % Construct app
        function app = newton_raphson_script_1(varargin)
            app = app@matlab.apps.App(varargin{:});

            if nargout == 0
                clear app
            end
        end
    end
end