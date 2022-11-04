import numpy as np
import os
import pandas as pd
import csv

import tflite_model_maker

import tensorflow as tf
import tflite_model_maker


cwd = '{}{}'.format(os.getcwd(), '/')
csv_ds = os.path.join(cwd, 'ds.csv')

number_of_lines = 0

with open('{}'.format(csv_ds), 'r') as f:
    reader = csv.reader(f)
    number_of_lines = len(list(reader))

validation_lines = round(0.2 * number_of_lines)
train_lines = number_of_lines - validation_lines

train_ds = pd.read_csv(csv_ds, skiprows=validation_lines, names=['class', 'message'])
validation_ds = pd.read_csv(csv_ds, nrows=validation_lines, names=['class', 'message'])

train_ds = train_ds.to_csv('{}{}'.format(cwd, 'train.csv'))
validation_ds = validation_ds.to_csv('{}{}'.format(cwd, 'val.csv'))

architecture = tflite_model_maker.model_spec.get('mobilebert_classifier')
train_data = tflite_model_maker.text_classifier.DataLoader.from_csv('{}{}'.format(cwd, 'train.csv'), text_column='message', label_column='class', model_spec=architecture, is_training=True)


model = tflite_model_maker.text_classifier.create(train_data, model_spec=architecture, epochs=5)

test_data = tflite_model_maker.text_classifier.DataLoader.from_csv('{}{}'.format(cwd, 'val.csv'), text_column='message', label_column='class', model_spec=architecture, is_training=True)
loss, acc = model.evaluate(test_data)

print(acc)

model.export(export_dir='{}{}'.format(cwd, 'SpamBotModels/'))