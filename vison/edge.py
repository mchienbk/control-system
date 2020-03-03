import numpy as np
import cv2
from scipy import ndimage

def non_max_suppression(img, D):
    M, N = img.shape
    Z = np.zeros((M,N), dtype=np.int32)
    angle = D * 180. / np.pi
    angle[angle < 0] += 180

    
    for i in range(1,M-1):
        for j in range(1,N-1):
            try:
                q = 255
                r = 255
                
               #angle 0
                if (0 <= angle[i,j] < 22.5) or (157.5 <= angle[i,j] <= 180):
                    q = img[i, j+1]
                    r = img[i, j-1]
                #angle 45
                elif (22.5 <= angle[i,j] < 67.5):
                    q = img[i+1, j-1]
                    r = img[i-1, j+1]
                #angle 90
                elif (67.5 <= angle[i,j] < 112.5):
                    q = img[i+1, j]
                    r = img[i-1, j]
                #angle 135
                elif (112.5 <= angle[i,j] < 157.5):
                    q = img[i-1, j-1]
                    r = img[i+1, j+1]

                if (img[i,j] >= q) and (img[i,j] >= r):
                    Z[i,j] = img[i,j]
                else:
                    Z[i,j] = 0

            except IndexError as e:
                pass
    
    return Z


def threshold(img, lowThresholdRatio=0.05, highThresholdRatio=0.09):
    
    highThreshold = img.max() * highThresholdRatio;
    lowThreshold = highThreshold * lowThresholdRatio;
    
    M, N = img.shape
    res = np.zeros((M,N), dtype=np.int32)
    
    weak = np.int32(25)
    strong = np.int32(255)
    
    strong_i, strong_j = np.where(img >= highThreshold)
    zeros_i, zeros_j = np.where(img < lowThreshold)
    
    weak_i, weak_j = np.where((img <= highThreshold) & (img >= lowThreshold))
    
    res[strong_i, strong_j] = strong
    res[weak_i, weak_j] = weak
    
    return (res, weak, strong)

def hysteresis(img, weak, strong=255):
    M, N = img.shape  
    for i in range(1, M-1):
        for j in range(1, N-1):
            if (img[i,j] == weak):
                try:
                    if ((img[i+1, j-1] == strong) or (img[i+1, j] == strong) or (img[i+1, j+1] == strong)
                        or (img[i, j-1] == strong) or (img[i, j+1] == strong)
                        or (img[i-1, j-1] == strong) or (img[i-1, j] == strong) or (img[i-1, j+1] == strong)):
                        img[i, j] = strong
                    else:
                        img[i, j] = 0
                except IndexError as e:
                    pass
    return img

def main():
    # Load Image
    img = cv2.imread('sample.jpg')
    img = cv2.resize(img,(250,350))
    cv2.imshow('sample',img)
    # Gray converter
    gray = cv2.cvtColor(img,cv2.COLOR_RGB2GRAY)
    cv2.imshow('gray',gray)

    # Applying GaussianBlur filter
    gauss = cv2.GaussianBlur(gray,(7,7),cv2.BORDER_DEFAULT)
    cv2.imshow('gaussian',gauss) 

    # Applying medianBlur filter
    mean = cv2.medianBlur(gauss,3)
    cv2.imshow('mean',mean) 

    # Applying the sobel filter
    sobel=cv2.Sobel(mean,cv2.CV_64F,1,1,ksize=3)
    cv2.imshow('sobel',sobel) 

    # Applying the canny filter
    edges = cv2.Canny(mean, 50, 40)
    cv2.imshow('edges',edges) 

    linesP = cv2.HoughLinesP(edges, 1, np.pi / 180, 10, None, 5, 10)
    print(linesP)

    out = img.copy()
    if linesP is not None:
        for i in range(0, len(linesP)):
            l = linesP[i][0]
            cv2.line(out, (l[0], l[1]), (l[2], l[3]), (0,255,0), 1, cv2.LINE_4)
    cv2.imshow('out',out) 
    
if __name__ == '__main__':
    main()
    cv2.waitKey(0)
