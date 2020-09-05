
import pandas as pd
df_csv = pd.read_csv("crompton_CFL_records.csv")
df = pd.DataFrame(df_csv)
df = df[df.Voltage != 0]
df = df[df.Current != 0]
total = 0
for time in df.index:
    t = df['Time Stamp'][time]
    least_time= t.split(':')
    total += int(least_time[2])
total = int(total/60)
if total <= 23:
    print("The device run for : "+str(total)+" Hrs")
    rating = 1
elif total <= 8760 and total >= 24:
    total = int(total/24)
    if total == 1:
        print("The device run for :"+str(total)+" Day")
        rating == 2
    else:
        print("The device run for : "+str(total)+" Days")
        if total<90:
        	rating = 4
        elif total >= 90 and total<= 183:
        	rating = 8
        else:
        	rating = 9

print("Rating : "+str(rating))



    
