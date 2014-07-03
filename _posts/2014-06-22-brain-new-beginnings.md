---
layout: post
title: "Brain New Beginnings"
date: 2014-06-22 01:00:00
categories: [neural network]
tags: [neuron]
---

**Hello, World!**

Welcome to my new blog, I'm David Clutter, I work as a full time programmer specializing in web based applications, REST, and predictive analytics.
That is enough about me though.

Who are you?
Interesting, please continue...
Great, now that we have gotten the formalities out of the way, lets begin.

I'm currently building an artificial neural network.
Artificial neural networks are one of the places programming looks to biology to find answers to difficult questions.
historically computers have been used very effectively to complete complex tasks much faster than humans possibly could.
On the opposite side, computers have a hard time completing tasks that are considered simple even for young members of our species.
Neural networks can be trained to give the appearance of intelligence in complex spaces,
especially when paired with a genetic algorithm, but lets not get ahead of ourselves.

**The first step in building an artificial neural network is building a `Neuron`, We'll discuss this today.**

Next post: [Coding Neurons]({{"neural network/2014/06/26/coding-neurons/" | prepend: site.baseurl | prepend: site.url}})

The human brain is comprised of roughly 100 billion neurons with 100 trillion connections according this [article](http://www.scientificamerican.com/article/100-trillion-connections/) in Scientific American.
You'd be surprised at how few neurons it actually takes to build a neural network capable of modeling complex spaces.

---

### Biological Neuron

![Neuron](http://training.seer.cancer.gov/images/brain/neuron.jpg)

Image of neuron linked from [cancer.gov](http://training.seer.cancer.gov/images/brain/neuron.jpg)

In our simplified version of a neuron we'll just assume that the `dendrites` represent the inputs, the `cell body` calculates the summation, and the `axon terminals` are the outputs.
The first algorithmic attempt at creating a neuron was call a `perceptron` and was invented by Frank Rosenblatt in 1957 [citation](https://www.zotero.org/tats/items/itemKey/54SFBCZ9).
It has evolved a bit since then but the basic principle is the same.

---

### Artificial Neuron

![Artificial Neuron](/images/artificial-neuron.png)

1. The neuron is given a list of inputs.

2. Performs the dot product of the input and weight lists plus the bias:

    **Equation:** $$ bias + \sum_{i=1}^{n} input_{i} (weight_{i}) $$

3. Uses an activation function to normalize the output:
  * **Linear:** $$ f(x) = x $$
  * **Sigmoid:** $$ f(x) = \frac{1}{1 + e^{-x}} $$
  * **Hyperbolic Tangent:** $$ f(x) = \frac{1 - e^{-2x}}{1 + e^{-2x}} $$

4. Return the output

---

**In the next post we'll begin building the neural network using `Java 8`.**
