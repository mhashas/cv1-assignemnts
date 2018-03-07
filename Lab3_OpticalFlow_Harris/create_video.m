function create_video(image_set_name, image_ext, name_0_padding, image_range)
%example should be pingpong or person_toy

outputVideo = VideoWriter(fullfile('',strcat(image_set_name, '.avi')));

outputVideo.FrameRate = 10;  % Default 30
open(outputVideo)

for i = 2:image_range
    image = imread(strcat(image_set_name, '_tracking/', pad(num2str(i), name_0_padding, 'left','0'), '.', image_ext));    
    writeVideo(outputVideo,image)
end

close(outputVideo)
end