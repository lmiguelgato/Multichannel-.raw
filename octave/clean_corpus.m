close all
clear
clc

filename2delete1 = '3mics.raw';
filename2delete2 = '3mics.wav';
main_path = '/media/lmiguelgato/DATA/corpus aira';

files = dir();
dirFlags = [files.isdir] & ~strcmp({files.name},'.') & ~strcmp({files.name},'..');
subFolders = files(dirFlags);

for k = 1 : length(subFolders)
  cd(subFolders(k).name)
  files = dir();
  dirFlags = [files.isdir] & ~strcmp({files.name},'.') & ~strcmp({files.name},'..');
  subFolders1 = files(dirFlags);
  for j = 1 : length(subFolders1)
    cd(subFolders1(j).name)
    files = dir();
    dirFlags = [files.isdir] & ~strcmp({files.name},'.') & ~strcmp({files.name},'..');
    subFolders2 = files(dirFlags);
    for i = 1 : length(subFolders2)
      cd(subFolders2(i).name)
      files = dir();
      dirFlags = [files.isdir] & ~strcmp({files.name},'.') & ~strcmp({files.name},'..');
      subFolders3 = files(dirFlags);
      for h = 1 : length(subFolders3)        
        cd(subFolders3(h).name)
        if exist(filename2delete1, 'file') == 2
             disp(['Deleting ' strcat(subFolders(k).name, '/', subFolders1(j).name, '/', subFolders2(i).name, '/', subFolders3(h).name, '/', filename2delete1) ' ...'])
             delete(filename2delete1)             
        end
        if exist(filename2delete2, 'file') == 2
             disp(['Deleting ' strcat(subFolders(k).name, '/', subFolders1(j).name, '/', subFolders2(i).name, '/', subFolders3(h).name, '/', filename2delete2) ' ...'])
             delete(filename2delete2)             
        end
        %disp(strcat(subFolders(k).name, '/', subFolders1(j).name, '/', subFolders2(i).name, '/', subFolders3(h).name, ' was cleaned'))
        cd ('..')
      end
      cd (strcat(main_path, '/', subFolders(k).name, '/', subFolders1(j).name))
    end
    cd ('..')
  end
  cd ('..')
end
disp('Done!')