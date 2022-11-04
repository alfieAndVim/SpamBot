import turicreate as tc
import os
import pandas as pd

cwd = '{}{}'.format(os.getcwd(), '/')
csv_ds = os.path.join(cwd, 'ds.csv')

data = pd.read_csv(csv_ds, header=None, delimiter=',', encoding='ISO-8859-1', usecols=(0, 1))

data = tc.SFrame(data)
print(data)

training_data, test_data = data.random_split(0.8)
print(training_data)

model = tc.text_classifier.create(training_data, '0', features=['1'])

prediction = model.predict(test_data)
print(prediction)

model.export_coreml(os.path.join(cwd, 'spamBotModel.mlmodel'))