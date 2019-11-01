% Preprocessing workflow and prefered file organization

% Keep master folders for each animal and then put all recordings and other data in subfolders 
    % Example:  D:\Data\m17\m17_190503_122105
    % Intan will automatically make folders for each recording for the date and time you started the recording 
        % 190503_122105 from the example above was taken on May 3rd, 2019 at 12:21 and 05 seconds (military time is used)
    % You will have to make subfolders yourself for other types of data and it would be best to keep a standard format
        % Example: m17_190614\RSC_2P_images



%% Dependencies %%

% Buzcode package dowloaded off of the buzsaki lab github 
% Buzcode files added to matlab path
% Data files and folders added to matlab path

% amplifier.dat file % Example: base path is 'D:\Data\m17\m17_190503_122105' so files need to be changed to 'm17_190503_122105'.dat
% amplifier.xml file
% analogin.dat file % rename to 'base name'_STIM.dat
% analogin.xml file % rename to 'base name'_STIM.xml
% analog files used for stim times
% probe geometry .xlsx file (adapt/edit Buzsaki base files as needed for new probes) found in Buzsaki github preprocessing folder


%% Make the preprocessing files %% might as well run this as soon as the recording is done
bz_RunAnimalMetadata.m
    % makes animal meta data in animal master file
bz_RunSessionMetadata.m
    
sessionInfo = bz_getSessionInfo
    % makes the sessionInfo.mat file needed for further analysis
bz_LFPfromDat % (make sure to have both basename.dat and basename.xml files) makes .lfp file that bz_GetLFP depends on
    % run this both on amplifier.dat and analogin.dat
[lfp] = bz_GetLFP % either ('all') or ([ specific channels with spaces between ]) 
    % needs to load in as an int16 organization type
    % loads the .lfp recording from the amplifier.dat that ba_LFPfromDat made
[stim_lfp] = bz_GetSTIM %   % either ('all') or ([ specific channels with spaces between ]) 
    % needs to load in as an uint16 organization type
    % loads the .lfp file made for the stim that bz_LFPfromDat made from the analogin.dat file
bz_isLFP(lfp) % or (stim_lfp) to check stim lfp file
    % (check if .lfp is successful, must run bz_GetLFP first to make a variable that is usable for the function)

    
    
%% Metadata files

bz_PreprocessExtracellEphysAnimal % is the function to make animalinfo.mat file and to master animal file not session/ data files
    % make sure the probemaplist has ({''}) around it when calling the file
    % line 194 needs the probe geometry file path 
bz_PreprocessExtracellEphysSession % add to session files to keep track of location coordinates, procedures, etc.


%% Trouble shooting %% 


% This code is from Intan which should make the analogin.dat file trace stays positive but need to cut up the
% make sure to restart matlab before running(TAKES A TON OF RAM)
% Also make sure bz_GetLFP is loading analogin.dat as a uint16 file to make sure the trace looks the best

% http://intantech.com/files/Intan_RHD2000_data_file_formats.pdf % link to the intan pdf that has code to fix loading in data (where the below piece of code came from)

% num_channels = 8; % ADC input info from header file
% fileinfo = dir('m17_190503_122105_STIM.dat');
% num_samples = fileinfo.bytes/(num_channels * 2); % uint16 = 2 bytes
% fid = fopen('m17_190503_122105_STIM.dat', 'r');
% v = fread(fid, [num_channels, num_samples], 'uint16');
% fclose(fid);
% v = v * 0.000050354; % convert to volts





