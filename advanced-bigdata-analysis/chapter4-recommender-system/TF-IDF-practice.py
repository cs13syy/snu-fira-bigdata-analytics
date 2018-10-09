# TF-IDF sample
# TF : 현재 문서에서 단어 A가 나타난 횟수
# DF : 모든 문서에서 단어 A가 나타난 총 횟수
# IDF : DF의 역수. 작을수록 중요한 단어.

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import SGDClassifier
sentences = ['This is the first document.',
             'This is the second document.',
             'And the third one.',
             'Is this the first document?']
vect = TfidfVectorizer()
X = vect.fit_transform(sentences)
X.todense()
# print(X.shape)
# print(X)

doc_distances = (X * X.T)
print(doc_distances.toarray())

y = [1,2,3,4]
model = SGDClassifier()
model.fit(X,y)

X_pred = vect.transform(['My new document third'])
y_pred = model.predict(X_pred)
print(y_pred)
