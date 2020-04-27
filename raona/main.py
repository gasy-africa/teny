# https://machinelearningmastery.com/clean-text-machine-learning-python/


import wordcloud
import numpy as np
from matplotlib import pyplot as plt
from IPython.display import display
import fileupload
import io
import sys
import re
import string

def _file_upload():

   f=open("baiboly.txt", "r")

   global file_contents
   file_contents = f.read()
   print('Uploaded `{}` ({:.2f} kB)'.format( file_contents, len(file_contents) / 2 **10))

_file_upload()

def calculate_frequencies(file_contents):
    # Here is a list of punctuations and uninteresting words you can use to process your text
    uninteresting_words = ["ny", "ary", "dia", "ho", "hoe", "aoka", "sy", "fa", "samy", "eny", "ao", "efa", "i", "izay", \
    "saha", "toa", "tsy", "ka", "no", "faha", "na", "ianao", "izay", "izy", "izaho", "hoy", "amin", "an", "koa", "amby", \
    "tahiny", "tamiko", "taminy", "amiko", "kosa", "teo"]
    
    # LEARNER CODE START HERE

    doc = file_contents.replace('\n', '~')
    words = doc.split(" ")

    
    # Strip punctuation
    table = str.maketrans('', '', string.punctuation)
    print(string.punctuation)
    stripped = [w.translate(table) for w in words]
    print(stripped[:100])

    tmpDict = {}

    # making dict for counting frequencies
    for text in stripped:
        if re.match("|".join(uninteresting_words), text):
            continue
        val = tmpDict.get(text, 0)
        tmpDict[text.lower()] = val + 1

    
    #wordcloud
    cloud = wordcloud.WordCloud()
    cloud.generate_from_frequencies(tmpDict)
    return cloud.to_array()

myimage = calculate_frequencies(file_contents)
myimage = calculate_frequencies(file_contents)
plt.imshow(myimage, interpolation = 'nearest')
plt.axis('off')
plt.show()
