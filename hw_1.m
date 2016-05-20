function varargout = hw_1(varargin)
% hw_1 MATLAB code for hw_1.fig
%      hw_1, by itself, creates a new hw_1 or raises the existing
%      singleton*.
%
%      H = hw_1 returns the handle to a new hw_1 or the handle to
%      the existing singleton*.
%
%      hw_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in hw_1.M with the given input arguments.
%
%      hw_1('Property','Value',...) creates a new hw_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hw_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hw_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hw_1

% Last Modified by GUIDE v2.5 27-Mar-2012 19:47:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hw_1_OpeningFcn, ...
                   'gui_OutputFcn',  @hw_1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before hw_1 is made visible.
function hw_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hw_1 (see VARARGIN)

% Choose default command line output for hw_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hw_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hw_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos=num2str(get(handles.slider1,'Value'));
set(handles.edit2,'String',pos);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FN PN] = uigetfile({'*.*', 'Picture (*.*)'}, 'Open File');
handles.imSrc1 = imread([PN, FN]); 
handles.imSrc1 = imresize(handles.imSrc1,[512,512]);
axes(handles.axes4);     
imshow(handles.imSrc1);

ftxt=fopen([PN, FN,'.txt'],'r');
if ftxt ~= -1
    Points1 =fscanf(ftxt,'%d %d',[2 inf]);
    Points1 =Points1';
    fclose(ftxt);
    setappdata(gcf, 'img1Points', Points1);
    Points=Points1;
    hold on
    for i=0:12
        Pvalue= 1+i*2;
        Qvalue= 2+i*2;
        flag=0;
        if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
            plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
            flag =flag+1;
        end
        if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
            plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
            flag =flag+1;
        end
        if flag ==2
            pqx= [Points(Pvalue,1) Points(Qvalue,1)];
            pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
            plot(pqx,pqy,'LineWidth',3);
        end
    end
    hold off   
end

guidata(hObject, handles)
setappdata(gcf, 'FN1', FN);
setappdata(gcf, 'PN1', PN);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FN PN] = uigetfile({'*.*', 'Picture (*.*)'}, 'Open File');
handles.imSrc2 = imread([PN, FN]);
handles.imSrc2 = imresize(handles.imSrc2,[512,512]);
axes(handles.axes7);     
imshow(handles.imSrc2); 

ftxt=fopen([PN, FN,'.txt'],'r');
if ftxt ~= -1
    Points2 =fscanf(ftxt,'%d %d',[2 inf]);
    Points2 =Points2';
    fclose(ftxt);
    setappdata(gcf, 'img2Points', Points2);    
    Points=Points2;
    hold on
    for i=0:12
        Pvalue= 1+i*2;
        Qvalue= 2+i*2;
        flag=0;
        if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
            plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
            flag =flag+1;
        end
        if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
            plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
            flag =flag+1;
        end
        if flag ==2
            pqx= [Points(Pvalue,1) Points(Qvalue,1)];
            pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
            plot(pqx,pqy,'LineWidth',3);
        end
    end
    hold off    
end

guidata(hObject, handles)
setappdata(gcf, 'FN2', FN);
setappdata(gcf, 'PN2', PN);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%imshow(handles.imSrc1)
%pause(5)
%imshow(handles.imSrc2)
oriImg1 =handles.imSrc1;
oriImg2 =handles.imSrc2;

Points1 = getappdata(gcf, 'img1Points');
Points2 = getappdata(gcf, 'img2Points');
autoflag = get(handles.checkbox1,'Value');

va = str2double(get(handles.edit3,'String'));
vb = str2double(get(handles.edit4,'String'));
vp = str2double(get(handles.edit5,'String'));

