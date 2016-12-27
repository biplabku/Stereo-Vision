# Stereo-Vision
Computer vision is an important field of research wherein the techniques attempt to model the visual environment in using various mathematical model. Stereo vision is an area within the field that addresses the problem of reconstruction of 3D coordinate of points for depth estimation. In a stereo system two cameras are placed horizontally and the images acquired by the system are then processed for recovering visual depth information. The disparity map represents pixels that are horizontally shifted between the left and the right image. In this project, we present two methods of mapping disparity in stereo system images.

Block Matching
Most important concept in block matching is using the sum of squared differences in finding the best match possible among the 2 images.
             Algorithmic steps -  
1) Converting the image into grayscale.
2) Selecting a block size for block matching
3) To compute SSD we select a block size of 3X3 initially from one image and same size of image pixels in the other image. And next we compute their pixel wise differences and add them to get a single value and save them to an array.
4) We do step 3 for some range defined by the highest value of the ground truth image. And after that we select the minimum value and it’s position out of the array having the SSD values. Minimum the value better is the similarity between the pixels.
5) After finding the best approximation or the best similarity that is having the minimum value, we put the difference between the location of the pixel in one image to the location of the best match pixel location in the other image (That is basically their column differences since they are rectified images.)
6) We do the above steps for the whole image. While doing so we encounter the boundary conditions so in that case we have padded the image according to the block size selected so that for any block size the code can find the depth estimation. 


Dynamic Programming
Numerous methods of implementation for stereo vision disparity mapping have been established in the past few years. Broadly speaking, disparity map algorithms can be classified into two categories - local or global approaches [2]. In the local approach, also known as window based approach, disparity is computed at any pixel depending on the intensity values within a predefined window. Such method considers only the local information and therefore have low computational complexity. Global approach treats disparity mapping as a problem of minimizing an objective global energy function. Such approach usually produces good results but are computationally expensive and are impractical for real time systems.
