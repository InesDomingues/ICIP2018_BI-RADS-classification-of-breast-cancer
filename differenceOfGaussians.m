function OctaveImageDiff=differenceOfGaussians(img)

[~,~,ColorChannel] = size(img);
if ColorChannel > 1
    img = rgb2gray(img);
end
img = double(img)/255;
ScaleSpaceNum = 1;% 3; % number of scale space intervals
SigmaOrigin = 2^0.5; % default sigma
ScaleFactor = 2^(1/ScaleSpaceNum);
StackNum = ScaleSpaceNum + 3; % number of stacks = number of scale space intervals + 3
OctaveNum = 3;
GaussianFilterSize = 21;
OctaveImage = {OctaveNum,2};%StackNum}; % save the Gaussian-filtered results of image
OctaveImageDiff = {OctaveNum};%StackNum-1}; % save the Difference of Gaussian-filtered results of image

%% Gaussian Convolution of Images in Each Octave
ImgOctave = cell(OctaveNum,1);
for Octave = 1:OctaveNum
    Sigma = SigmaOrigin * 2^(Octave-1); % when up to a new octave, double the sigma
    ImgOctave{Octave} = imresize(img, 2^(-(Octave-1)));
    for s = StackNum-1:StackNum % 1:StackNum
        SigmaScale = Sigma * ScaleFactor^(s-2);
        GaussianFilter = fspecial('gaussian',[GaussianFilterSize,GaussianFilterSize],SigmaScale); % calculate Guassian kernel
        OctaveImage{Octave,s-StackNum+2} = imfilter(ImgOctave{Octave}, GaussianFilter,'symmetric'); % do convolution with Gassian kernel
    end
end

% calculate difference of Gaussian (in original paper eq.1)
count=0;
for Octave = 1:OctaveNum
    for s = 1 %StackNum-1%1:StackNum-1
        OctaveImageDiff{Octave} = OctaveImage{Octave,s+1} - OctaveImage{Octave,s};
        %count=count+1;subplot(OctaveNum,StackNum-1,count); imagesc(OctaveImageDiff{Octave,s}); colormap gray; axis equal; title(['Octave = ' num2str(Octave) '; s = ' num2str(s)])
    end
end