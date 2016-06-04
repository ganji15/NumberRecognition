function traj2img(traj)
    if nargin < 1
        imshow(zeros([65,65]));
        return
    end
    
    m = length(traj(:, 1));

	im_nlsize=[65,65];
	grey_im=zeros(im_nlsize);
	grey_im=double(grey_im);
    
    for i = 1 : m
        grey_im(traj(i,2),traj(i,1))=1;
    end
    grey_im = flipud(grey_im);
    
	imshow(grey_im);
end