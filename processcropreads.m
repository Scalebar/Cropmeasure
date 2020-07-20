%Process crop data 
Resultstable=readtable('/home/ian/Downloads/Cropimages/Colourallears.csv');
Whitebalance=table2array(Resultstable(25:30,:)); % White card areas
Meanbalance=mean(Whitebalance,1);
Pixelreadings=table2array(Resultstable(1:24,:));
Difpixels=Pixelreadings-Meanbalance;
writetable(Difpixels,"/home/ian/Downloads/Cropimages/Colourallears.csv");

