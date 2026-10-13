classdef runge_kutta_script < matlab.apps.App

    % Used to locate and load the app's XML configuration file
    properties (Access = public, Constant)
        AppConfigFilename = './runge_kutta_script.xml'; % File path to the app configuration file containing component layout and settings
    end

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        closeButton                     matlab.ui.control.Button
        UITable                         matlab.ui.control.Table
        resetButton                     matlab.ui.control.Button
        executeButton                   matlab.ui.control.Button
        distcondition                   matlab.ui.control.NumericEditField
        distconditionLabel              matlab.ui.control.Label
        timecondition                   matlab.ui.control.NumericEditField
        timeconditionLabel              matlab.ui.control.Label
        endtime                         matlab.ui.control.NumericEditField
        endtimeLabel                    matlab.ui.control.Label
        initialtime                     matlab.ui.control.NumericEditField
        initialtimeLabel                matlab.ui.control.Label
        stepsize                        matlab.ui.control.NumericEditField
        stepsizeLabel                   matlab.ui.control.Label
        functionhandle                  matlab.ui.control.EditField
        functionhandleLabel             matlab.ui.control.Label
        InputsLabel                     matlab.ui.control.Label
        UIAxes                          matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods

        % Button pushed function: executeButton
        function executeButtonPushed(app, event)
            func = str2func(app.functionhandle.Value);

            h = app.stepsize.Value;
            t = app.initialtime.Value:h:app.endtime.Value;

            % t0 = app.timecondition.Value;
            y0 = app.distcondition.Value;

            y = zeros(size(t));
            y(1) = y0;

            results = table();

            for iter = 1:length(t)-1
                t0 = t(iter);
                y0 = y(iter);

                k1 = func(t0, y0);
                k2 = func(t0 + h/2, y0 + h*k1/2);
                k3 = func(t0 + h/2, y0 + h*k2/2);
                k4 = func(t0 + h, y0 + h*k3);
                y1 = y0 + h*(k1 + 2*k2 + 2*k3 + k4)/6;

                y(iter+1) = y1;

                results(end+1,:) = table( ...
                    iter, t0, y0, y1, k1, k2, k3, k4 ...
                    );
            end

            app.UITable.Data = results;
            app.UITable.ColumnName = [...
                "iter", "t0", "y0", "y1", "k1", "k2", "k3", "k4"...
            ];
            plot(app.UIAxes, results.t0, results.y0)
        end

        % Button pushed function: resetButton
        function resetButtonPushed(app, event)
            app.functionhandle.Value = '@(t,y) t+y';
            app.stepsize.Value = 0.1;
            app.initialtime.Value = 0;
            app.endtime.Value = 0.2;
            app.timecondition.Value = 0;
            app.distcondition.Value = 1;
            app.UITable.Data = [];
            cla(app.UIAxes);
        end

        % Button pushed function: closeButton
        function closeButtonPushed(app, event)
            delete(app)
        end
    end

    % App creation
    methods (Access = public)

        % Construct app
        function app = runge_kutta_script(varargin)
            app = app@matlab.apps.App(varargin{:});

            if nargout == 0
                clear app
            end
        end
    end
end