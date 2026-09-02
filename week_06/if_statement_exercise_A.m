% clear, clc

hours = 25;

if hours > 40
    fprintf("You get overtime!\n");
elseif hours < 40
    fprintf("You don't get overtime\n");
elseif hours == 40
    fprintf("No overtime?\n");
else
    fprintf("something wrong?\n");
end
