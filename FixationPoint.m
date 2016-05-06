classdef FixationPoint
    % FIXATIONPOINT is a class taking control of fixation point
    
    properties
        size   % the size of the cross fixation point
        center % the center point of the cross fixation point
        color  % the color of the cross fixation point(e.g. [255 255 255])
        penWidth % the cross fixation point's width
        w      % the screen pointer to be drawn
    end
    
    methods
        function obj = FixationPoint(isDegree, height, width, color, penWidth)
            global SCREEN_SIZE_INCH
            global VIEW_DISTANCE
            global w
            obj.w = w;
            if nargin == 2
                if isDegree
                    translatedHeight = deg2pix(height, SCREEN_SIZE_INCH, VIEW_DISTANCE);
                    obj.size = Size(translatedHeight, translatedHeight);
                else
                    obj.size = Size(height, height);
                end
                obj.color = [255, 255, 255];
                obj.penWidth = 5;
            else
                if isDegree
                    translatedHeight = deg2pix(height, SCREEN_SIZE_INCH, VIEW_DISTANCE);
                    translatedWidth = deg2pix(width, SCREEN_SIZE_INCH, VIEW_DISTANCE);   
                    obj.size = Size(translatedHeight, translatedWidth);
                else
                    obj.size = Size(height, width);
                end
                obj.color = color;
                obj.penWidth = penWidth;
            end
        end
        
        function draw(obj)
            Screen('DrawLine', obj.w, obj.color,...
                                      obj.center.x - obj.size.width / 2,...
                                      obj.center.y,...
                                      obj.center.x + obj.size.width / 2,...
                                      obj.center.y,...
                                      obj.penWidth);
            Screen('DrawLine', obj.w, obj.color,...
                                      obj.center.x,...
                                      obj.center.y - obj.size.height / 2,...                                  
                                      obj.center.x,...
                                      obj.center.y + obj.size.height / 2,...                                  
                                      obj.penWidth);            
        end
        
    end
    
end

