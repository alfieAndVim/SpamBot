##program to add new data to dataset and re-train model with new data

import os
import csv

remove_cache = []

print('*****Program to add aditional text files to dataset and re-train model*****')

current_working_dir = '{}{}'.format(os.getcwd(), '/')
dataset_dir = os.path.join(current_working_dir, 'spam_text_ds/')
legit_dir = os.path.join(dataset_dir, 'legit/')
spam_dir = os.path.join(dataset_dir, 'spam/')


def getCurrentDSCount():
    sub_count_legit = 0
    for _ in os.listdir(legit_dir):
        sub_count_legit += 1

    sub_count_spam = 0
    for _ in os.listdir(spam_dir):
        sub_count_spam += 1

    total_count = sub_count_legit + sub_count_spam

    return total_count

print('There are currently {} files in the dataset'.format(getCurrentDSCount()))


allowed_characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 '


def standardiseText(sentence):
    data = str(sentence)
    temp_data = ''
    for character in data:
        if character in allowed_characters:
            temp_data += character
    return temp_data

def getLastFileCount(type):

    last_name = 0

    if type == 'legit':
        for file in os.listdir(legit_dir):
            temp_last_name = file
            temp_last_name = os.path.splitext(temp_last_name)[0]
            if int(temp_last_name) > last_name:
                last_name = int(temp_last_name)
        
    elif type == 'spam':
        for file in os.listdir(spam_dir):
            temp_last_name = file
            temp_last_name = os.path.splitext(temp_last_name)[0]
            if int(temp_last_name) > last_name:
                last_name = int(temp_last_name)

    
    return last_name


def addNewData(data, type):
    
    last_file_count = 0

    if type == 'legit':
        last_file_count = getLastFileCount('legit')
        last_file_count += 1

        filename = os.path.join(legit_dir, '{}.txt'.format(last_file_count))
        remove_cache.append(filename)
        with open(filename, 'w') as legit_file:
            legit_file.write(data)

        fields = [type, data]
        csv_file = os.path.join(current_working_dir, 'ds.csv')
        with open('{}'.format(csv_file), 'a') as f:
            writer = csv.writer(f)
            writer.writerow(fields)

    elif type == 'spam':
        last_file_count = getLastFileCount('spam')
        last_file_count += 1
    
        filename = os.path.join(spam_dir, '{}.txt'.format(last_file_count))
        remove_cache.append(filename)
        with open(filename, 'w') as legit_file:
            legit_file.write(data)

        fields = [type, data]
        csv_file = os.path.join(current_working_dir, 'ds.csv')
        with open('{}'.format(csv_file), 'a') as f:
            writer = csv.writer(f)
            writer.writerow(fields)

    



finished = False

while finished == False:
    check = True
    while check:
        new_spam_data = input('Please enter the text for the new set of spam data --> ')
        new_spam_data = standardiseText(new_spam_data)
        usr_check = input('Are you sure this is spam data? Enter "y" for yes, anything else for no. ')
        if usr_check == 'y' or usr_check == 'Y':
            check = False
        else:
            print('Try again')

    check = True
    while check:
        new_legit_data = input('Please enter the text for the new set of legit data --> ')
        new_legit_data = standardiseText(new_legit_data)
        usr_check = input('Are you sure this is legit data? Enter "y" for yes, anything else for no. ')
        if usr_check == 'y' or usr_check == 'Y':
            check = False
        else:
            print('Try again')

    addNewData(new_spam_data, 'spam')
    addNewData(new_legit_data, 'legit')
    
    usr_finished = input('Have you finished adding data? Enter "y" for yes, anything else for no. ')
    if usr_finished == 'y' or usr_finished == 'Y':
        finished = True
    

print('There are currently {} files in the dataset'.format(getCurrentDSCount()))