function create_video(example)
%example should be pingpong or person_toy

if strcmp(example, 'person_toy')
    padding = 8;
    extension = '.jpg';
    read_folder = 'person_toy_tracking/';
    start_loop = 2;
    end_loop = 104;
    outputVideo = VideoWriter(fullfile('','person_toy.avi'));
else
    padding = 4;
    extension = '.jpeg';
    read_folder = 'pingpong_tracking/';
    start_loop = 1;
    end_loop = 52;
    outputVideo = VideoWriter(fullfile('','pingpong.avi'));
end

outputVideo.FrameRate = 10;  % Default 30
open(outputVideo)

for i = start_loop:end_loop
    image = imread(strcat(read_folder, pad(num2str(i), padding, 'left','0'), extension));    
    writeVideo(outputVideo,image)
end

close(outputVideo)
end