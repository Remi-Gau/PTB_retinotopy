function driftingBars(debug, stim, emul)
    % driftingBars(stim, emul, debug)
    %
    % Drifting bars for mapping population receptive fields
    %   Subj :  String with subject ID
    %   Stim :  Stimulus file name e.g. 'Checkerboard'
    %   Emul :  0 = Triggered by scanner, 1 = Trigger by keypress
    
    if nargin < 1 || isempty(debug)
        debug = 1;
    end
    if nargin < 2  || isempty(stim)
        stim = 'Ripples.mat';
    end
    if nargin < 3  || isempty(emul)
        emul = 1;
    end

    initEnv();
    
    %% Experimental Parameters
    
    cfg.task.name = 'retinotopy drifting bar';
    
    % Stimulus type
    cfg.aperture.type = 'bar';
    
    % Stimulus conditions in each block defined by number
    cfg.conditions = [90 45 0 135 270 225 180 315];
    
    %% Set defaults
    
    cfg.stim = stim;
    cfg.debug.do = debug;
    
    if ~emul
        cfg.testingDevice = 'mri';
    else
        cfg.testingDevice = 'pc';
    end
    
    cfg.extraColumns.bar_angle = struct( ...
        'length', 1, ...
        'bids', struct( ...
        'LongName', 'bar angle', ...
        'Description', '', ...
        'Units', 'degrees'));
    
    cfg.extraColumns.bar_width = struct( ...
        'length', 1, ...
        'bids', struct( ...
        'LongName', 'width of the bar', ...
        'Description', '', ...
        'Units', 'degrees'));
    
    cfg.extraColumns.bar_position = struct( ...
        'length', 1, ...
        'bids', struct( ...
        'LongName', '', ...
        'Description', 'bar position with respoect to the fixation cross', ...
        'Units', 'degrees'));
    
    [cfg] = setParameters(cfg);
    
    %% Run the experiment
    barsMapping(cfg);