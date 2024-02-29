---
x: scikit-learn
title: Try scikit-learn in Y minutes
image: /try/scikit-learn/cover.png
lastmod: 2024-02-29
original: https://scikit-learn.org/stable/auto_examples/classification/plot_digits_classification.html
license: BSD-3-Clause
contributors:
    - ["Scikit-learn developers", "https://scikit-learn.org/"]
    - ["Anton Zhiyanov", "https://antonz.org/"]
---

[Scikit-learn](https://scikit-learn.org/) is an open source machine learning library for supervised and unsupervised learning. It provides various tools for model fitting, data preprocessing, model selection, model evaluation, and many other utilities.

This guide introduces the machine learning vocabulary that is used throughout scikit-learn and provides a simple learning example.

[About machine learning](#about-machine-learning) ·
[Loading a dataset](#loading-a-dataset) ·
[Learning and predicting](#learning-and-predicting) ·
[Evaluating results](#evaluating-results) ·
[Further reading](#further-reading)

## About machine learning

In general, a learning problem considers a set of n _samples_ of data and then tries to predict properties of the unknown data. If each sample is more than a single number (e.g., an array), it is said to have multiple attributes or _features_.

One of the most common tasks in machine learning is _classification_. In a classification problem, the samples belong to two or more classes, and we want to learn from already labeled data how to predict the class of unlabeled data.

An example of a classification problem is handwritten digit recognition, where the goal is to assign each input vector (a digit image) to one of a finite number of discrete categories (an actual digit).

<img src="nine.svg" style="display: inline-block; vertical-align: middle; width: 5em;"> → 9

Machine learning is about learning some properties of a dataset and then testing those properties against another dataset. A common practice in machine learning is to evaluate an algorithm by splitting a data set into two:

-   the _training set_, on which we learn some properties;
-   the _testing set_, on which we test the learned properties.

Scikit-learn provides dozens of built-in machine learning algorithms and models, called _estimators_. Each estimator can be fitted to some data using its `fit` method.

## Loading a dataset

Scikit-learn comes with a few standard datasets. In the following example, we load the `digits` dataset:

```python
from sklearn import datasets
digits = datasets.load_digits()
```

<codapi-snippet id="datasets" sandbox="python" editor="basic" output-mode="hidden">
</codapi-snippet>

The digits dataset consists of 8x8 pixel images of digits. The `images` attribute of the dataset stores 8x8 arrays of grayscale values for each image. We will use these arrays to visualize the first 4 images. The `target` attribute of the dataset stores the digit that each image represents (see the titles of the 4 plots below):

```python
_, axes = plt.subplots(nrows=1, ncols=4, figsize=(6, 2))
for ax, image, label in zip(axes, digits.images, digits.target):
    ax.set_axis_off()
    ax.imshow(image, cmap=plt.cm.gray_r, interpolation="nearest")
    ax.set_title("Target: %i" % label)

plt.show()
```

<codapi-snippet sandbox="python" editor="basic" template="pyplot.py" depends-on="datasets" output-mode="svg">
</codapi-snippet>

## Learning and predicting

To apply a classifier on this data, we need to flatten the images by transforming each 2D array of grayscale values from the shape `(8, 8)` to the shape `(64,)`. After that, the whole dataset will be of the shape `(n_samples, n_features)`, where `n_samples` is the number of images and `n_features` is the number of pixels in each image (64).

We can then _split_ the data into training and test subsets and _fit_ a support vector classifier on the training samples. We can then use the fitted classifier to _predict_ the value of the digit for the samples in the test subset:

```python
from sklearn import svm, metrics
from sklearn.model_selection import train_test_split

# Flatten the images
n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))

# Create a classifier: a support vector classifier
clf = svm.SVC(gamma=0.001)

# Split data into 50% train and 50% test subsets
X_train, X_test, y_train, y_test = train_test_split(
    data, digits.target, test_size=0.5, shuffle=False
)

# Learn the digits on the train subset
clf.fit(X_train, y_train)

# Predict the value of the digit on the test subset
predicted = clf.predict(X_test)
```

<codapi-snippet id="classify" sandbox="python" editor="basic" depends-on="datasets" output-mode="hidden">
</codapi-snippet>

Let's visualize the first 4 test samples and show their predicted digit value in the title:

```python
_, axes = plt.subplots(nrows=1, ncols=4, figsize=(6, 2))
for ax, image, prediction in zip(axes, X_test, predicted):
    ax.set_axis_off()
    image = image.reshape(8, 8)
    ax.imshow(image, cmap=plt.cm.gray_r, interpolation="nearest")
    ax.set_title(f"Prediction: {prediction}")

plt.show()
```

<codapi-snippet sandbox="python" editor="basic" template="pyplot.py" depends-on="classify" output-mode="svg">
</codapi-snippet>

Do you agree with the classifier?

## Evaluating results

Classification _metrics_ show how well our classifier does its job of predicting digits from images.

`classification_report` builds a text report showing the main classification metrics:

```python
print(f"Classification report for classifier {clf}:")
print(metrics.classification_report(y_test, predicted))
```

<codapi-snippet sandbox="python" editor="basic" depends-on="classify" output>
</codapi-snippet>

```
Classification report for classifier SVC(gamma=0.001):
              precision    recall  f1-score   support

           0       1.00      0.99      0.99        88
           1       0.99      0.97      0.98        91
           2       0.99      0.99      0.99        86
           3       0.98      0.87      0.92        91
           4       0.99      0.96      0.97        92
           5       0.95      0.97      0.96        91
           6       0.99      0.99      0.99        91
           7       0.96      0.99      0.97        89
           8       0.94      1.00      0.97        88
           9       0.93      0.98      0.95        92

    accuracy                           0.97       899
   macro avg       0.97      0.97      0.97       899
weighted avg       0.97      0.97      0.97       899
```

-   _Precision_ is the ability of the classifier to not label a sample as positive when it is actually negative (e.g., never label a "3" image as "8"). It is calculated as the ratio `tp / (tp + fp)`, where `tp` is the number of true positives and `fp` is the number of false positives. Ranges from 0 (worst) to 1 (best).

-   _Recall_ is the ability of the classifier to find all the positive samples (e.g., to correctly label all "8" images as "8"). It is calculated as the ratio `tp / (tp + fn)`, where `tp` is the number of true positives and `fn` is the number of false negatives. Ranges from 0 (worst) to 1 (best).

-   _F1 score_ combines precision and recall with equal relative contribution. It is the harmonic mean of the precision and recall, calculated as `2 * (precision * recall) / (precision + recall)`. Ranges from 0 (worst) to 1 (best).

-   _Support_ refers to the number of actual occurrences of the class in the dataset. In our case, it's the total number of images that belong to each digit class.

-   _Accuracy_ is the ratio of correct predictions (both true positives and true negatives) among all samples. For a multi-class classification problem (like ours), accuracy gives an overall indication of how often the classifier is correct across all classes.

We can also plot a _confusion matrix_ of the true digit values and the predicted digit values:

```python
disp = metrics.ConfusionMatrixDisplay.from_predictions(y_test, predicted)
disp.figure_.suptitle("Confusion Matrix")
plt.show()
```

<codapi-snippet sandbox="python" editor="basic" template="pyplot.py" depends-on="classify" output-mode="svg">
</codapi-snippet>

Confusion matrix is a table used to evaluate the performance of an algorithm. It shows the actual vs. predicted classifications in a grid format, where each row represents the instances of the actual class, and each column represents the instances of the predicted class.

In our case, the matrix helps in understanding how well the model is identifying digits (0 through 9), by comparing the true labels of the images against the labels predicted by the model. It highlights the true positives, true negatives, false positives, and false negatives for each digit class, aiding in assessing the model's performance across all digit categories.

For example, from the above matrix we can see that:

-   Almost all "6" images were correctly labeled as "6", except for one image mislabeled as "1" (high recall).
-   Almost all "6" labels are true positives, except for one "5" image incorrectly labeled as "6" (high precision).

## Further reading

See the [Tutorials](https://scikit-learn.org/stable/tutorial/index.html) for additional learning resources and the [User Guide](https://scikit-learn.org/stable/user_guide.html) for details on all the features scikit-learn provides.
