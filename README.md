# FlavorAI - Intuitive Kitchen Assistant

Welcome to FlavorAI, your smart kitchen companion! FlavorAI is an innovative application that scans your refrigerator, recognizes stored ingredients, and conveniently organizes them. With this information, you can effortlessly generate recipes based on what you have available. Imagine your fridge transforming into a personal assistant, suggesting delightful dishes tailored to your inventory. No more hassle with cookbooks—FlavorAI makes cooking intuitive and inspiring. Welcome to the future of the kitchen, where technology and culinary creativity converge for flavorful discoveries.

## Table of Contents
- [Concept](#concept)
- [Scanning](#scanning)
    - [Object Detection](#object-detection)
    - [Text Recognition](#text-recognition)
- [Generating Recipes](#generating-recipes)

## Concept

FlavorAI is a smart application that scans your refrigerator and recognizes stored ingredients. It cleverly stores these ingredients, allowing you to effortlessly generate recipes based on what you have available. Imagine your refrigerator becoming a personal assistant, suggesting what to cook based on your inventory. No more hassle with cookbooks—FlavorAI makes cooking intuitive and inspiring.

## Scanning

### Object Detection

We initiated this project using Tensorflow for object detection AI, which worked well until encountering issues running Tensorflow on Aron's computer. While temporary solutions were applied, we eventually opted for YOLOv8 for the AI.

With YOLOv8, everything went smoothly. Initially planning to train the AI on our own photos from Delhaize and datasets from the internet, we decided to use only online datasets to save time on labeling.

The training of the model had its ups and downs due to the challenge of verifying every dataset for data quality. The final version of the object detection model can detect a wide range of items.

We also added an endpoint to the Flask API for text recognition, enabling the AI to be used in the app.

### Text Recognition

In our approach, we not only integrate object detection but also utilize text recognition when scanning products. This additional feature is crucial for products in unique packaging from different brands. Users can easily scan text on a package within the app. Captured images are then sent to a simple Flask Python server, where they are processed and analyzed by a text recognition model.

Text recognition is supported by a pipeline system using a MySQL database to store correct word combinations and support multiple languages. See the diagram of the database structure below.

The pipeline works as follows:
- Retrieve all words from the database found in the OCR result.
- Remove shorter words that are part of other found words.
- Remove standalone 'variant' strings if a matching product is recognized.
- Search for remaining products and add appropriate variants (in the same language) in the OCR result.

## Generating Recipes

For recipe generation, we use an external API, namely Spoonacular. The Spoonacular API is a versatile food-related API that provides developers access to a wide range of culinary data and features. It offers detailed information on ingredients, cooking techniques, nutritional values, and more, making it a valuable resource for developing food-related applications, websites, or other digital platforms.
