#!/bin/bash

# awk -F "," '{print $1}' 17-minute-world-languages.csv > 17-minute-world-languages.sh


FEO=(
mg9501.mp3
mg9502.mp3
mg9503.mp3
mg9504.mp3
mg9505.mp3
mg9506.mp3
mg9507.mp3
mg9508.mp3
mg9509.mp3
mg9510.mp3
mg9511.mp3
mg9512.mp3
mg9513.mp3
mg9514.mp3
mg9515.mp3
mg9516.mp3
mg9517.mp3
mg9518.mp3
mg9519.mp3
mg9520.mp3
mg9524.mp3
mg9525.mp3
mg9526.mp3
mg9527.mp3
mg9762.mp3
mg9763.mp3
mg9764.mp3
mg9765.mp3
mg9767.mp3
mg9768.mp3
mg9769.mp3
mg9770.mp3
mg9771.mp3
mg9845.mp3
mg9846.mp3
mg9847.mp3
mg9848.mp3
mg9849.mp3
mg9850.mp3
mg9851.mp3
mg9852.mp3
mg9853.mp3
mg9854.mp3
mg9855.mp3
mg9856.mp3
mg9857.mp3
mg9858.mp3
mg9859.mp3
mg9860.mp3
mg9861.mp3
mg9862.mp3
mg9863.mp3
mg9864.mp3
mg9865.mp3
mg9866.mp3
mg9867.mp3
mg9868.mp3
mg9869.mp3
mg9870.mp3
mg9871.mp3
mg9872.mp3
mg9873.mp3
mg9874.mp3
mg9875.mp3
mg9876.mp3
mg9877.mp3
)

URL="https://www.17-minute-world-languages.com/audios"

for i in "${FEO[@]}"
do
   echo "curl ${URL}/${i} --output kapila/${i}"
   curl ${URL}/${i} --output kapila/${i}
done
