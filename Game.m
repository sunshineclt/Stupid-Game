%% before experiment
global w wrect SCREEN_SIZE_INCH VIEW_DISTANCE
[w, wrect] = setUp(true);
cellRects = ArrangeRects(4,...     % the 4 quadrant's coordinate
    [wrect(1), wrect(2), wrect(3) / 2, wrect(4) / 2], wrect);
trialSequence = mod(1:12, 4) + 1;
Shuffle(trialSequence);
% the distance every movement make
distance = deg2pix(1, SCREEN_SIZE_INCH, VIEW_DISTANCE);

% prepare audio
sf = 44100;
t = 0.5;
f = 261.6;
tmp = linspace(0, t, sf * t);
tone = sin(2 * pi * f * tmp);

% prepare react time record
reactTime = zeros(1, 12);

%% step a
DrawFormattedText(w, 'Welcome to the game!\nPress the SPACEBAR to continue', 'center', 'center', [255 255 255]);
Screen('Flip', w);

%% step b
spaceChecker = KeyChecker({'space', false});
spaceChecker.keyboardCheck;

try
%%
for trial = 1:12
    %% step c
    Screen('Flip', w);
    WaitSecs(2);
    fixationPoint = FixationPoint(true, 0.5);
    fixationPoint.center = Point(wrect(3) / 2, wrect(4) / 2);
    fixationPoint.draw();
    Screen('Flip', w);
    WaitSecs(3 + 2.*rand(1));

    %% step d
    oval = Oval(true, 3, 3, [50 50 50]);
    trialCondition = trialSequence(1, trial);
    oval.center = Point((cellRects(trialCondition, 1) + cellRects(trialCondition, 3)) / 2,...
                        (cellRects(trialCondition, 2) + cellRects(trialCondition, 4)) / 2);
    oval.draw();                    
    fixationPoint.draw();
    Screen('Flip', w);
    startTime = GetSecs();
    wasdChecker = KeyChecker({'w', true; 'a', true; 's', true;...
                'd', true; 'space', false; 'escape', false;}, 0.25);
    while true
        keyPressed = wasdChecker.keyboardCheck();
        wasdChecker.lastHitTime = GetSecs;
        switch keyPressed
            case 1
                fixationPoint.center = fixationPoint.center.move(0, -distance);
            case 2
                fixationPoint.center = fixationPoint.center.move(-distance, 0);
            case 3
                fixationPoint.center = fixationPoint.center.move(0, +distance);
            case 4
                fixationPoint.center = fixationPoint.center.move(+distance, 0);
            case 5
                if (oval.contains(fixationPoint.center))
                    Snd('play', tone);
                    break;
                end
            case 6
                error('Escape pressed');
        end
        oval.draw();        
        fixationPoint.draw();
        Screen('Flip', w);
    end
%% step f
    reactTime(1, trial) = GetSecs() - startTime;
end
Screen('Flip', w);
WaitSecs(1);
outString = sprintf('End,Thanks!\nYour average RT is %f', mean(reactTime));
DrawFormattedText(w, outString, 'center', 'center', [255 255 255]);
Screen('Flip', w);
KbWait;
catch err
    
end
%% step h
closeDown();