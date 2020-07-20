
Directory=('/home/ian/Downloads/Cropimages/');
%Directorycount=dir(fullfile(Directory,'/*.tif*')); % Number of frames in directory
%Numberoffiles=numel(Directorycount);
Numregions=30;
TempImagein=imread('/home/ian/Downloads/Ears1to24.tif');

%correct weird Tif format
Imagein(:,:,1)=TempImagein(:,:,1);
Imagein(:,:,2)=TempImagein(:,:,2);
Imagein(:,:,3)=TempImagein(:,:,3);

imshow(Imagein);

    %Remove saturated pixels
    Imagemask=(Imagein>254); %locate all pixel 255 or over
    
    Imagemask=sum(Imagemask,3); %Flatten RGB elements
    Imagemask=imcomplement(Imagemask); %Flip mask binary
    Imagemask=repmat(Imagemask, [1, 1, 3]);% Make mask RGB compatible
    Imagein(~Imagemask) = 0; % Apply Mask
   
  
       
    for Count=1:Numregions
        
        Regiontest=drawrectangle;
        Square=imcrop(Imagein,(Regiontest.Position));
        [Redratio,Greenratio,Blueratio,Redabsolute,Greenabsolute,Blueabsolute,Area]=Croppixelratio(Square);
        
        Tableout=table(Count,Redratio,Greenratio,Blueratio,Redabsolute,Greenabsolute,Blueabsolute,Area);
        
       
        if Flag==0 && Count==1
            Resultstable=Tableout;
        else
            Resultstable=[Resultstable;Tableout];
            
        end
    Flag=1;
    end
%end

Resultstable.Properties.VariableNames = { 'Region' 'Red Ratio' 'Green Ratio' 'Blue Ratio' 'Red average' 'Green average' 'Blue average' 'Area'};
writetable(Resultstable,"/home/ian/Downloads/Cropimages/Colourallears.csv");
Whitebalance=table2array(Resultstable(25:30,:)); % White card areas
Meanbalance=mean(Whitebalance,1);
Pixelreadings=table2array(Resultstable(1:24,:));
Difpixels=Pixelreadings-Meanbalance;
writetable(Difpixels,"/home/ian/Downloads/Cropimages/Colourallearsdif.csv");
