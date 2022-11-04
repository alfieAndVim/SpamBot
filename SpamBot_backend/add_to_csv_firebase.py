import os
import firebase_admin
from firebase_admin import firestore
import csv

cwd = '{}{}'.format(os.getcwd(), '/')
cred_file = os.path.join(cwd, 'spambot-29d19-firebase-adminsdk-jnflz-fd0bb3b4ce.json')
cred = firebase_admin.credentials.Certificate(cred_file)
firebase_admin.initialize_app(cred)
db = firestore.client()


csv_file = os.path.join(cwd, 'ds.csv')
csv_data = []

with open('{}'.format(csv_file), 'r') as f:
    reader = csv.reader(f)
    for i, line in enumerate(reader):
        csv_data.append(line[1])

class document:

    def __init__(self, docID, message, className):

        self.docID = docID
        self.message = message
        self.className = className

    def getDocID(self):
        
        return self.docID

    def getMessage(self):

        return self.message

    def getClassName(self):

        return self.className

documents = []

docs = db.collection(u'messagesStore').stream()
for doc in docs:
    #print(f'{doc.id} => {doc.to_dict()}')
    doc_dictionary = doc.to_dict()
    docID = doc.id
    docMessage = doc_dictionary['message']
    docClassName = doc_dictionary['className']
    
    documentInstance = document(docID, docMessage, docClassName)
    documents.append(documentInstance)

documents_to_analyse = []

for indiv_document in documents:
    class_name = indiv_document.getClassName()
    message = indiv_document.getMessage()

    if message not in csv_data:

        documents_to_analyse.append(indiv_document)

for indiv_document in documents_to_analyse:

    print(indiv_document.getClassName(), indiv_document.getMessage())
    upload = input('Do you want to add this to the dataset? "y" for yes, anything else for no ')
    if upload == 'y':

        print('complete')
        fields = [indiv_document.getClassName(), indiv_document.getMessage()]
        with open('{}'.format(csv_file), 'a') as f:
            writer = csv.writer(f)
            writer.writerow(fields)
            print(indiv_document.getMessage(), 'added')

    document_name = indiv_document.getDocID()
    db.collection(u'messagesStore').document(u'{}'.format(document_name)).delete()
