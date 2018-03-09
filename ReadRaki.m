function rakiStruct = ReadRaki(breastTissueType, rakType)

fileNameColumnNo = 1;
tissueTypeColumnNo = 2;
rakTissueTypeColumnNo = 3;
rakTypeColumnNo = 4;
dataFolderName = 'MIAS';
[rakInfoNum, rakInfoTxt, rakInfoRaw] = xlsread('MIAS/list.xlsx');
rakiStruct = [];

for i = 1:length(rakInfoTxt)
    if strcmp(rakInfoTxt(i, tissueTypeColumnNo), breastTissueType) && strcmp(rakInfoTxt(i, rakTissueTypeColumnNo), rakType)
        currentFileNameCell = rakInfoTxt(i, fileNameColumnNo);
        rakiStruct(length(rakiStruct)+1).fileName = [currentFileNameCell{1} '.pgm'];
        currentFileTissueType = rakInfoTxt(i, tissueTypeColumnNo);
        rakiStruct(length(rakiStruct)).tissueType = currentFileTissueType{1};
        currentFileRakTissueType = rakInfoTxt(i, rakTissueTypeColumnNo);
        rakiStruct(length(rakiStruct)).rakTissueType = currentFileRakTissueType{1};
        currentFileRakType = rakInfoTxt(i, rakTypeColumnNo);
        rakiStruct(length(rakiStruct)).rakType = currentFileRakType{1};
        rakiStruct(length(rakiStruct)).image = imread([dataFolderName '/' rakiStruct(length(rakiStruct)).fileName]);
        rakiStruct(length(rakiStruct)).rakCircle = rakInfoNum(i,:);
    end
end

end

