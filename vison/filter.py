import cv2
import numpy as np
#  Load the image
img = cv2.imread('sample.jpg')
img = cv2.resize(img,(250,350))
cv2.imshow('sample',img)
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
cv2.imshow('gray',gray)

kernel = np.ones((1,1),np.uint8)

# guassian blur
guassian = cv2.GaussianBlur(gray,(5,5),cv2.BORDER_DEFAULT)
cv2.imshow('guassian',guassian)

# medianBlur
median = cv2.medianBlur(gray, 13)
cv2.imshow('median',median)

kernel = np.ones((5,5),np.uint8)
# Erosion
erosion = cv2.erode(gray,kernel,iterations = 1)
cv2.imshow('erosion',erosion)

# Dilation
dilation = cv2.dilate(gray,kernel,iterations = 1)
cv2.imshow('dilation',dilation)

# Opening
opening = cv2.morphologyEx(gray, cv2.MORPH_OPEN, kernel)
cv2.imshow('opening',opening)

# Closing
closing = cv2.morphologyEx(gray, cv2.MORPH_CLOSE, kernel)
cv2.imshow('closing',closing)

# Morphological Gradient
gradient = cv2.morphologyEx(gray, cv2.MORPH_GRADIENT, kernel)
cv2.imshow('gradient',gradient)

cv2.waitKey(0)
