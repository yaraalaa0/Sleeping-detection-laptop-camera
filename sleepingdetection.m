clear('cam');
snapaphoto=5;
webcamlist;
cam=webcam;
pause(4);
preview (cam)
fprintf('open your eyes')
[y,Fs] = audioread('D:\\Open.m4a');
sound(y,Fs)
%read the audi file from the attached files(open.m4a)
%a reference photo taken from the user before 
%running the program (while openning his/her eyes)
pause(5)
IO1=snapshot(cam);
fprintf('close you eyes');
[y1,Fs1] = audioread('D:\Zc fall 2015\computer science\project\sleeping detection\close.m4a');
sound(y1,Fs1);%a reference photo taken from the user before 
%running the program (while closing his/her eyes)

pause(5)
[y2,Fs2] = audioread('D:\Zc fall 2015\computer science\project\sleeping detection\Thankyou.m4a');
sound(y2,Fs2)

IC1=snapshot(cam);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IO2=rgb2gray(IO1);
EyeDetect = vision.CascadeObjectDetector('EyePairBig'); %this funcyion can detect the eyes and 
%make a rectangle around the eye region 
BB=step(EyeDetect,IO2);
[rr cc]=size(BB);
if rr~=1
    BB=BB(1,:); %when the number of rows in BB is not equal to one. the rectangle function
    %returns error and terminate the program.
end
rect=rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
M = imcrop(IO2, BB); % Crop box BB out of image "I".
se=strel('disk',12); %a filter to make a disk light spot around eye region  
K=imtophat(M,se);
K=imadjust(K);
K=double(K);
K=im2bw(K,0.5); %to convert the image to black and white
so=max(sum(K')) %the row with the maximum summation in the image 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IC2=rgb2gray(IC1); %convert the image to its gray scale 
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB2=step(EyeDetect,IC2);
rect=rectangle('Position',BB2,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
M2= imcrop(IC2, BB2); % Crop box BB out of image "I".
se2=strel('disk',12);
K2=imtophat(M2,se2);
K2=imadjust(K2);
K2=double(K2);
K2=im2bw(K2,0.5);
sc=max(sum(K2'))
threshold=(so+sc)/2; % we assumed that if the summation of the row with maximum summation 
%exceeded the threshold value the user is openning his eyes, otherwise s/he
%is closing their eyes%
BBB=BB;
count=0;
while( snapaphoto==5)
img = snapshot(cam);
 
img=rgb2gray(img);
EyeDetect = vision.CascadeObjectDetector('EyePairBig'); %this funcyion can detect the eyes and 
%make a rectangle around the eye region 
BBB2=step(EyeDetect,img);
[rrr ccc]=size(BBB2);
if rrr==1
     %when the number of rows in BBB is not equal to one. the rectangle function
    %returns error and terminate the program.
    BBB=BBB2;
end
recta=rectangle('Position',BBB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
MM = imcrop(img, BBB); % Crop box BB out of image "I".
see=strel('disk',12); %a filter to make a disk light spot around eye region  
KK=imtophat(MM,see);
KK=imadjust(KK);
KK=double(KK);
KK=im2bw(KK,0.5); %to convert the image to black and white
soo=max(sum(KK')) %the row with the maximum summation in the image 

if soo>threshold
    disp('awake')
    count=0;
else
    disp('sleeping')
    count=count+1;
end
if count==5
    disp('wake up!')
    %the_path_to_alarm_audio_file
    [y10,Fs10] = audioread('D:\Zc fall 2015\computer science\project\sleeping detection\Wake up.m4a');
sound(y10,Fs10)
end
imshow(img)
pause(3);
end

