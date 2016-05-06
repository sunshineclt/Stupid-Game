%% before experiment
global w
global SCREEN_SIZE_INCH
global VIEW_DISTANCE
[w, wrect] = setUp(true);
cellRects = ArrangeRects(4, [wrect(1), wrect(2), wrect(3) / 2, wrect(4) / 2], wrect);
trialSequence = mod(1:12, 4) + 1;
Shuffle(trialSequence);
distance = deg2pix(1, SCREEN_SIZE_INCH, VIEW_DISTANCE);

% setup audio
sf = 44100;
t = 0.5;
f = 261.6;
tmp = linspace(0, t, sf * t);
tone = sin(2 * pi * f * tmp);
a = audioplayer(tone, sf);

% set up react time
reactTime = zeros(1, 12);

%% step a
DrawFormattedText(w, 'Welcome to the game!\nPress the SPACEBAR to continue', 'center', 'center', [255 255 255]);
Screen('Flip', w);

%% step b
spaceChecker = KeyChecker('space');
spaceChecker.waitUntilKeyboardCheck;

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
    wasdChecker = MultiKeyChecker({'w', 'a', 's', 'd', 'space', 'escape'});
    while true
        keyPressed = wasdChecker.keyboardCheckWithDelay(0.25);
        wasdChecker.lastHitTime = GetSecs;
        switch keyPressed
            case 1
                fixationPoint.center.y = fixationPoint.center.y - distance;
                if fixationPoint.center.y < 0
                    fixationPoint.center.y = fixationPoint.center.y + wrect(4);
                end
            case 2
                fixationPoint.center.x = fixationPoint.center.x - distance;
                if fixationPoint.center.x < 0
                    fixationPoint.center.x = fixationPoint.center.x + wrect(3);
                end                
            case 3
                fixationPoint.center.y = fixationPoint.center.y + distance;
                if fixationPoint.center.y > wrect(4)
                    fixationPoint.center.y = fixationPoint.center.y - wrect(4);
                end                
            case 4
                fixationPoint.center.x = fixationPoint.center.x + distance;
                if fixationPoint.center.x > wrect(3)
                    fixationPoint.center.x = fixationPoint.center.x - wrect(3);
                end                     
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