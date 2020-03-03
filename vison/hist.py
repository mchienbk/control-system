import cv2
import matplotlib.pyplot as plt
#  Load the image
img = cv2.imread('sample.jpg')
img = cv2.resize(img,(250,350))
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
cv2.imshow('gray',gray)

# Calculate Histogram use matpl1otlib
plt.hist(img.ravel(),256,[0,256])
plt.show()

# creating a Histograms Equalization use OpenCV
equ = cv2.equalizeHist(gray) 
cv2.imshow('image', equ)

plt.hist(equ.ravel(),256,[0,256])
plt.show()


