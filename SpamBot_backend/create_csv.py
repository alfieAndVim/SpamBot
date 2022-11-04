import os
import csv
import random

cwd = '{}{}'.format(os.getcwd(), '/')
print(os.getcwd())
csv_file = os.path.join(cwd, 'ds.csv')

def write_csv(data):
    with open(csv_file, 'w') as f:
        
        writer = csv.writer(f)
        writer.writerows(data)
    

rows = []

category_path = os.path.join(cwd, 'spam_text_ds/')
for category in os.listdir(category_path):

    if category != '.DS_Store':

        txt_files_path = os.path.join(category_path, category)
        txt_files_path = '{}{}'.format(txt_files_path, '/')

        for txt_file in os.listdir(txt_files_path):
            txt_file_path = os.path.join(txt_files_path, txt_file)
            
            with open(txt_file_path, 'r') as t:
                line = t.readline()
                rows.append([category, line])
    
    print(category)

random.shuffle(rows)
write_csv(rows)
