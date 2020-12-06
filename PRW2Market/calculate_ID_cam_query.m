function ID_cam = calculate_ID_cam_query(query_dir)

query_files = dir([query_dir '*.jpg']);
% calculate the ID of all the detected boxes
ID_cam = [];
for n = 1:length(query_files)
    if round(n/1000) == n/1000
        fprintf('Query frame ID is %d \n',n);
    end
    query_name = query_files(n).name;
    ID = str2double(query_name(1:3));
    cam = str2double(query_name(6));
    ID_cam = [ID_cam; [ID, cam]];
end
