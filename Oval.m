classdef Oval
    % OVAL is a class taking control of an oval object
    
    properties
        size   % the size of the cross fixation point
        center % the center point of the cross fixation point
        color  % the color of the cross fixation point(e.g. [255 255 255])
        w      % the screen pointer to be drawn
    end
    
    methods
        function obj = Oval(isDegree, height, width, color)
            global SCREEN_SIZE_INCH
            global w
            obj.w = w;
            if nargin == 2
                if isDegree
                    translatedHeight = deg2pix(height, SCREEN_SIZE_INCH, 60);
                    obj.size = Size(translatedHeight, translatedHeight);
                else
                    obj.size = Size(height, height);
                end
                obj.color = [255, 255, 255];
            else
                if isDegree
                    translatedHeight = deg2pix(height, SCREEN_SIZE_INCH, 60);
                    translatedWidth = deg2pix(width, SCREEN_SIZE_INCH, 60);   
                    obj.size = Size(translatedHeight, translatedWidth);
                else
                    obj.size = Size(height, width);
                end
                obj.color = color;
            end
        end
        
        function draw(obj)
            Screen('FillOval', obj.w, obj.color,...
                                     [obj.center.x - obj.size.width / 2,...
                                      obj.center.y - obj.size.height / 2,...
                                      obj.center.x + obj.size.width / 2,...
                                      obj.center.y + obj.size.height / 2]);
        end
       
        function isContain = contains(obj, point)
            if sqrt(power(obj.center.x - point.x, 2) + ...
                    power(obj.center.y - point.y, 2))...
                    < obj.size.width / 2
                isContain = true;
            else
                isContain = false;
            end
        end
        
    end
    
end