if autoflag ==1
    runcount = 10;
    if ~exist('result', 'dir')
            mkdir('result');
    end
    outputpath =['.\result\' num2str(va) '_' num2str(vb) '_' num2str(vp) '_' num2str(0) '.jpg']   ; 
    imwrite(uint8(oriImg1),outputpath);
    outputpath =['.\result\' num2str(va) '_' num2str(vb) '_' num2str(vp) '_' num2str(1) '.jpg']   ; 
    imwrite(uint8(oriImg2),outputpath);
else
    runcount =2;
end
for times=1:runcount-1
    mixPoints=zeros(26,2);
    if autoflag ==1
        value = times/runcount
    else
        value=str2double(get(handles.edit2,'String'));
    end
    for i=1:26
        mixPoints(i,1) = value*Points2(i,1) + (1-value)*Points1(i,1);
        mixPoints(i,2) = value*Points2(i,2) + (1-value)*Points1(i,2);
    end


    axes(handles.axes6);
    tempImg=zeros(512,512,3);
    imshow(tempImg);
    hold on
    for i=0:12  
            Pvalue= 1+i*2;
            Qvalue= 2+i*2;
            pqx= [mixPoints(Pvalue,1) mixPoints(Qvalue,1)];
            pqy= [mixPoints(Pvalue,2) mixPoints(Qvalue,2)]; 
            plot(pqx,pqy,'LineWidth',3);
    end
    hold off
    %開始對圖一做warping存成圖一bar
    pause(1)
    % image(高,寬,channel)
    destImg1=zeros(512,512,3);
    for h=1:512
        if mod(h,100)==0
            fprintf('>>');
        end
        for w=1:512        
            DSUM =0;
            weightsum =0;
            X = [w h];
            for i=0:12            
                Pvalue= 1+i*2;
                Qvalue= 2+i*2;
                P= mixPoints(Pvalue,:);
                Q= mixPoints(Qvalue,:);
                Pbar=Points1(Pvalue,:);
                Qbar= Points1(Qvalue,:);

                u= dot(X-P,Q-P) / (norm(Q-P)^2);
                v= dot(X-P,Perpendicular(Q-P)) / norm(Q-P);
                Xbar = Pbar +u*(Qbar-Pbar)+ v *Perpendicular(Qbar-Pbar)/norm(Qbar-Pbar);
                D = Xbar-X;
                if u < 0
                    dist =  norm(X-P);                
                elseif u > 1
                    dist =  norm(X-Q);           
                else % 1>u>0
                    dist = abs(v);
                end
                orilength = norm(Q-P);
                weight = (orilength^vp/(va+dist))^vb;
                DSUM = DSUM + D*weight;
                weightsum =weightsum +weight;
            end
            Xbar =X +DSUM/weightsum;

            findx =Xbar(1);
            findy =Xbar(2);
            if findx<1
                findx=1;
            elseif findx>512
                findx=512;
            end       
            if findy<1
                findy=1;       
            elseif findy>512
                findy=512;
            end
            % floor 下界 ceil 上界

           nowdiff = findy - floor(findy);            
           temp1 = nowdiff*oriImg1(ceil(findy),ceil(findx),:) + (1-nowdiff)*oriImg1(floor(findy),ceil(findx),:) ;
           temp2 = nowdiff*oriImg1(ceil(findy),floor(findx),:) + (1-nowdiff)*oriImg1(floor(findy),floor(findx),:) ;
           nowdiff = findx - floor(findx);            
           destImg1(h,w,:) = nowdiff*temp1+(1-nowdiff)*temp2;

        end
    end
    disp('img1 warping end');
    axes(handles.axes4);     
    imshow(uint8(destImg1));
    hold on
    for i=0:12  
            Pvalue= 1+i*2;
            Qvalue= 2+i*2;
            pqx= [mixPoints(Pvalue,1) mixPoints(Qvalue,1)];
            pqy= [mixPoints(Pvalue,2) mixPoints(Qvalue,2)]; 
            plot(pqx,pqy,'LineWidth',3);
    end
    hold off
    %開始對圖二做warping存成圖二bar
    % image(高,寬,channel)
    destImg2=zeros(512,512,3);
    for h=1:512
        if mod(h,100)==0
           fprintf('>>');
        end
        for w=1:512        
            DSUM =0;
            weightsum =0;
            X = [w h];
            for i=0:12            
                Pvalue= 1+i*2;
                Qvalue= 2+i*2;
                P= mixPoints(Pvalue,:);
                Q= mixPoints(Qvalue,:);
                Pbar=Points2(Pvalue,:);
                Qbar= Points2(Qvalue,:);

                u= dot(X-P,Q-P) / (norm(Q-P)^2);
                v= dot(X-P,Perpendicular(Q-P)) / norm(Q-P);
                Xbar = Pbar +u*(Qbar-Pbar)+ v *Perpendicular(Qbar-Pbar)/norm(Qbar-Pbar);
                D = Xbar-X;
                if u < 0
                    dist =  norm(X-P);                
                elseif u > 1
                    dist =  norm(X-Q);           
                else % 1>u>0
                    dist = abs(v);
                end
                orilength = norm(Q-P);
                weight = (orilength^vp/(va+dist))^vb;
                DSUM = DSUM + D*weight;
                weightsum =weightsum +weight;
            end
            Xbar =X +DSUM/weightsum;

            findx =Xbar(1);
            findy =Xbar(2);
             if findx<1
                findx=1;
            elseif findx>512
                findx=512;
            end       
            if findy<1
                findy=1;       
            elseif findy>512
                findy=512;
            end
            % floor 下界 ceil 上界

           nowdiff = findy - floor(findy);            
           temp1 = nowdiff*oriImg2(ceil(findy),ceil(findx),:) + (1-nowdiff)*oriImg2(floor(findy),ceil(findx),:) ;
           temp2 = nowdiff*oriImg2(ceil(findy),floor(findx),:) + (1-nowdiff)*oriImg2(floor(findy),floor(findx),:) ;
           nowdiff = findx - floor(findx);            
           destImg2(h,w,:) = nowdiff*temp1+(1-nowdiff)*temp2;

        end
    end
    disp('img2 warping end');
    axes(handles.axes7);    
    imshow(uint8(destImg2));
    hold on
    for i=0:12  
            Pvalue= 1+i*2;
            Qvalue= 2+i*2;
            pqx= [mixPoints(Pvalue,1) mixPoints(Qvalue,1)];
            pqy= [mixPoints(Pvalue,2) mixPoints(Qvalue,2)]; 
            plot(pqx,pqy,'LineWidth',3);
    end
    hold off
    %兩張圖疊加
    %value
    resultImg = value*destImg2+(1-value)*destImg1;
    axes(handles.axes6); 
    imshow(uint8(resultImg));
    if ~exist('result', 'dir')
            mkdir('result');
    end
    outputpath =['.\result\' num2str(va) '_' num2str(vb) '_' num2str(vp) '_' num2str(value) '.jpg'];
    imwrite(uint8(resultImg),outputpath);
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
value=str2double(get(handles.edit2,'String'));
if value >=0 &&value<=1
set(handles.slider1,'Value',value);
end
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
a= (get(handles.listbox2,'Value'));
Points = getappdata(gcf, 'img1Points');
axes(handles.axes4);
imshow(handles.imSrc1);  
hold on
for i=0:12
    Pvalue= 1+i*2;
    Qvalue= 2+i*2;
    flag=0;
    if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
        plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
        flag =flag+1;
    end
    if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
        plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
        flag =flag+1;
    end
    if flag ==2
        pqx= [Points(Pvalue,1) Points(Qvalue,1)];
        pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
        plot(pqx,pqy,'LineWidth',3);
    end
end
plot(Points(a,1),Points(a,2),'or','MarkerSize',7,'MarkerFaceColor', 'r' );
hold off

[xx,yy,button]=ginput(1);
if button ==1  && xx<512 && xx>0 && yy<512 && yy>0 
Points(a,1) = uint32(xx);
Points(a,2) = uint32(yy);
imshow(handles.imSrc1);  
hold on 
for i=0:12
    Pvalue= 1+i*2;
    Qvalue= 2+i*2;
    flag=0;
    if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
        plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
        flag =flag+1;
    end
    if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
        plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
        flag =flag+1;
    end
    if flag ==2
        pqx= [Points(Pvalue,1) Points(Qvalue,1)];
        pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
        plot(pqx,pqy,'LineWidth',3);
    end
end
plot(Points(a,1),Points(a,2),'or','MarkerSize',7,'MarkerFaceColor', 'r' );
hold off      
setappdata(gcf, 'img1Points', Points);
end
  

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

listS=cellstr('1');
for i=1:13
    temps = ['P' num2str(i)];
    listS = [listS;temps]; 
    temps = ['Q' num2str(i)];
    listS = [listS;temps];
end
listS=listS(2:length(listS));
set(hObject,'String',listS);
Points=zeros(26,2);
setappdata(gcf, 'img1Points', Points);


% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3
a= (get(handles.listbox3,'Value'));
Points = getappdata(gcf, 'img2Points');
axes(handles.axes7);
imshow(handles.imSrc2);  
hold on
for i=0:12
    Pvalue= 1+i*2;
    Qvalue= 2+i*2;
    flag=0;
    if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
        plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
        flag =flag+1;
    end
    if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
        plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
        flag =flag+1;
    end
    if flag ==2
        pqx= [Points(Pvalue,1) Points(Qvalue,1)];
        pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
        plot(pqx,pqy,'LineWidth',3);
    end
end
plot(Points(a,1),Points(a,2),'or','MarkerSize',7,'MarkerFaceColor', 'r' );
hold off

[xx,yy,button]=ginput(1);
if button ==1 && xx<512 && xx>0 && yy<512 && yy>0 
Points(a,1) = uint32(xx);
Points(a,2) = uint32(yy);
imshow(handles.imSrc2);  
hold on 
for i=0:12
    Pvalue= 1+i*2;
    Qvalue= 2+i*2;
    flag=0;
    if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
        plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
        flag =flag+1;
    end
    if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
        plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
        flag =flag+1;
    end
    if flag ==2
        pqx= [Points(Pvalue,1) Points(Qvalue,1)];
        pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
        plot(pqx,pqy,'LineWidth',3);
    end
end
plot(Points(a,1),Points(a,2),'or','MarkerSize',7,'MarkerFaceColor', 'r' );
hold off      
setappdata(gcf, 'img2Points', Points);
end



% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

listS=cellstr('1');
for i=1:13
    temps = ['P' num2str(i)];
    listS = [listS;temps]; 
    temps = ['Q' num2str(i)];
    listS = [listS;temps];
end
listS=listS(2:length(listS));
set(hObject,'String',listS);
Points=zeros(26,2);
setappdata(gcf, 'img2Points', Points);



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Points1 = getappdata(gcf, 'img1Points');
FN =getappdata(gcf, 'FN1');
PN =getappdata(gcf, 'PN1');
filepath = [PN FN '.txt'];
fd=fopen(filepath,'w');
for i=1:length(Points1)
fprintf(fd,'%d %d\n',Points1(i,1),Points1(i,2));
end
fclose(fd);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Points2 = getappdata(gcf, 'img2Points');
FN =getappdata(gcf, 'FN2');
PN =getappdata(gcf, 'PN2');
filepath = [PN FN '.txt'];
fd=fopen(filepath,'w');
for i=1:length(Points2)
fprintf(fd,'%d %d\n',Points2(i,1),Points2(i,2));
end
fclose(fd);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes4); 
ftxt=fopen(['standard' '.txt'],'r');
if ftxt ~= -1
    Points1 =fscanf(ftxt,'%d %d',[2 inf]);
    Points1 =Points1';
    fclose(ftxt);
    setappdata(gcf, 'img1Points', Points1);
    Points=Points1;
    hold on
    for i=0:12
        Pvalue= 1+i*2;
        Qvalue= 2+i*2;
        flag=0;
        if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
            plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
            flag =flag+1;
        end
        if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
            plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
            flag =flag+1;
        end
        if flag ==2
            pqx= [Points(Pvalue,1) Points(Qvalue,1)];
            pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
            plot(pqx,pqy,'LineWidth',3);
        end
    end
    hold off   
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes7); 
ftxt=fopen(['standard' '.txt'],'r');
if ftxt ~= -1
    Points2 =fscanf(ftxt,'%d %d',[2 inf]);
    Points2 =Points2';
    fclose(ftxt);
    setappdata(gcf, 'img2Points', Points2);
    Points=Points2;
    hold on
    for i=0:12
        Pvalue= 1+i*2;
        Qvalue= 2+i*2;
        flag=0;
        if Points(Pvalue,1)~=0 && Points(Pvalue,2)~=0
            plot(Points(Pvalue,1),Points(Pvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'b');
            flag =flag+1;
        end
        if Points(Qvalue,1)~=0 && Points(Qvalue,2)~=0
            plot(Points(Qvalue,1),Points(Qvalue,2),'o-','MarkerSize',5,'MarkerFaceColor', 'g');
            flag =flag+1;
        end
        if flag ==2
            pqx= [Points(Pvalue,1) Points(Qvalue,1)];
            pqy= [Points(Pvalue,2) Points(Qvalue,2)]; 
            plot(pqx,pqy,'LineWidth',3);
        end
    end
    hold off   
end